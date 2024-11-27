# Kubernetes Quick Reference - Resource Generation Commands

This guide provides quick commands for generating base YAML templates for various Kubernetes resources using `kubectl`.

## Setting up kubectl alias
```bash
# Add this to your ~/.bashrc or ~/.zshrc
alias k='kubectl'

# Then either restart your terminal or run
source ~/.bashrc  # or source ~/.zshrc
```
Note: All commands below can use `k` instead of `kubectl` after setting up the alias.

## Basic Syntax
```bash
kubectl create <resource> <name> [flags] --dry-run=client -o yaml
```
The `--dry-run=client` flag ensures the resource isn't actually created, and `-o yaml` outputs the resource definition in YAML format.

## Core Resources

### Pod
```bash
# Basic pod
kubectl run nginx --image=nginx --dry-run=client -o yaml

# Pod with specific port
kubectl run nginx --image=nginx --port=80 --dry-run=client -o yaml
```

### Deployment
```bash
# Basic deployment
kubectl create deployment nginx --image=nginx --dry-run=client -o yaml

# Deployment with replicas
kubectl create deployment nginx --image=nginx --replicas=3 --dry-run=client -o yaml
```

### Service
```bash
# ClusterIP Service
kubectl create service clusterip nginx --tcp=80:80 --dry-run=client -o yaml

# NodePort Service
kubectl create service nodeport nginx --tcp=80:80 --dry-run=client -o yaml

# LoadBalancer Service
kubectl create service loadbalancer nginx --tcp=80:80 --dry-run=client -o yaml
```

### ConfigMap
```bash
# From literal values
kubectl create configmap app-config --from-literal=key1=value1 --from-literal=key2=value2 --dry-run=client -o yaml

# From file
kubectl create configmap app-config --from-file=path/to/file.conf --dry-run=client -o yaml
```

### Secret
```bash
# Generic secret from literal values
kubectl create secret generic app-secret --from-literal=username=admin --from-literal=password=secret123 --dry-run=client -o yaml

# TLS secret
kubectl create secret tls tls-secret --cert=path/to/cert.crt --key=path/to/key.key --dry-run=client -o yaml
```

### Job
```bash
# Basic job
kubectl create job my-job --image=busybox -- /bin/sh -c "echo hello" --dry-run=client -o yaml

# CronJob
kubectl create cronjob my-cronjob --image=busybox --schedule="*/1 * * * *" -- /bin/sh -c "echo hello" --dry-run=client -o yaml
```

### Namespace
```bash
kubectl create namespace my-namespace --dry-run=client -o yaml
```

### ServiceAccount
```bash
kubectl create serviceaccount my-service-account --dry-run=client -o yaml
```

### Ingress
```bash
# Basic ingress
kubectl create ingress my-ingress --rule="foo.com/path=service:port" --dry-run=client -o yaml
```

## Advanced Resources

### Role and RoleBinding
```bash
# Create role
kubectl create role pod-reader --verb=get,list,watch --resource=pods --dry-run=client -o yaml

# Create rolebinding
kubectl create rolebinding pod-reader-binding --role=pod-reader --user=jane --dry-run=client -o yaml
```

### ClusterRole and ClusterRoleBinding
```bash
# Create clusterrole
kubectl create clusterrole pod-reader --verb=get,list,watch --resource=pods --dry-run=client -o yaml

# Create clusterrolebinding
kubectl create clusterrolebinding pod-reader-binding --clusterrole=pod-reader --user=jane --dry-run=client -o yaml
```

## Tips

1. Add `-n <namespace>` to create resources in a specific namespace
2. Use `--help` with any command to see additional options
3. Combine the output with redirection to create YAML files:
   ```bash
   kubectl create deployment nginx --image=nginx --dry-run=client -o yaml > deployment.yaml
   ```

## Additional Flags

- `--port`: Specify container port
- `--replicas`: Set number of replicas
- `--image-pull-policy`: Set the image pull policy
- `--serviceaccount`: Specify service account
- `--env`: Set environment variables
- `--labels`: Add labels to the resource
