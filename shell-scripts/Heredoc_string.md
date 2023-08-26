# Heredoc String
- 여러 줄에 걸쳐 긴 문자열을 정의하는 데 사용됨
  ```
  cat <<EOF
  This is a
  multi-line
  string.
  EOF

  # 출력
  This is a
  multi-line
  string.
  ```

- 원격서버에 tty할당을 하지 않는 상태로 인터랙티브한 쉘 세션을 시작하지 않고 명령어 실행
    - 원격 서버에 로그인한 후에 실행할 명령어를 정의하면 실행한 결과가 로컬 쉘에 출력됨
  ```
  ssh -T bob@node01 <<EOF
  > ls
  > EOF

  ssh -T bob@node01 <<EOF
  find /home/bob/docker_files -name schema.sql
  > EOF
  /home/bob/docker_files/backup/sql_files/schema.sql
  ```
- Heredoc string에서 출력된 내용이 파일로 리디렉션
  ```
  <<EOF > hello_world.txt
  Hello
  World
  From
  Multiple
  Lines
  EOF

  ssh -T bob@node01 <<EOF > hello_world.txt                                                    
  cat /home/bob/docker_files/backup/sql_files/schema.sql
  EOF
  ```
