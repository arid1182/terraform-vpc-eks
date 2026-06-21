# Resource-1: Create S3 Bucket. Set Name Using Random String 
resource "random_string" "suffix" {
    length = 8
    upper = false
    special = false 
}
resource "aws_s3_bucket" "tfstate_bucket" {
  bucket = "tfstate-${var.aws_environment}-${var.aws_region}-${random_string.suffix.result}"
  tags = merge(var.tags, { Environment = "${var.aws_environment}"})
  lifecycle {
    prevent_destroy = false
  }
}

# Resource-2: AWS Bucket Versioning
resource "aws_s3_bucket_versioning" "tfstate_version" {
  bucket = aws_s3_bucket.tfstate_bucket.id
  versioning_configuration {
    status = "Enabled"
  }
}

# Resource-3: AWS S3 Bucket Server Side Encryption Configuration
resource "aws_s3_bucket_server_side_encryption_configuration" "tfstate_encryption" {
  bucket = aws_s3_bucket.tfstate_bucket.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm     = "AES256"
    }
  }
}
# Resource-4: AWS S3 Bucket Public Access Block
resource "aws_s3_bucket_public_access_block" "tfstate_block" {
  bucket = aws_s3_bucket.tfstate_bucket.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = false
  restrict_public_buckets = false
}