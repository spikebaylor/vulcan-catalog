#!/bin/bash

SCRIPT_DIR=$(dirname $(readlink -f $0))

export AC_WHITE_BOLD="\033[1;37m"
export AC_RESET="\033[0m"

function waitOnCRD() {
    until SUCCESS=$(kubectl get crd elasticsearches.elasticsearch.k8s.elastic.co -o jsonpath="{.kind}") && [[ "${SUCCESS}" = "CustomResourceDefinition" ]]; do
        echo "Waiting for elk CRDs to be ready"
        sleep 5
    done
    echo "elk CRDs are ready"
}

kubectl apply -k $SCRIPT_DIR/elk-operator

waitOnCRD
