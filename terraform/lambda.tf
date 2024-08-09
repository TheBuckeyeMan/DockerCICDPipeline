#Deploy from Docker Image
resource "aws_lambda_function" "adam_lambda_function" {
  function_name = "adam-lambda-for-cicd"
  role          = "arn:aws:iam::${data.aws_caller_identity.current.account_id}:role/lambda_role_cicd"
  package_type   = "Image"  # Specify that you are deploying from a container image
  image_uri      = "thebuckeyeman20/cicd:image1"  # Replace with your Docker image <username(not email)/repo name:tag>
  timeout     = 5
}

# Data source to fetch the current AWS account ID
data "aws_caller_identity" "current" {}




















#The Resource - AWS LAMBDA - Below Works as intended, uploads jar file specified

# resource "aws_lambda_function" "adam_lambda_function" {
#   function_name = "adam-lambda-for-cicd"
#   role          = "arn:aws:iam::${data.aws_caller_identity.current.account_id}:role/lambda_role_cicd"
#   handler       = "com.example.demo.HelloWorldHandler::handleRequest"
#   runtime       = "java11"  # or any runtime you prefer
#   filename         = "../target/DockerCICDPipeline-0.0.1-SNAPSHOT.jar" # or provide a path to an actual deployment package
#   source_code_hash = filebase64sha256("../target/DockerCICDPipeline-0.0.1-SNAPSHOT.jar")
#   timeout     = 5
# }

# # Data source to fetch the current AWS account ID
# data "aws_caller_identity" "current" {}
