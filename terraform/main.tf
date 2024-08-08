resource "aws_s3_bucket" "adams-test-bucket" {
  bucket = "adams-test-bucket-for-cicd-unique-name-76492615"  # Replace with a unique bucket name
  tags = {
    Name        = "adams-test-bucket"
    Environment = "dev"
  }
}
