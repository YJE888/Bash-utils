# kubernetes에서 harbor 사용 예시

- deployment 및 image가 필요한 리소스에서 
```
apiVersion: v1
kind: Pod
metadata:
  labels:
    app: test
    pod-template-hash: 7bb74dfbb9
  name: testv2-7bb74dfbb9-rm5t4
  namespace: default
spec:
  containers:
  - image: 
    name: test
```
