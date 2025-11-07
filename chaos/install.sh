#!/bin/bash

SCRIPT_NAME=$(basename $0)
SCRIPT_DIR=$(dirname $(readlink -f $0))
CURRENT_DIR=$(pwd)
LOCAL_KUBE_ROOT=$SCRIPT_DIR/../..

source $LOCAL_KUBE_ROOT/scripts/common.shinc

header "Installing Chaos Mesh"

$LOCAL_KUBE_ROOT/setContext.sh

kubectl apply -k $SCRIPT_DIR/

checkHostEntry "chaos.local.kube"
