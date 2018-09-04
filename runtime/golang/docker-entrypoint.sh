#!/bin/sh
set -e

if [ "$MICRO_REGISTRY" = "" ];then
  MICRO_REGISTRY="consul"
fi

if [ "$MICRO_REGISTRY_ADDRESS" = "" ];then
  MICRO_REGISTRY_ADDRESS="$CONSUL_HTTP_ADDR"
fi

if [ "$MICRO_SERVER" = "" ];then
  MICRO_SERVER="grpc"
fi

if [ "$MICRO_CLIENT" = "" ];then
  MICRO_CLIENT="grpc"
fi

if [ "$MICRO_SELECTOR" = "" ];then
  MICRO_SELECTOR="cache"
fi

if [ "$PROJECT_NAME" = "" ];then
  exec "$@"
else
  exec "$PROJECT_NAME" --registry=$MICRO_REGISTRY --registry_address=$MICRO_REGISTRY_ADDRESS --server=$MICRO_SERVER --client=$MICRO_CLIENT --selector=$MICRO_SELECTOR
fi
