#!/bin/bash
set -e

echo "==============================="
echo "STEP-1: Destroy EKS Cluster using Terraform"
echo "==============================="
cd EKS_terraform-manifests_with_addons
terraform destroy -auto-approve

echo
echo "==============================="
echo "STEP-2: Destroy VPC using Terraform"
echo "==============================="
cd ../VPC_terraform-manifests
terraform destroy -auto-approve

echo
echo "✅ EKS Cluster and VPC destruction completed successfully!"
