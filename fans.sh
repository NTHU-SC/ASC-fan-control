# curl 'https://10.123.66.187/api/settings/fan/1' \
#   -X 'PUT' \
#   -H 'Accept: */*' \
#   -H 'Content-Type: application/json' \
#   -H 'Cookie: QSESSIONID=756784808006f2efd4TqzXQeok4dObjn; refresh_disable=1; lang=zh-tw' \
#   -H 'Origin: https://10.123.66.187' \
#   -H 'X-CSRFTOKEN: yfepuHle' \
#   -H 'X-Requested-With: XMLHttpRequest' \
#   --data-raw '{"duty":20}' \
#   --insecure &

curl 'https://10.123.64.21/api/session' \
  -H 'Accept: application/json, text/javascript, */*; q=0.01' \
  -H 'Connection: keep-alive' \
  -H 'Cookie: refresh_disable=1; lang=zh-tw; QSESSIONID=756784808006f2efd4TqzXQeok4dObjn' \
  -H 'Origin: https://10.123.64.24' \
  -H 'X-CSRFTOKEN: null' \
  -H 'X-Requested-With: XMLHttpRequest' \
  --data-raw 'encrypt_flag=0&username=admin&password=admin&login_tag=597523667' \
  --insecure | grep -o '"CSRFToken": "[^"]*' | cut -d '"' -f 4 > node1.csrf

curl 'https://10.123.64.22/api/session' \
  -H 'Accept: application/json, text/javascript, */*; q=0.01' \
  -H 'Connection: keep-alive' \
  -H 'Cookie: refresh_disable=1; lang=zh-tw; QSESSIONID=d16c449ea52f36f7e14xYYkNNcaSp7Y7' \
  -H 'Origin: https://10.123.64.24' \
  -H 'X-CSRFTOKEN: null' \
  -H 'X-Requested-With: XMLHttpRequest' \
  --data-raw 'encrypt_flag=0&username=admin&password=admin&login_tag=597523667' \
  --insecure | grep -o '"CSRFToken": "[^"]*' | cut -d '"' -f 4 > node2.csrf

curl 'https://10.123.64.23/api/session' \
  -H 'Accept: application/json, text/javascript, */*; q=0.01' \
  -H 'Connection: keep-alive' \
  -H 'Cookie: refresh_disable=1; lang=zh-tw; QSESSIONID=59fc049f6431f8fc0cOBxeNFuKqfPqAo' \
  -H 'Origin: https://10.123.64.24' \
  -H 'X-CSRFTOKEN: null' \
  -H 'X-Requested-With: XMLHttpRequest' \
  --data-raw 'encrypt_flag=0&username=admin&password=admin&login_tag=597523667' \
  --insecure | grep -o '"CSRFToken": "[^"]*' | cut -d '"' -f 4 > node3.csrf

curl 'https://10.123.64.24/api/session' \
  -H 'Accept: application/json, text/javascript, */*; q=0.01' \
  -H 'Connection: keep-alive' \
  -H 'Cookie: refresh_disable=1; lang=zh-tw; QSESSIONID=a85a34a1b90704cd16sSSPeHAv08k7l2' \
  -H 'Origin: https://10.123.64.24' \
  -H 'X-CSRFTOKEN: null' \
  -H 'X-Requested-With: XMLHttpRequest' \
  --data-raw 'encrypt_flag=0&username=admin&password=admin&login_tag=597523667' \
  --insecure | grep -o '"CSRFToken": "[^"]*' | cut -d '"' -f 4 > node4.csrf
