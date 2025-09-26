#!/bin/bash

SCRIPT_NAME=$(basename $0)
SCRIPT_DIR=$(dirname $(readlink -f $0))

function waitOnPostgresOperator() {
    #start_spinner "Waiting for postgres-operator to be ready"
    echo "Waiting for postgres-operator to be ready"
    until SUCCESS=$(kubectl -n telemetry get deployments postgres-operator -o jsonpath='{.status.readyReplicas}') && [[ "${SUCCESS}" -ge 1 ]]; do
        #echo "Waiting for postgres-operator to be ready"
        sleep 5
    done
    #echo "postgres-operator is ready"
    #stop_spinner 0 "postgres-operator is ready"
    echo "postgres-operator is ready"
}

function waitOnPostgresCRD() {
    #start_spinner "Waiting for postgres-operator CRD to be ready"
    echo "Waiting for postgres-operator CRD to be ready"
    until SUCCESS=$(kubectl get crd postgresqls.acid.zalan.do -o jsonpath='{.kind}') && [[ "${SUCCESS}" = "CustomResourceDefinition" ]]; do
        #echo "Waiting for postgres-operator CRD to be ready"
        sleep 5
    done
    #echo "postgres-operator CRD is ready"
    #stop_spinner 0 "postgres-operator CRD is ready"
    echo "postgres-operator CRD is ready"
}


# Postgres-Operator sometimes has problems where the CRDs haven't loaded, and also needs to be running
# Before any postgresql artifacts are provisioned so we'll make sure those are loaded and running before continuing.
kubectl create namespace telemetry
kubectl apply -k $SCRIPT_DIR/postgres-operator-crd
waitOnPostgresCRD
kubectl apply -k $SCRIPT_DIR/postgres-operator
waitOnPostgresOperator