# Flow-Control
### if문
- 형식
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
- 형식
  ```
  for 변수 in 리스트; do
      # 반복될 내용을 작성
  done
  ```
  <br/>
- 배열 선언
  ```
  my_array=("apple" "banana" "cherry")
  for item in "${my_array[@]}"; do
    echo $item
  done
  ```
  <br/>
- 1부터 100까지의 숫자 출력
  ```
  for mission in {0..100}
  do
      echo $mission
  done

  # 또는
  for (( mission = 0; mission <= 100; mission ++ ))
  do
      echo $mission
  done
  ```
  <br/>
  
- file의 내용 라인 개수를 확인
  ```
  for file in $(ls)
  do
  	echo Line count of $file is $(cat $file | wc -l)
  done
  ```
  </br>
  
- 여러개의 package 설치
  ```
  cat <<EOF > install-packages.txt
  vim
  net-tools
  wget
  git
  EOF
  
  for package in $(cat install-packages.txt)
  do
  	yum -y install $package
  done
  ```
### while문
- 형식
  ```
  while 조건; do
      # 조건이 참일 동안 반복될 내용을 작성
  done
  ```
</br>

- 서버 종료
  ```
  while true
  do
    echo "1. Shutdown"
    echo "2. Restart"
    echo "3. Exit Menu"
    read -p "Enter your choice: " choice
    if [ $choice -eq 1 ]
    then
      shutdown now
    elif [ $choice -eq 2 ]
    then
      shutdown -r now
    elif [ $choice -eq 3 ]
    then
      break
    else
      continue
    fi
  done
  ```
### case문
- 형식
  ```
  case 변수 in
  패턴1)
    # 패턴1에 해당하는 동작 수행
    ;;
  패턴2)
    # 패턴2에 해당하는 동작 수행
    ;;
  패턴3)
    # 패턴3에 해당하는 동작 수행
    ;;
  *)
    # 모든 패턴에 해당하지 않을 때 수행할 동작
    ;;
  esac
  ```
- 서버 종료
  ```
  echo "1. Shutdown"
  echo "2. Restart"
  echo "3. Exit Menu"
  read -p "Enter your choice: " choice

  case $choice in
    1) shutdown now
       ;;
    2) shutdown -r now
       ;;
    3) break
       ;;
    *) continue
       ;;
  esac
  ```
