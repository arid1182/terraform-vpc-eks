resource "aws_iam_role" "ebs_csi_iam_role" {
  name               = "${local.name}-ebs_csi_iam_role" 
  assume_role_policy = data.aws_iam_policy_document.assume_role.json

  tags = {
    Name = "${local.name}-ebs_csi_iam_role"
    Environment = var.aws_environment
    Component = "EBS CSI Driver"
  }
}

resource "aws_iam_role_policy_attachment" "ebs_csi_iam_role_policy_attachment" {
  role       = aws_iam_role.ebs_csi_iam_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonEBSCSIDriverPolicy"
}

output "ebs_csi_iam_role_arn" {
  value       = aws_iam_role.ebs_csi_iam_role.arn
  description = "The ARN of the EBS CSI IAM Role"
}