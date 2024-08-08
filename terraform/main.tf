#s3 bucket
resource "aws_s3_bucket" "adams-test-bucket" {
  bucket = "adams-test-bucket-for-cicd-unique-name-76492615"  # Replace with a unique bucket name
  tags = {
    Name        = "adams-test-bucket"
    Environment = "dev"
  }
}
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



//Add in the java executable jar file to the s3 bucket
# resource "aws_s3_object" "lambda_jar" {
#   bucket = aws_s3_bucket.football-data-s3-adam-maas-12202.bucket
#   key    = "APIData-0.0.1-SNAPSHOT.jar"
#   source = "/Users/adammaas/Desktop/GitHub_Repositories/s3_data_landing/save_file_to_s3_springboot_app/target/APIData-0.0.1-SNAPSHOT.jar"
# }



//IAM Roles associated with the sd3 bucket resource "aws_iam_policy" "s3_bucket_creation_policy" {






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


