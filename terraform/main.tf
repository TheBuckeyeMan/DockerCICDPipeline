# #s3 bucket
# resource "aws_s3_bucket" "adams-test-bucket" {
#   bucket = "adams-test-bucket-for-cicd-unique-name-76492615"  # Replace with a unique bucket name
#   tags = {
#     Name        = "adams-test-bucket"
#     Environment = "dev"
#   }
# }
# #Enables s3 bucket versioning so we can overrite the s3 bucket and not fail terraform apply 
# resource "aws_s3_bucket_acl" "adams-test-bucket" {
#   bucket = aws_s3_bucket.adams-test-bucket.id
#   acl    = "private"
# }
# resource "aws_s3_bucket_versioning" "adams-test-bucket" {
#   bucket = aws_s3_bucket.adams-test-bucket.id
#   versioning_configuration {
#     status = "Enabled"
#   }
# }

resource "aws_s3_bucket" "football-data-s3-adam-maas-12202" {
  bucket = "football-data-s3-adam-maas-12202"  # Change to your desired bucket name
}

resource "aws_s3_bucket_public_access_block" "football-data-s3-adam-maas-12202_public_access" {
  bucket = aws_s3_bucket.football-data-s3-adam-maas-12202.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

//Add in the java executable jar file to the s3 bucket
# resource "aws_s3_object" "lambda_jar" {
#   bucket = aws_s3_bucket.football-data-s3-adam-maas-12202.bucket
#   key    = "APIData-0.0.1-SNAPSHOT.jar"
#   source = "/Users/adammaas/Desktop/GitHub_Repositories/s3_data_landing/save_file_to_s3_springboot_app/target/APIData-0.0.1-SNAPSHOT.jar"
# }



//IAM Roles associated with the sd3 bucket resource "aws_iam_policy" "s3_bucket_creation_policy" {
resource "aws_iam_policy" "s3_bucket_creation_policy" {
  name        = "S3BucketCreationPolicy"
  description = "Policy to allow creating S3 buckets"
  policy      = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect   = "Allow"
        Action   = [
          "s3:CreateBucket",
          "s3:PutBucketAcl",
          "s3:PutBucketPolicy",
          "s3:PutBucketLogging",
          "s3:PutBucketNotification",
          "s3:PutBucketTagging",
          "s3:PutBucketVersioning",
          "s3:PutBucketWebsite"
        ]
        Resource = "arn:aws:s3:::*"
      }
    ]
  })
}

resource "aws_iam_user_policy_attachment" "example_user_attach_policy" {
  user       = aws_iam_user.example_user.name
  policy_arn = aws_iam_policy.s3_bucket_creation_policy.arn
}

resource "aws_iam_user_policy_attachment" "example_user_attach_s3_full_access" {
  user       = aws_iam_user.example_user.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonS3FullAccess"
}



















# #Lambda reosurce
# resource "aws_lambda_function" "my_lambda_function" {
#   function_name = "my_lambda_function"
#   role          = aws_iam_role.lambda_exec.arn
#   handler       = "index.handler"
#   runtime       = "java11"  # Update to the runtime you're using, e.g., java11, nodejs14.x, etc.

#   # Ensure you have a ZIP file of your Lambda function code
#    s3_bucket = aws_s3_bucket.adams-test-bucket.bucket
#    s3_key    = "DockerCICDPipeline-0.0.1-SNAPSHOT.jar"
# }

# #Lambda IAM role:
# resource "aws_iam_role" "lambda_exec" {
#   name = "lambda_exec_role"

#   assume_role_policy = jsonencode({
#     Version = "2012-10-17"
#     Statement = [
#       {
#         Action = "sts:AssumeRole"
#         Effect = "Allow"
#         Principal = {
#           Service = "lambda.amazonaws.com"
#         }
#       },
#     ]
#   })
# }

# resource "aws_iam_role_policy_attachment" "lambda_policy" {
#   role       = aws_iam_role.lambda_exec.name
#   policy_arn  = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
# }


