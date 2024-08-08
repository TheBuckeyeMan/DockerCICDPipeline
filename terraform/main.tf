resource "aws_s3_bucket" "Adams_test_bucket_for_cicd_unique_name_76492615" {
  bucket = "Adams_test_bucket_for_cicd_unique_name_76492615"  # Replace with a unique bucket name

  tags = {
    Name        = "Adams_test_bucket_for_cicd_unique_name_76492615"
    Environment = "dev"
  }
}