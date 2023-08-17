# 조건부 서식
**[ STRING1 = STRING2 ]**
|Example|Description|
|:---:|:---:|
| [ "abc" = "abc" ] | 두 문자열이 같은지 확인 (true) |
| [ "abc" != "abc" ] | 두 문자열이 같지 않은지 확인 (false) |
| [ 5 -eq 5 ] | 두 숫자가 같은지 확인 (true)|
| [ 5 -ne 5 ] | 두 숫자가 같지 않은지 확인 (false)|
| [ 6 -gt 5 ] | 왼쪽 숫자가 오른쪽 숫자보다 큰지 확인 (true)|
| [ 5 -lt 6 ] | 왼쪽 숫자가 오른쪽 숫자보다 작은지 확인 (true)|
<br/>

**[[ STRING1 = STRING2 ]]**
|Example|Description|
|:---:|:---:|
|[[ "a**bc**d" = \*bc\* ]]| abcd가 cd를 포함하고 있음 (true)|
|[[ "ab**c**" = ab[cd] ]]<br/> or <br/> [[ "ab**d**" = ab[cd] ]]| 세번째 문자가 c 또는 d임 (true)|
|[[ "ab**e**" = "ab[cd]" ]]| 세번째 문자가 c 또는 d임 (false)|
|[[ "**a**bc" > "**b**cd" ]]|a가 b보다 큰지 확인, 사전식으로 a는 b보다 먼저 위치함 (false)|
|[[ "**a**bc" < "**b**cd" ]]|a가 b보다 작은지 확인, 사전식으로 a는 b보다 먼저 위치함 (true)|
<br/>

**[ 조건1 ] && [ 조건2 ] = [[ 조건1 && 조건2 ]]**
|Example|Description|
|:---:|:---:|
| [[ A -gt 4 && A -lt 10 ]]| A는 4보다 크고, 10보다 작음|   
<br/>

**[ 조건1 ] || [ 조건2 ] = [[ 조건1 || 조건2 ]]**  
|Example|Description|
|:---:|:---:|
|[[ A -gt 4 \|\| A -lt 10 ]]| A는 4보다 크거나 10보다 작음|   
<br/>

**그 외**
|Example|Description|
|:---:|:---:|
| [ -e FILE ] | 파일이 있으면!|
| [ -d FILE ] | 파일이 존재하고 디렉토리인 경우!|
| [ -s FILE ] | 파일이 있고 사이즈가 0보다 크면!|
| [ -x FILE ] | 파일에 실행 가능한 경우!|
| [ -w FILE ] | 파일에 쓰기가 가능한 경우!|


