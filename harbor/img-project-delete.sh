#!/bin/bash
# 모든 image 삭제 및 project 삭제 스크립트
# ./img-project-delete.sh {프로젝트명}

if [ $1 = "-h" ] || [ $1 = "--help" ]
then
        echo -e "Usage : ./img-project-delete.sh {NS}"
        exit 2
fi

NS=$1
HOST=$(awk '/^HOST/{print $3}' ${CONFIG_FILE})
AUTH=$(awk '/^AUTH/{print $3}' ${CONFIG_FILE})
TOKEN=$(awk '/^TOKEN/{print $3}' ${CONFIG_FILE})

# harbor 프로젝트 내부의 repo(이미지)를 가져오기 위한 디렉토리 생성
mkdir -p /harbor-repo/${NS}
cd /harbor-repo/${NS}

# 이미지 이름을 json 파일 생성
curl -X GET \
  "https://${HOST}/api/v2.0/projects/${NS}/repositories?page=1&page_size=10" \
  -H "accept: application/json" \
  -H "authorization: Basic ${AUTH}" | jq "." | awk '/name/ {print $2}' | tr -d '",' | sort | sed 's:.*/::' > ${NS}.json
cat ${NS}.json

# json파일의 내용을 기반으로 repo(이미지) 삭제
RepoDelete() {
    for repo in `cat ${NS}.json`;
    do
        curl -X DELETE \
        "https://${HOST}/api/v2.0/projects/${NS}/repositories/${repo}" \
        -H "accept: application/json" \
        -H "authorization: Basic ${AUTH}" \
        -H "X-Harbor-CSRF-Token: ${TOKEN}"
    done
}

RepoDelete $repo

# 프로젝트 삭제
curl -X DELETE \
  "https://${HOST}/api/v2.0/projects/${NS}" \
  -H "accept: application/json" \
  -H "X-Is-Resource-Name: false" \
  -H "authorization: Basic ${AUTH}" \
  -H "X-Harbor-CSRF-Token: ${TOKEN}"

exit 0
