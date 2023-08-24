# basename
- 주어진 파일 경로에서 파일 또는 디렉터리의 기본 이름을 추출하는데 사용됨
- 옵션을 사용하지 않으면 파일 경로에서 마지막 디렉터리 또는 파일의 이름을 반환
  ```
  # basement [옵션] 파일_경로
  $ basename /home/bob/script/clone_project.sh 
  clone_project.sh

  # .sh를 제거하기 위해 -s 옵션 사용
  $ basename -s .sh /home/bob/script/clone_project.sh 
  clone_project
  ```
