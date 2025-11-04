#!/bin/bash

#
# Classification:  Unclassified
#
# Project Name:  Cyber TRIDENT
#
# DISTRIBUTION STATEMENT C.
#
# Distribution is authorized to U.S. Government Agencies and their
# contractors. Export Controlled: 2023. Other requests for
# this document shall be referred to U.S. Army PEO STRI.
#
SCRIPT_NAME=$(basename $0)
SCRIPT_DIR=$(dirname $(readlink -f $0))
CURRENT_DIR=$(pwd)

if [[ ! -v LOCAL_KUBE_HOME ]]; then
  echo "LOCAL_KUBE_HOME environment variable is not set.  Please set this variable to the root directory of your local-kube setup"
  exit 1;
fi

source $LOCAL_KUBE_HOME/scripts/loadConfiguration.sh
source $LOCAL_KUBE_HOME/scripts/common.shinc

$LOCAL_KUBE_HOME/setContext.sh

header "Uninstall Keycloak (SSO)"

kubectl delete -k ${SCRIPT_DIR}

