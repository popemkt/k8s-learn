# Understanding Kubernetes Network Policies

Network Policies are like firewalls in Kubernetes, allowing you to control the traffic flow between pods using rules based on labels, namespaces, and IP blocks.

## Key Concepts

1. **Default Behavior**
   - By default, all pods can communicate with any other pod
   - Network policies are additive (they add restrictions)
   - If any policy selects a pod, that pod will be isolated and only allow traffic explicitly permitted by policies

2. **Policy Types**
   - Ingress: Controls incoming traffic
   - Egress: Controls outgoing traffic

3. **Selectors**
   - podSelector: Which pods the policy applies to
   - namespaceSelector: Which namespaces the policy applies to
   - ipBlock: Which IP CIDR ranges are allowed/denied

## Example Scenarios

Let's create some practical examples to demonstrate network policies.

### 1. Basic Network Isolation

First, let's create some sample applications to work with:

[app-deployment.yaml](app-deployment.yaml)

### 2. Restrict Incoming Traffic (Ingress)

This policy only allows incoming traffic to web-app pods from pods labeled 'app: api':

```yaml
# web-policy-ingress.yaml
apiVersion: networking.k8s.io/v1
kind: NetworkPolicy
metadata:
  name: web-allow-api
spec:
  podSelector:
    matchLabels:
      app: web
  policyTypes:
  - Ingress
  ingress:
  - from:
    - podSelector:
        matchLabels:
          app: api
    ports:
    - protocol: TCP
      port: 80
```

### 3. Restrict Outgoing Traffic (Egress)

This policy only allows api-app pods to make outgoing connections to web-app pods and DNS:

```yaml
# api-policy-egress.yaml
apiVersion: networking.k8s.io/v1
kind: NetworkPolicy
metadata:
  name: api-egress-policy
spec:
  podSelector:
    matchLabels:
      app: api
  policyTypes:
  - Egress
  egress:
  - to:
    - podSelector:
        matchLabels:
          app: web
    ports:
    - protocol: TCP
      port: 80
  # Allow DNS resolution
  - to:
    ports:
    - protocol: UDP
      port: 53
    - protocol: TCP
      port: 53
```

### 4. Combined Ingress and Egress Policy

Here's a more complex policy that combines both ingress and egress rules:

```yaml
# combined-policy.yaml
apiVersion: networking.k8s.io/v1
kind: NetworkPolicy
metadata:
  name: restricted-policy
spec:
  podSelector:
    matchLabels:
      app: web
  policyTypes:
  - Ingress
  - Egress
  ingress:
  - from:
    - podSelector:
        matchLabels:
          app: api
    - namespaceSelector:
        matchLabels:
          purpose: monitoring
    ports:
    - protocol: TCP
      port: 80
  egress:
  - to:
    - ipBlock:
        cidr: 10.0.0.0/24
        except:
        - 10.0.0.1/32
    ports:
    - protocol: TCP
      port: 5978
```

## Testing Network Policies

To test if your network policies are working:

1. Create test pods:
```bash
kubectl run test-web --image=nginx --labels=app=web
kubectl run test-api --image=nginx --labels=app=api
```

2. Test connectivity:
```bash
# Test from api pod to web pod
kubectl exec test-api -- curl http://test-web

# Test from web pod to api pod
kubectl exec test-web -- curl http://test-api
```

## Best Practices

1. **Start Restrictive**
   - Begin with denying all traffic
   - Gradually add necessary permissions
   - Document why each rule exists

2. **Label Strategy**
   - Use meaningful labels
   - Be consistent with labeling
   - Consider using multiple labels for fine-grained control

3. **Testing**
   - Test policies in a non-production environment first
   - Verify both allowed and denied traffic paths
   - Include DNS access in egress policies

4. **Monitoring**
   - Monitor dropped connections
   - Keep track of policy changes
   - Regular policy audits

## Common Issues and Solutions

1. **DNS Resolution Fails**
   - Ensure UDP/TCP port 53 is allowed in egress policies
   - Check namespace labels if using namespace selectors

2. **Unexpected Blocking**
   - Verify pod labels match policy selectors
   - Check for conflicting policies
   - Ensure all necessary ports are allowed

3. **Policy Not Working**
   - Confirm network policy support is enabled in the cluster
   - Verify policy syntax
   - Check if multiple policies might conflict

Remember: Network Policies are namespace-scoped and require a network plugin that supports them (like Calico or Weave).
