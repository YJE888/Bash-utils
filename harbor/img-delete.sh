#!/bin/bash
# 이미지 삭제
# ./img-delete.sh {프로젝트명} {이미지 이름} {태그}
if [ $1 = "-h" ] || [ $1 = "--help" ]
then
        echo -e "Usage : ./img-delete.sh {NS} {IMG_Name} {TAG}"
        exit 2
fi

NS=$1
REPO=$2
TAG=$3

HOST=$(awk '/^HOST/{print $3}' ${CONFIG_FILE})
AUTH=$(awk '/^AUTH/{print $3}' ${CONFIG_FILE})
TOKEN=$(awk '/^TOKEN/{print $3}' ${CONFIG_FILE})

curl -X DELETE \
  "https://${HOST}/api/v2.0/projects/${NS}/repositories/${REPO}/artifacts/${TAG}" \
  -H "accept: application/json" \
  -H "authorization: Basic ${AUTH}" \
  -H "X-Harbor-CSRF-Token: ${TOKEN}"

exit 0
