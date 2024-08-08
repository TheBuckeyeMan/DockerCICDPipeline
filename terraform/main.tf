#s3 bucket
resource "aws_s3_bucket" "adams-test-bucket" {
  bucket = "adams-test-bucket-for-cicd-unique-name-76492615"  # Replace with a unique bucket name
  tags = {
    Name        = "adams-test-bucket"
    Environment = "dev"
  }
}



# #Lambda reosurce
# resource "aws_lambda_function" "my_lambda_function" {
#   function_name = "my_lambda_function"
#   role          = aws_iam_role.lambda_exec.arn
#   handler       = "index.handler"
#   runtime       = "java11"  # Update to the runtime you're using, e.g., java11, nodejs14.x, etc.

#   # Ensure you have a ZIP file of your Lambda function code
#    s3_bucket = aws_s3_bucket.adams-test-bucket.bucket
# #   s3_key    = "path/to/your/lambda-deployment-package.zip"
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


