### 변수 사용 시 중괄호{ }
```
#!/bin/bash
height=170
echo "Your height is = $heightcm"    => X 변수를 $heightcm으로 인식

echo "Your height is = ${height}cm"  => O 변수를 $height로 인식하고 170cm를 출력하게 됨
```
### 변수 사용 시 따옴표" "
- "" 없이 변수 사용
  ```
  #!/bin/bash
  string = "One Two Three"

  # 쌍따옴표 미사용
  for i in ${string}; do
    echo ${i}
  done
  
  # 출력
  One
  Two
  Three
  ```
&nbsp;
- "" 사용하여 변수 사용
  ```
  #!/bin/bash
  string = "One Two Three"

  # 쌍따옴표 사용
  for i in "${string}"; do
    echo ${i}
  done
  
  # 출력
  One Two Three
  ```

