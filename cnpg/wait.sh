#!/bin/bash

echo "Wait for CNPG Operator"

kubectl -n cnpg-system wait --for=condition=Available deployment -l app.kubernetes.io/name=cloudnative-pg --timeout=180s
kubectl get pods -n cnpg-system