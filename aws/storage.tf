resource "random_string" "suffix" {
  length  = 6
  special = false
  upper   = false
}

resource "aws_s3_bucket" "storage_bucket" {
  bucket = "${var.resource_name}-${random_string.suffix.result}"
  force_destroy = true
}

output "s3_bucket_name" {
  description = "The name of the S3 bucket"
  value       = aws_s3_bucket.storage_bucket.id
}