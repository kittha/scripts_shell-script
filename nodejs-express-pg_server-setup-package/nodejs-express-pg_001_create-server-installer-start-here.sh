#!/bin/bash

echo "### nodejs express create server script for lazy guy ###"

echo "Enter your project name"
read PROJECT_NAME

while true; 
do
  echo "Enter backend server port num in range 1024 to 65535 (4242)"
  read PORT_NUM

  if [[ "$PORT_NUM" =~ ^[0-9]+$ ]] && [ "$PORT_NUM" -ge 1024 ] && [ "$PORT_NUM" -le 65535 ]
  then
    echo "validated input: port num is $PORT_NUM"
    break
  else
    echo "nononono please input in range 1024 to 65535"
  fi
done

echo "Running script 1 2 3 4 5 ..."
./nodejs-express_002_create-server.sh "$PROJECT_NAME" "$PORT_NUM"

./nodejs-express_003_express-routes.sh "$PROJECT_NAME" "$PORT_NUM"

./nodejs-express_004_middleware_install.sh "$PROJECT_NAME" "$PORT_NUM"

./nodejs-express_005_pg_install.sh "$PROJECT_NAME" "$PORT_NUM"


#rm -- "$0"
