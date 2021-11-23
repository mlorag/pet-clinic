#!/bin/bash

ENVIRONMENT=$1
TAG_NAME=$2

PORT=0
case $ENVIRONMENT in
dev) PORT=9966 ;;
test) PORT=9967 ;;
prod) PORT=9968 ;;
*)echo "Environment doesn't exist"; exit 1 ;;
esac

for runName in `docker ps | grep "alpine-petclinic-$ENVIRONMENT" | awk '{print $1}'`
do
    if [ "$runName" != "" ]
    then
        docker stop $runName
    fi
done
docker run --name alpine-petclinic-$ENVIRONMENT --rm -d -p $PORT:8080 $TAG_NAME