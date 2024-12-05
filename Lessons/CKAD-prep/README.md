# CKAD (Certified Kubernetes Application Developer) Preparation Guide

This guide organizes key concepts and practical exercises to help prepare for the CKAD certification.

## Core Concepts (13%)

### Multi-Container Pods
1. **Patterns to Master:**
   - Sidecar
   - Ambassador
   - Adapter
   - Init Containers

2. **Key Skills:**
   - Container communication within a pod
   - Shared storage between containers
   - Container startup order
   - Resource management in multi-container scenarios

## Pod Design (20%)

### Labels, Selectors, and Annotations
- Effective labeling strategies
- Using selectors for pod management
- Annotations for metadata

### Deployments
- Rolling updates
- Rollbacks
- Scaling strategies
- Deployment strategies (Blue/Green, Canary)

### Jobs and CronJobs
- Batch processing
- Scheduled tasks
- Job parallelism
- Job completion handling

## Configuration (18%)

### ConfigMaps and Secrets
- Creating and managing ConfigMaps
- Secret management
- Mounting configurations
- Environment variables vs. volume mounts

### Security Contexts
- Pod security policies
- Container privileges
- File permissions
- User/Group configurations

### Resource Requirements
- Setting resource requests and limits
- Quality of Service (QoS) classes
- Resource quotas
- LimitRanges

## Observability (18%)

### Liveness and Readiness Probes
- HTTP probes
- TCP probes
- Command probes
- Probe configuration and timing

### Logging and Debugging
- Container logs
- Multi-container logging
- Debug running pods
- Troubleshooting techniques

### Monitoring Applications
- Resource usage monitoring
- Custom metrics
- Horizontal Pod Autoscaling
- Events and alerts

## Services and Networking (13%)

### Services
- ClusterIP
- NodePort
- LoadBalancer
- ExternalName
- Endpoints

### Network Policies
- Ingress rules
- Egress rules
- Pod selectors
- Namespace selectors
- CIDR blocks

### Ingress
- Ingress controllers
- Ingress rules
- Path-based routing
- Name-based virtual hosting
- TLS configuration

## State Persistence (18%)

### Volumes
- Volume types
- PersistentVolumes
- PersistentVolumeClaims
- StorageClasses
- Dynamic provisioning

### Volume Modes
- ReadWriteOnce
- ReadOnlyMany
- ReadWriteMany
- Access modes compatibility

## Exam Preparation Tips

### Time Management
1. Practice with time constraints
2. Use kubectl shortcuts and aliases
3. Master vim/nano for quick YAML editing
4. Use kubectl explain effectively

### Common Tasks to Practice
1. Create multi-container pods
2. Debug failing pods
3. Scale deployments
4. Create and use ConfigMaps/Secrets
5. Set up network policies
6. Configure persistent storage

### Environment Setup
1. Use similar environment to exam
2. Practice without auto-completion
3. Use only allowed documentation
4. Time your practice sessions

## Practice Exercises

Each topic directory will contain:
1. Concept explanation
2. Practice exercises
3. Solution examples
4. Common pitfalls
5. Debugging scenarios

## Resources

### Official Documentation
- [Kubernetes Documentation](https://kubernetes.io/docs/)
- [CKAD Curriculum](https://github.com/cncf/curriculum)

### Practice Environments
- Minikube
- Kind
- K3d
- Cloud provider free tiers

### Command Reference
Create a cheat sheet of commonly used commands:
```bash
# Quick pod creation
kubectl run nginx --image=nginx

# Generate YAML templates
kubectl create deploy nginx --image=nginx --dry-run=client -o yaml

# Debug commands
kubectl describe pod <pod-name>
kubectl logs <pod-name>
kubectl exec -it <pod-name> -- /bin/sh
```

## Next Steps

1. Create detailed guides for each topic
2. Add practical exercises
3. Include real-world scenarios
4. Add troubleshooting guides
5. Create quick reference sheets
