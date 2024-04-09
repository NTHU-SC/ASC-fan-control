curl 'https://10.123.66.187/api/settings/fan/1' \
  -X 'PUT' \
  -H 'Accept: */*' \
  -H 'Content-Type: application/json' \
  -H 'Cookie: QSESSIONID=756784808006f2efd4TqzXQeok4dObjn; refresh_disable=1; lang=zh-tw' \
  -H 'Origin: https://10.123.66.187' \
  -H 'X-CSRFTOKEN: yfepuHle' \
  -H 'X-Requested-With: XMLHttpRequest' \
  --data-raw '{"duty":20}' \
  --insecure &