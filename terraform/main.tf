resource "aws_s3_bucket" "example" {
  bucket = "unique-bucket-74739037450973402752947054"

  tags = {
    Name        = "My bucket"
    Environment = "Dev"
  }
}



#lambda
# IAM Role for Lambda Function
resource "aws_iam_role" "lambda_role" {
  name = "lambda_execution_role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole",
        Effect = "Allow",
        Principal = {
          Service = "lambda.amazonaws.com"
        }
      }
    ]
  })
}

# IAM Policy for Lambda Execution
resource "aws_iam_policy" "lambda_policy" {
  name        = "lambda_execution_policy"
  description = "Policy for Lambda execution"
  policy      = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action   = [
          "logs:*",
          "cloudwatch:*",
          "s3:*"  # Add other necessary permissions
        ]
        Effect   = "Allow"
        Resource = "*"
      }
    ]
  })
}

# Attach Policy to Role
resource "aws_iam_role_policy_attachment" "lambda_policy_attachment" {
  role       = aws_iam_role.lambda_role.name
  policy_arn = aws_iam_policy.lambda_policy.arn
}

# Lambda Function
resource "aws_lambda_function" "empty_lambda" {
  function_name = "empty_lambda_function"

#   # Replace with the path to your Lambda deployment package
#   s3_bucket        = "your-s3-bucket-name"  # The bucket containing the Lambda code
#   s3_key           = "path/to/your/lambda.zip"  # The path to your Lambda deployment package in the S3 bucket
#   handler          = "index.handler"  # The function within your code that Lambda calls to begin execution
#   runtime          = "nodejs14.x"  # Adjust based on the runtime you are using
  role             = aws_iam_role.lambda_role.arn

#   # Lambda function code can be empty or you can specify a placeholder file if needed
}