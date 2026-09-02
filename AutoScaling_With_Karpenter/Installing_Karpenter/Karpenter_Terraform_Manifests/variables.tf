variable "aws_region" {
    description = "aws region for deploy resources"
    type = string
    default = "us-east-1"

}

variable "environment_name" {
    description = "deployment environment"
    type = string
    default = "dev"
}

variable "business_division" {
    type = string
    default = "retail"
    description = "business division belongs to"
}

variable "tags" {
    description = "tags to be applied to all resources"
    type = map(string)
    default = {
        terraform = "true"
    }
}