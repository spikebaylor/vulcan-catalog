#!/bin/bash

echo "Wait for Minio Operator"
kubectl wait --for=condition=Ready pod --all -n minio-operator --timeout=120s
kubectl get pods -n minio-operator