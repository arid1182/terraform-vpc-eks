variable "aws_region" {
    description = "this is aws vpc region"
    default = "us-east-1"
    type = string
}

variable "aws_environment" {
    description = "this is envrironment for aws vpc"
    type = string
    default = "dev"
}

variable "vpc_cidr" {
    description = "this is the cidr block for vpc"
    type = string
    default = "10.0.0.0/16"
}
variable "tags" {
    description = "the tags policy for aws vpc"
    type = map(string)
    default = {
      terraform = true
      Project = "Retail Shop"
      Owner = "Mubasher Hassan"
    }
  
}