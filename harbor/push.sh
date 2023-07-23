#!/bin/bash
# 실행중인 컨테이너의 현재 상태 그대로 commit 후 harbor에 이미지 push
# worker노드마다 /root/repo에 harbor패스워드 저장된 파일 존재해야됨
# {{ HARBOR_HOST_입력 }} 부분에 host명 입력 ex) test-repo.com
if [ $1 = "-h" ] || [ $1 = "--help" ]
then
        echo -e "Usage : ./push.sh {NS} {DEPLOY_NAME} {IMG_Name} {TAG}"
        exit 2
fi

NS=$1
DEPLOY_NAME=$2
REPO=$3
TAG=$4

# deployment 이름으로 pod명을 확인 
POD_FULL_NAME=$(kubectl get pod -n ${NS} | grep -w ${DEPLOY_NAME} | cut -d " " -f 1)

# pod명으로 해당 파드가 어느 노드에 위치하는지 확인
NODE=$(kubectl get pods ${POD_FULL_NAME} -n ${NS} -o jsonpath={.spec.nodeName})

# pod명으로 컨테이너의ID 확인
CID=$(kubectl describe pod ${POD_FULL_NAME} -n ${NS} | grep "Container ID" | rev | cut -c -64 | rev)

# pod가 실행 중인 node에 접속하여 컨테이너ID를 사용하여 commit 후 harbor에 push
ssh ${NODE} "docker commit ${CID} {{ HARBOR_HOST_입력 }}/${NS}/${REPO}:${TAG};cat /root/repo/my_password.txt | docker login {{ HARBOR_HOST_입력 }} --username admin --password-stdin;docker push {{ HARBOR_HOST_입력 }}/${NS}/${REPO}:${TAG};docker logout {{ HARBOR_HOST_입력 }};exit;"

exit 0  
