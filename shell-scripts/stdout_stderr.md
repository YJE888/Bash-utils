# stdout 과 stderr
### 테스트
```
$ cat test.sh
#!/bin/bash
echo "This is a standard output"
echo "This is an error message" >&2
exit 0

$ ./test.sh > ../results/stdout.txt 2> ../results/stderr.txt
$ cat ../results/stdout.txt 
This is a standard output

$ cat ../results/stderr.txt 
This is an error message
```
