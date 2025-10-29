#!/bin/bash

echo "Wait for Minio Operator"
kubectl wait deployment --all -n minio --for=condition=available --timeout=120s
