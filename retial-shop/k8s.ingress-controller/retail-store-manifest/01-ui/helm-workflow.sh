#!/bin/bash

set -e
echo "--------------------------------------------"
echo "Setting local env for Amazon Public ECR login"
echo "--------------------------------------------"


AWS_REGION=$(aws configure get region)
export AWS_REGION
AWS_ACCOUNT_ID=$(aws sts get-caller-identity --query Account --output text)
export AWS_ACCOUNT_ID
ECR_REGISTRY="${AWS_ACCOUNT_ID}.dkr.ecr.${AWS_REGION}.amazonaws.com"
export ECR_REGISTRY
ECR_REPOSITORY_NAME=$(aws ecr describe-repositories --query 'repositories[0].repositoryName' --output text)
export ECR_REPOSITORY_NAME

# Authenticate to Amazon Public ECR (token valid for 12 hours)
echo "--------------------------------------------"
echo "Logging in to Amazon Public ECR"
echo "--------------------------------------------"
aws ecr get-login-password --region ${AWS_REGION} | helm registry login --username AWS --password-stdin ${ECR_REGISTRY}

echo "--------------------------------------------"
echo "ECR Repository Name: $(aws ecr describe-repositories --repository-names ${ECR_REPOSITORY_NAME} --query 'repositories[0].repositoryUri' --output text)"
echo "--------------------------------------------"


# Package chart (matches Chart.yaml)
cd chart/
helm package ./ui/

# Push to ECR (OCI): IMPORTANT: push to registry root (no suffix) ---
helm push ui-1.3.0.tgz oci://"$ECR_REGISTRY"/retail-store

# Verify
aws ecr describe-images --repository-name ${ECR_REPOSITORY_NAME} --region "$AWS_REGION" --query 'imageDetails[].imageTags'