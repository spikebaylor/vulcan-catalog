#!/bin/bash


SCRIPT_DIR=$(dirname $(readlink -f $0))

NAMESPACE=mongo-operator

until SUCCESS=$(kubectl -n $NAMESPACE get deployments percona-server-mongodb-operator -o jsonpath='{.status.readyReplicas}') && [[ "${SUCCESS}" -ge 1 ]]; do
    sleep 5
done
