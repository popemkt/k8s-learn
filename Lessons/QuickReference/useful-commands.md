# Useful Kubernetes Commands

This quick reference guide contains commonly used Kubernetes commands for various operations.

## Cluster Information
```bash
# Get cluster information
kubectl cluster-info

# Get API versions supported by the server
kubectl api-versions

# Get API resources
kubectl api-resources

# Check component status
kubectl get componentstatuses
```

## Node Operations
```bash
# Get node information
kubectl get nodes
kubectl describe node <node-name>

# Mark node as unschedulable/schedulable
kubectl cordon <node-name>
kubectl uncordon <node-name>

# Drain node (safely evict all pods)
kubectl drain <node-name>
```

## Pod Operations
```bash
# Get pod logs
kubectl logs <pod-name>
kubectl logs <pod-name> -p # Previous instance logs (that might've crashed)
kubectl logs -f <pod-name>  # Follow logs
kubectl logs <pod-name> -c <container-name>  # For multi-container pods

# Execute command in pod
kubectl exec -it <pod-name> -- /bin/bash
kubectl exec <pod-name> -- <command>

# Copy files to/from pod
kubectl cp <pod-name>:/path/to/remote/file /path/to/local/file
kubectl cp /path/to/local/file <pod-name>:/path/to/remote/file
```

## Troubleshooting
```bash
# Debug with temporary pod
kubectl run -it --rm debug --image=busybox -- sh

# Port forwarding
kubectl port-forward <pod-name> <local-port>:<pod-port>

# Show metrics
kubectl top nodes
kubectl top pods

# Get events
kubectl get events --sort-by='.metadata.creationTimestamp'
```

## Configuration and Security
```bash
# Show current context
kubectl config current-context

# Switch context
kubectl config use-context <context-name>

# Show cluster configuration
kubectl config view

# Create service account
kubectl create serviceaccount <name>

# Create/manage secrets
kubectl create secret generic <secret-name> --from-literal=key=value
kubectl get secrets
kubectl describe secret <secret-name>
```

## Resource Management
```bash
# Scale resources
kubectl scale deployment <deployment-name> --replicas=<number>

# Rollout commands
kubectl rollout status deployment/<deployment-name>
kubectl rollout history deployment/<deployment-name>
kubectl rollout undo deployment/<deployment-name>

# Auto-scaling
kubectl autoscale deployment <deployment-name> --min=2 --max=5 --cpu-percent=80
```

## Cleanup Operations
```bash
# Delete resources
kubectl delete pod <pod-name> --grace-period=0 --force
kubectl delete namespace <namespace-name> --grace-period=0 --force

# Delete all resources in current namespace
kubectl delete all --all

# Clean up terminated pods
kubectl delete pods --field-selector status.phase=Failed --all-namespaces
```

## Advanced Commands
```bash
# JSON output with specific fields
kubectl get pods -o=jsonpath='{.items[*].metadata.name}'

# Custom columns output
kubectl get pods -o=custom-columns=NAME:.metadata.name,STATUS:.status.phase

# Sort output
kubectl get pods --sort-by='.metadata.creationTimestamp'

# Watch resources
kubectl get pods --watch
```

Remember to replace `<placeholder-values>` with actual values when using these commands. Add `--namespace=<namespace>` to commands when working with resources in specific namespaces.
