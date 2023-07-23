#!/bin/bash
# 이미지 용량, 생성 시간, 이미지 사용 회수 조회

if [ $1 = "-h" ] || [ $1 = "--help" ]
then
        echo -e "Usage : ./img-info {NS} {REPO}"
        exit 2
fi

NS=$1
REPO=$2
HOST=$(awk '/^HOST/{print $3}' ${CONFIG_FILE})

# 이미지 용량, 생성시간 조회
curl -X GET \
"https://${HOST}/api/v2.0/projects/${NS}/repositories/${REPO}/artifacts?page=1&page_size=10&with_tag=true&with_label=false&with_scan_overview=false&with_signature=false&with_immutable_status=false" \
-H "accept: application/json" \
-H "X-Accept-Vulnerabilities: application/vnd.security.vulnerability.report; version=1.1, application/vnd.scanner.adapter.vuln.report.harbor+json; version=1.0" | jq '.[].push_time,.[].size'

# 이미지 사용 회수 조회
curl -X GET \
"https://${HOST}/api/v2.0/projects/${NS}/repositories/${REPO}" \
-H "accept: application/json" | jq '.pull_count'

exit 0
