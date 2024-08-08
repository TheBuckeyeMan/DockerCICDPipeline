output "bucket_name" {
  value = aws_s3_bucket.adams_test_bucket.bucket
  description = "The name of the S3 bucket"
}