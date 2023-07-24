# kubernetes에서 harbor 사용 예시
- `/etc/docker/daemon.json` 파일 수정
```
{
  "insecure-registries": ["harbor-domain_입력"]
}
```
- Private 저장소 Secret 생성
```
kubectl create secret -n ${NS} docker-registry secret명_입력 --docker-username=admin --docker-password=harbor-password_입력 --docker-server=harbor-domain_입력

```

- deployment 및 image가 필요한 리소스에서 `imagePullSecrets` 입력
```
apiVersion: apps/v1
kind: Deployment
metadata:
  ...
spec:
  ...
  template:
    metadata:
      annotations:
        kubernetes.io/egress-bandwidth: 10M
        kubernetes.io/ingress-bandwidth: 10M
      ...
    spec:
      containers:
      - image: #harbor-domain_입력/project명/이미지명:태그
        ...
      imagePullSecrets:
      - name: #private 접속 정보로 생성한 secret명 입력
      restartPolicy: Always
      ...
```
