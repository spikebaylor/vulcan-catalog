#!/bin/bash

SCRIPT_DIR=$(dirname $(readlink -f $0))

function waitOnPostgresOperator() {
    echo "Waiting for postgres-operator to be ready"
    until SUCCESS=$(kubectl -n zalando get deployments postgres-operator -o jsonpath='{.status.readyReplicas}') && [[ "${SUCCESS}" -ge 1 ]]; do
        #echo "Waiting for postgres-operator to be ready"
        sleep 5
    done
}

function waitOnPostgresCRD() {
    echo "Waiting for postgres-operator CRD to be ready"
    until SUCCESS=$(kubectl get crd postgresqls.acid.zalan.do -o jsonpath='{.kind}') && [[ "${SUCCESS}" = "CustomResourceDefinition" ]]; do
        #echo "Waiting for postgres-operator CRD to be ready"
        sleep 5
    done
}


# Postgres-Operator sometimes has problems where the CRDs haven't loaded, and also needs to be running
# Before any postgresql artifacts are provisioned so we'll make sure those are loaded and running before continuing.
kubectl apply -k $SCRIPT_DIR/postgres-operator-crd
waitOnPostgresCRD
kubectl apply -k $SCRIPT_DIR/postgres-operator
waitOnPostgresOperator