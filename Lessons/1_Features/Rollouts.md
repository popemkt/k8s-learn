# Understanding Kubernetes Rollouts

Rollouts in Kubernetes manage how updates to Deployments are handled. They provide controlled, gradual transitions from one version of your application to another, ensuring zero-downtime updates when configured properly.

## Key Concepts

1. **Deployment Strategy**
   - RollingUpdate (default): Gradually replaces old pods with new ones
   - Recreate: Terminates all existing pods before creating new ones

2. **Revision History**
   - Kubernetes maintains a history of deployment revisions
   - Allows rolling back to previous versions if needed

## Common Rollout Commands

### 1. Check Rollout Status
```bash
kubectl rollout status deployment/my-app
```
This shows the progress of your deployment update.

### 2. View Rollout History
```bash
kubectl rollout history deployment/my-app

# View details of a specific revision
kubectl rollout history deployment/my-app --revision=2
```

### 3. Rolling Back
```bash
# Undo the last rollout
kubectl rollout undo deployment/my-app

# Rollback to a specific revision
kubectl rollout undo deployment/my-app --to-revision=2
```

### 4. Pause/Resume Rollouts
```bash
# Pause a rollout (useful for canary deployments)
kubectl rollout pause deployment/my-app

# Resume a paused rollout
kubectl rollout resume deployment/my-app
```

## Example Deployment with RollingUpdate Strategy

```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: my-app
spec:
  replicas: 3
  strategy:
    type: RollingUpdate
    rollingUpdate:
      maxSurge: 1        # How many pods we can add at a time
      maxUnavailable: 0  # How many pods can be unavailable during the update
  template:
    metadata:
      labels:
        app: my-app
    spec:
      containers:
      - name: my-app
        image: my-app:1.0
```

## Common Scenarios

### 1. Updating an Application
When you update a deployment (e.g., changing the image version):
```bash
kubectl set image deployment/my-app my-app=my-app:2.0
```
Kubernetes will:
1. Create new pods with the updated version
2. Wait for them to be ready
3. Remove old pods
4. Continue until all pods are updated

### 2. Rolling Back Failed Updates
If the new version has issues:
```bash
kubectl rollout undo deployment/my-app
```
Kubernetes will:
1. Stop the current rollout
2. Revert to the previous working version
3. Ensure application stability

## Best Practices

1. **Deployment Strategy Configuration**
   - Set appropriate `maxSurge` and `maxUnavailable` values
   - Consider your application's resource requirements
   - Plan for zero-downtime updates

2. **Health Checks**
   - Implement proper readiness/liveness probes
   - Ensures Kubernetes can accurately determine pod health during updates

3. **Resource Management**
   - Ensure sufficient cluster resources for both old and new pods during updates
   - Consider resource requests and limits

4. **Testing**
   - Test rollout procedures in a staging environment
   - Verify rollback procedures work as expected

5. **Monitoring**
   - Watch rollout progress
   - Monitor application performance during updates
   - Keep track of deployment history

## Common Issues and Solutions

1. **Rollout Stuck**
   - Check pod events: `kubectl describe pod <pod-name>`
   - Verify resource availability
   - Check container health checks

2. **Failed Rollback**
   - Ensure revision history exists
   - Check if the previous version's resources are still available
   - Verify configuration validity

Remember: Rollouts are a powerful feature for managing application updates, but they require proper configuration and monitoring to work effectively.
