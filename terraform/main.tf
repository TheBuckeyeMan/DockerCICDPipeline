resource "aws_s3_bucket" "adams_test_bucket" {
  bucket = "adams_test_bucket_for_cicd_unique_name_76492615"  # Replace with a unique bucket name
  tags = {
    Name        = "adams_test_bucket"
    Environment = "dev"
  }
}