Deploy two pods:

```yaml
kubectl run pod-a --image=busybox -- sleep 3600
kubectl run pod-b --image=busybox -- sleep 3600
```
Find pod-b's IP (could take some time):

```bash
kubectl describe pod pod-b
```
Test connectivity from pod-a:

```bash
kubectl exec pod-a -- ping <pod-b-ip>
```