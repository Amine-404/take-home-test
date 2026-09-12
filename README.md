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

