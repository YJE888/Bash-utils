# 조건부 서식
### if문
```
if [ 조건식1 ]; then
    # 조건식1이 참일 때 실행할 명령어들
elif [ 조건식2 ]; then
    # 조건식2가 참일 때 실행할 명령어들
else
    # 모든 조건이 거짓일 때 실행할 명령어들
fi
```
### for문
```
for 변수 in 리스트; do
    # 반복될 내용을 작성
done
```
### while문
```
while 조건; do
    # 조건이 참일 동안 반복될 내용을 작성
done
```
### 조건부 서식
**[ STRING1 = STRING2 ]**
|Example|Description|
|:---:|:---:|
| [ "abc" = "abc" ] | 두 문자열이 같은지 확인 (true) |
| [ "abc" != "abc" ] | 두 문자열이 같지 않은지 확인 (false) |
| [ 5 -eq 5 ] | 두 숫자가 같은지 확인 (true)|
| [ 5 -ne 5 ] | 두 숫자가 같지 않은지 확인 (false)|
| [ 6 -gt 5 ] | 왼쪽 숫자가 오른쪽 숫자보다 큰지 확인 (true)|
| [ 5 -lt 6 ] | 왼쪽 숫자가 오른쪽 숫자보다 작은지 확인 (true)|

**[[ STRING1 = STRING2 ]]**
|Example|Description|
|:---:|:---:|
|[[ "abcd" = \*bc\* ]]| abcd가 cd를 포함하고 있음 (true)|
