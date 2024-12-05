# Understanding Service Accounts in Kubernetes

A Service Account is an identity for processes running in a Pod to authenticate with the Kubernetes API server. Think of it as a way to give Pods an identity and control what they can and cannot do within the cluster.

## Key Points About Service Accounts

1. **Default Behavior**
   - Every namespace has a default service account named "default"
   - Kubernetes automatically mounts the default service account to pods if no service account is specified
   - The default service account has very limited permissions

2. **Use Cases**
   - When pods need to interact with the Kubernetes API
   - For applications that need to authenticate with external services
   - To implement RBAC (Role-Based Access Control) for pods
   - In CI/CD pipelines where pods need specific permissions

## Creating and Using Service Accounts

### Basic Service Account Creation
```bash
kubectl create serviceaccount my-service-account
```

### Using Service Account in Pod
```yaml
apiVersion: v1
kind: Pod
metadata:
  name: my-pod
spec:
  serviceAccountName: my-service-account
  containers:
  - name: my-container
    image: my-image
```

### Viewing Service Account Details
```bash
# List service accounts
kubectl get serviceaccounts

# View details of a specific service account
kubectl describe serviceaccount my-service-account
```

## Service Account Tokens

When a service account is created, Kubernetes automatically:
1. Creates a token (stored as a Secret)
2. Mounts this token into pods using the service account
3. Places it at `/var/run/secrets/kubernetes.io/serviceaccount/token`

## Best Practices

1. **Principle of Least Privilege**
   - Create specific service accounts for different applications
   - Grant only the permissions necessary for the application to function
   - Avoid using the default service account for applications

2. **Security**
   - Regularly rotate service account tokens
   - Use RBAC to limit service account permissions
   - Disable auto-mounting of service account tokens if not needed

3. **Organization**
   - Use meaningful names for service accounts
   - Document the purpose and permissions of each service account
   - Keep service accounts namespace-scoped when possible

## Example: Creating a Service Account with Specific Permissions

```yaml
# Create a Service Account
apiVersion: v1
kind: ServiceAccount
metadata:
  name: pod-reader
  namespace: default

---
# Create a Role
apiVersion: rbac.authorization.k8s.io/v1
kind: Role
metadata:
  name: pod-reader-role
  namespace: default
rules:
- apiGroups: [""]
  resources: ["pods"]
  verbs: ["get", "watch", "list"]

---
# Bind the Role to the Service Account
apiVersion: rbac.authorization.k8s.io/v1
kind: RoleBinding
metadata:
  name: pod-reader-binding
  namespace: default
subjects:
- kind: ServiceAccount
  name: pod-reader
  namespace: default
roleRef:
  kind: Role
  name: pod-reader-role
  apiGroup: rbac.authorization.k8s.io
```

This example creates a service account that can only read pod information in its namespace.
