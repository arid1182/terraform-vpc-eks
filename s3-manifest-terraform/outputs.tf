output "tfstate_bucket_arn" {
    description = "The ARN of the tfstate_bucket"
    value = aws_s3_bucket.tfstate_bucket.arn
}

output "tfstate_bucket_id" {
    description = "The Id of tfstate_bucket"
    value = aws_s3_bucket.tfstate_bucket.id
}