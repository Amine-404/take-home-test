#!/usr/bin/env bash
set -e

RELEASE_NAME="hello-world"
PORT=8080

echo "Terminating port-forwarding for release '$RELEASE_NAME' on port $PORT..."
pkill -f "kubectl port-forward.*$RELEASE_NAME.*$PORT" || true

echo "Deleting Helm release '$RELEASE_NAME'..."
helm uninstall hello-world --namespace dev

echo "Deleting minikube cluster"
minikube delete
