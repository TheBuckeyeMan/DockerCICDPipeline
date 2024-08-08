resource "aws_s3_bucket" "example" {
  bucket = "unique-bucket-74739037450973402752947054"

  tags = {
    Name        = "My bucket"
    Environment = "Dev"
  }
}