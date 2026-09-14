# take-home-test
3 Exrecises for a take home test


## Exercise 1

![alt text](VPC.png)

### Architecture Highlights
- **Subnet Layout:** 4 subnets across 2 Availability Zones (2 public, 2 private).
- **Redundant NAT:** 2 NAT Gateways (one per AZ) with dedicated route tables per private subnet.
- **Dynamic Endpoints:** Configurable map supporting both Gateway and Interface endpoints without hardcoded resources.
- **VPC Flow Logs**: Integrated with CloudWatch Logs to capture all network traffic for real-time connection security tracking.

### Folder Layout
- modules/vpc/: Core reusable module definitions.
- stages/: Environment input variables (dev.tfvars, stg.tfvars, prd.tfvars).
- tf-backend/: Isolated backend state configs (dev.hcl, stg.hcl, prd.hcl).

### Deployment Commands
- **Initialization/Deployment & Stage Selection:**
  ```bash
  terraform init -reconfigure -backend-config=tf-backend/<stage>.hcl
  terraform plan -var-file=stages/<stage>.tfvars
  terraform apply -var-file=stages/<stage>.tfvars
  ```


- **terraform plan output** 
  ```bash
  Plan: 25 to add, 0 to change, 0 to destroy.
  ```

## Exercise 2

### Architecture Highlights
- **Compliance & Hard Expiration:** Enforces a strict 180-day retention policy where objects are permanently deleted to meet regulatory limits.
- **Cost-Optimization:** Automatically transitions backup archives to S3 Glacier at 60 days to cut active storage costs.
- **Access:** Custom bucket policy explicitly allows external IAM roles (backup_uploader) to PutObject and AbortMultipartUpload.
- **Security Hardening:** Blocks all public access, mandates TLS/HTTPS-only requests, and applies default AES-256 encryption.
- **Versioning:** Enables versioning with automated expiration for noncurrent versions (21 days).

### Deployment Commands
- **Initialization/Deployment & Stage Selection:**
  ```bash
  terraform init -reconfigure -backend-config=tf-backend/<stage>.hcl
  terraform plan -var-file=stages/<stage>.tfvars
  terraform apply -var-file=stages/<stage>.tfvars
  ```

- **terraform plan output** 
VPC module is still included in this plan, so in total there is 7 resources to be created in the backup s3 module
  ```bash
  Plan: 32 to add, 0 to change, 0 to destroy.
  ```

## Exercise 3

## 1. Prerequisites (WSL2 / Linux)

If using Windows, run inside **WSL2** (`wsl --install` in PowerShell).

Ensure all required CLI tools are installed:

```bash
# Docker & Curl
sudo apt update && sudo apt install -y curl docker.io
sudo usermod -aG docker $USER && newgrp docker

# Minikube
curl -LO https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64
sudo install minikube-linux-amd64 /usr/local/bin/minikube && rm minikube-linux-amd64

# Kubectl
curl -LO "[https://dl.k8s.io/release/$(curl](https://dl.k8s.io/release/$(curl) -L -s [https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl](https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl)"
sudo install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl && rm kubectl

# Helm
curl [https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3](https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3) | bash
```

## 2. Deploy

Make scripts executable and run deploy.sh with a required version tag and environment ( It actually only works for DEV ):

```bash
chmod +x deploy.sh destroy.sh
./deploy.sh 1.0.0
```

The script automatically:

Starts Minikube if it is not running.

Builds the image directly inside Minikube's local Docker daemon (no remote registry needed).

Deploys the application using Helm.

Opens and verifies the port-forward tunnel to localhost.

**Note on Upgrading / Versioning:** 
- If a newer release of the service is provided:
	1. Copy the new Linux binary into the `binaries/` directory (ensure it matches the name configured in the `Dockerfile`).
	2. Run `./deploy.sh <new-version>`.
Specifying an incremented version tag creates a separate container image inside Minikube, preserving previous images locally so you can easily roll back or switch versions without rebuilding.


## 3. Verify

Query the endpoint in a separate terminal:
```bash
curl http://localhost:8080/hello-world
```

Expected response:

```bash
{"message":"Hello World!"}
```

## 4. Destroy

to destroy the whole minikube cluster, run the following script:

```bash
./destroy.sh
```

