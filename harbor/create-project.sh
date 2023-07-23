#!/bin/bash
# Project 생성
# ./create-project.sh {프로젝트명}
# config.ini 파일이 필요하며, config.ini의 경로가 환경변수에 등록되어 있어야됨
if [ $1 = "-h" ] || [ $1 = "--help" ]
then
        echo -e "Usage : ./create-project.sh {NS}"
        exit 2
fi

NS=$1
HOST=$(awk '/^HOST/{print $3}' ${CONFIG_FILE})
AUTH=$(awk '/^AUTH/{print $3}' ${CONFIG_FILE})
TOKEN=$(awk '/^TOKEN/{print $3}' ${CONFIG_FILE})
curl -X POST \
  "https://${HOST}/api/v2.0/projects" \
  -H "accept: application/json" \
  -H "X-Resource-Name-In-Location: false" \
  -H "authorization: Basic ${AUTH}" \
  -H "Content-Type: application/json" \
  -H "X-Harbor-CSRF-Token: ${TOKEN}" \
  -d '{
  "project_name": "'${NS}'",
  "public": false
}'

exit 0
