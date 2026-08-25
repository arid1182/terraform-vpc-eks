# Datasource: AWS Load Balancer Controller IAM Policy get from aws-load-balancer-controller/ GIT Repo (latest)
data "http" "lbc_iam_policy_document" {
  url = "https://raw.githubusercontent.com/kubernetes-sigs/aws-load-balancer-controller/main/docs/install/iam_policy.json"

# Optional 
  request_headers = {
    Accept = "application/json"
  }
}   

# Resource: Create AWS Load Balancer Controller IAM Policy 
resource "aws_iam_policy" "lbc_iam_policy" {
  name        = "${local.name}-AWSLoadBalancerControllerIAMPolicy"
  description = "IAM policy for AWS Load Balancer Controller"
  policy = data.http.lbc_iam_policy_document.response_body
  path        = "/"
}

# Resource: LBC IAM Role
resource "aws_iam_role" "lbc_iam_role" {
  name               = "${local.name}-AWSLoadBalancerControllerIAMRole"
  path               = "/"
  assume_role_policy = data.aws_iam_policy_document.assume_role.json # <--- Direct reference

  tags = {
    Name        = "${local.name}-AWSLoadBalancerControllerIAMRole"
    Environment = var.aws_environment
    Component   = "AWS Load Balancer Controller"
  }
}

# Associate Load Balanacer Controller IAM Policy to  IAM Role
resource "aws_iam_role_policy_attachment" "lbc_iam_role_policy_attachment" {
  role       = aws_iam_role.lbc_iam_role.name
  policy_arn = aws_iam_policy.lbc_iam_policy.arn
}


# Outputs
output "lbc_iam_policy_arn" {
  value       = aws_iam_policy.lbc_iam_policy.arn
  description = "The ARN of the AWS Load Balancer Controller IAM Policy"
}

output "lbc_iam_role_arn" {
  value       = aws_iam_role.lbc_iam_role.arn
  description = "The ARN of the AWS Load Balancer Controller IAM Role"
}