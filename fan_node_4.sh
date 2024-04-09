#!/bin/bash

# 检查是否提供了正确的参数
if [ $# -ne 1 ]; then
    echo "Usage: $0 <duty_cycle>"
    exit 1
fi

# 提取转速参数
duty_cycle=$1

# 变量定义
host="https://10.123.64.24"
cookie="lang=zh-tw; QSESSIONID=b585f49836285cc74f2S3yLhZq0TGZdR; refresh_disable=1"
csrf_token="Xqlgd0XY"
request_with="XMLHttpRequest"

if [ "$duty_cycle" = "auto" ]; then

curl "$host/api/settings/fans-mode" \
  -X 'PUT' \
  -H 'Accept: */*' \
  -H 'Content-Type: application/json' \
  -H "Cookie: $cookie" \
  -H "Origin: $host" \
  -H "X-CSRFTOKEN: $csrf_token" \
  -H "X-Requested-With: $request_with" \
  --data-raw '{"control_mode":"auto"}' \
  --insecure
else 

curl "$host/api/settings/fans-mode" \
  -X 'PUT' \
  -H 'Accept: */*' \
  -H 'Content-Type: application/json' \
  -H "Cookie: $cookie" \
  -H "Origin: $host" \
  -H "X-CSRFTOKEN: $csrf_token" \
  -H "X-Requested-With: $request_with" \
  --data-raw '{"control_mode":"manual"}' \
  --insecure

# 遍历控制每个风扇
for ((i=1; i<=12; i++)); do
    curl "$host/api/settings/fan/$i" \
        -X 'PUT' \
        -H 'Accept: */*' \
        -H 'Content-Type: application/json' \
        -H "Cookie: $cookie" \
        -H "Origin: $host" \
        -H "X-CSRFTOKEN: $csrf_token" \
        -H "X-Requested-With: $request_with" \
        --data-raw "{\"duty\":$duty_cycle}" \
        --insecure &
done

fi
echo "Done"
