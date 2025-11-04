#!/bin/bash

SCRIPT_NAME=$(basename $0)
SCRIPT_DIR=$(dirname $(readlink -f $0))
CURRENT_DIR=$(pwd)
LOCALKUBE_ROOT=$SCRIPT_DIR/../..

source $LOCALKUBE_ROOT/scripts/common.shinc

header "Install Keycloak (SSO)"

$LOCALKUBE_ROOT/setContext.sh


kubectl apply -k $SCRIPT_DIR/.

checkHostEntry "sso.local.kube"
