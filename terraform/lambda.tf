resource "aws_lambda_function" "adam_lambda_function" {
  function_name = "adam-lambda-for-cicd"
  role          = "arn:aws:iam::${data.aws_caller_identity.current.account_id}:role/lambda_role_cicd"
  handler       = "com.example.demo.HelloWorldHandler::handleRequest"
  runtime       = "java11"  # or any runtime you prefer

  # If you don't have a deployment package, you can leave these fields commented out or empty
  # filename     = "./target/DockerCICDPipeline-0.0.1-SNAPSHOT.jar"
  # source_code_hash = filebase64sha256("./target/DockerCICDPipeline-0.0.1-SNAPSHOT.jar")

  # You can provide an empty deployment package if required
  filename         = "empty.zip" # or provide a path to an actual deployment package
  source_code_hash = filebase64sha256("empty.zip")

  # Optionally, you can set up environment variables
#   environment {
#     variables = {
#       ENV_VAR_1 = "value1"
#       ENV_VAR_2 = "value2"
#     }
#   }

  # You can also set up other options like memory size, timeout, etc.
  #memory_size = 128
  timeout     = 5
}

# Data source to fetch the current AWS account ID
data "aws_caller_identity" "current" {}
