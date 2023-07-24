#!/bin/bash
# 노드에서 여러 개의 이미지를 다운 받고 싶을 때 사용하는 스크립트
# /root/repo/ 디렉토리에 harbor password가 입력된 my_password.txt 파일이 필요함
# 하단의 images에 다운 받아야될 이미지들 기입 ex) "test-repo.com/test/python:3.6"
images=("{{ #harbor-domain_입력/project명/이미지명/태그 }}" "{{ #harbor-domain_입력/project명/이미지명/태그 }}" "..." "...")

cat /root/repo/my_password.txt | docker login #harbor-domain_입력 --username admin --password-stdin

# images에 기입된 이미지를 하나씩 다운로드
for image in "${images[@]}"
do
    chk=`docker images $image | wc -l`
    if [ chk==1 ]; then
        echo "##############################docker pull $image##############################"
        docker pull $image
    fi
done

docker logout #harbor-domain_입력

# 이미지의 태그가 v5인 이미지 개수 출력
docker images --format "{{.Repository}}:{{.Tag}}" | awk '/-v5/' | nl

exit 0
