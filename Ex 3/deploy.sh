#!/usr/bin/env bash
set -e

if [ -z "$1" ]; then
  echo "Error: Version argument is required."
  echo "Usage: $0 <version> [env]"
  echo "Example: $0 1.0.0 dev"
  exit 1
fi

VERSION="$1"
ENV="${2:-dev}"
VALUES_FILE="charts/simple-app/envs/${ENV}.yaml"
RELEASE_NAME="hello-world"
PORT=8080

REQUIRED_TOOLS=("helm" "kubectl" "docker" "minikube" "curl")
MISSING_TOOLS=()

for tool in "${REQUIRED_TOOLS[@]}"; do
  if ! command -v "$tool" &> /dev/null; then
    MISSING_TOOLS+=("$tool")
  fi
done

if [ ${#MISSING_TOOLS[@]} -gt 0 ]; then
  echo "Error: The following required tools are missing: ${MISSING_TOOLS[*]}"
  exit 1
fi

if [ ! -f "$VALUES_FILE" ]; then
  echo "Error: Values file for environment '$ENV' does not exist."
  echo "Supported environments are: dev, stg, prd."
  exit 1
fi

echo "Dependencies Verified!"


ARCH=$(uname -m)
case "$ARCH" in
  x86_64)
    TARGET_ARCH="amd64"
    ;;
  aarch64)
    TARGET_ARCH="arm64"
    ;;
  *)
    echo "Error: Unsupported architecture '$ARCH'."
    exit 1
    ;;
esac

if [[ "$ENV" = "dev" ]]; then
  if ! minikube status &> /dev/null; then
    echo "Minikube is not running. Starting Minikube..."
    minikube start --driver=docker
  else
    echo "Minikube is already running."
  fi
  echo "Building image for $TARGET_ARCH using Minikube's container runtime..."
  minikube image build -f DOCKERFILE \
    --build-opt "opt=build-arg:TARGETARCH=$TARGET_ARCH" \
    -t "hello-world-rest:${VERSION}" .

  # Some Minikube versions return success even when the builder fails.
  IMAGES=$(minikube image ls)
  if ! grep -Fxq -e "hello-world-rest:${VERSION}" -e "docker.io/library/hello-world-rest:${VERSION}" <<< "$IMAGES"; then
    echo "Error: hello-world-rest:${VERSION} is not available in Minikube; aborting deployment."
    exit 1
  fi

fi

echo "Deploying Helm chart for environment '$ENV' with version '$VERSION'..."
helm upgrade --install "$RELEASE_NAME" charts/simple-app \
  --create-namespace --namespace "$ENV" \
  -f charts/simple-app/values.yaml \
  -f "$VALUES_FILE" \
  --set image.tag="$VERSION" \
  --wait

if [ "$ENV" = "dev" ]; then
  echo "Port forwarding to access the application"
  kubectl port-forward svc/"$RELEASE_NAME" -n "$ENV" $PORT:$PORT &
  echo "Application is accessible at http://localhost:$PORT"
  sleep 3
  echo "Getting the response from the application"
  curl -fsS "http://localhost:$PORT/hello-world"
  echo "Endpoint is working fine."
fi
