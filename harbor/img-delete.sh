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

# 이미지 삭제
curl -X DELETE \
  "https://${HOST}/api/v2.0/projects/${NS}/repositories/${REPO}/artifacts/${TAG}" \
  -H "accept: application/json" \
  -H "authorization: Basic ${AUTH}" \
  -H "X-Harbor-CSRF-Token: ${TOKEN}"

# 이미지 삭제 확인
curl -X GET \
  "https://${HOST}/api/v2.0/projects/${NS}/repositories/${REPO}/artifacts/${TAG}?page=1&page_size=10&with_tag=true&with_label=false&with_scan_overview=false&with_signature=false&with_immutable_status=false" \
  -H "accept: application/json" \
  -H "X-Accept-Vulnerabilities: application/vnd.security.vulnerability.report; version=1.1, application/vnd.scanner.adapter.vuln.report.harbor+json; version=1.0" \
  -H "authorization: Basic ${AUTH}" | grep -i "not_found"

if [ $? == 0 ]; then
  echo "이미지 삭제 SUCCESS"
else
  echo "이미지 삭제 FAIL"
fi

#repo에 남은 이미지가 존재하는지 확인
count=$(curl -X 'GET' \
  "https://${HOST}/api/v2.0/projects/${NS}/repositories/${REPO}" \
  -H 'accept: application/json' \
  -H "authorization: Basic ${AUTH}" | jq '.artifact_count')

#repo에 이미지가 없다면 repo 삭제
if [ $count == 0 ]
then
    echo "repo 삭제"
    curl -X 'DELETE' \
    "https://${HOST}/api/v2.0/projects/${NS}/repositories/${REPO}" \
    -H 'accept: application/json' \
    -H "authorization: Basic ${AUTH}" \
    -H "X-Harbor-CSRF-Token: ${TOKEN}"
fi

# chk 변수에 특정 이미지를 사용 중인 파드가 있는지 확인
chk=`kubectl get pods -n ${NS} -o jsonpath="{.items[*].spec.containers[*].image}" | grep -w #harbor-domain_입력/${NS}/${REPO}:${TAG}`
if [ $? == 0 ]
    then
        echo " image is in use, 사용 중인 서비스를 종료하세요"
        exit 1
    else
        # inventory 파일에 img_name=이미지명 tag=태그 를 입력해서 모든 노드에서 해당 이미지 삭제하는 ansible 실행
        mkdir /harbor/${NS} && cp /home/dev/function/harbor/ansible/* /harbor/${NS}
        echo -e "img_name=#harbor-domain_입력/${NS}/${REPO}\nimg_tag=${TAG}" >> /harbor/${NS}/inventory
        ansible-playbook -i /harbor/${NS}/inventory /harbor/${NS}/remove-img.yml
        if [ $? == 0 ]
          then
            rm -rf /harbor/${NS}
            echo "노드 이미지 삭제 SUCCESS"
          else
            rm -rf /harbor/${NS}
            echo "노드 이미지 삭제 FAIL"
        fi
fi
exit 0
