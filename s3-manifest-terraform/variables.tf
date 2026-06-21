variable "aws_region" {
    description = "the defualt region"
    type = string
    default = "us-east-1"
}

variable "aws_environment" {
  description = "Deployment Nnvironment"
  type = string
  default = "dev"
}

variable "tags" {
    description = "The Tags policy for the resources"
    type = map(string)
    default = {
      Name        = "tfstate"
      Project     = "remote-backend-for-devops-real-world-course"
      Purpose     = "terraform-backend"
    }
}