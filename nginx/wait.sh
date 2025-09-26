#!/bin/bash

echo "Wait for NGINX Controller Pod"

until kubectl get pods -n ingress-nginx -l app.kubernetes.io/component=controller -o jsonpath='{.items[0].metadata.name}' 2>/dev/null | grep -q .; do
  sleep 1
done

kubectl wait --for=condition=Ready pod -l app.kubernetes.io/component=controller -n ingress-nginx --timeout=180s
kubectl get pods -n ingress-nginx -l app.kubernetes.io/component=controller