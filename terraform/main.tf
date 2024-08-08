resource "aws_s3_bucket" "example" {
  bucket = "unique-bucket-74739037450973402752947054"

  tags = {
    Name        = "My bucket"
    Environment = "Dev"
  }
}



#lambda
# Create the Lambda function
resource "aws_lambda_function" "adam-lambda-for-springbootapp" {
  function_name = "adam-lambda-for-springbootapp"
  role          = "arn:aws:iam::339712758982:role/lambda_role_cicd"
 # handler       = "com.example.demo.HelloWorldHandler::handleRequest"
  runtime       = "java11"  # or "java8"
# The below is if we want to upload directly to lambda, however, we wouldnt be storing on the cloud. best practice it to store the executable file via s3 then run from that. We stil need source_code_hash if we want to use lambda with this method instead of havingthe file avaliable via s3
   filename     = "DockerCICDPipeline/target/DockerCICDPipeline-0.0.1-SNAPSHOT.jar" #Update this with whatever jar executable file you want to run in the lambda function
 }


#Lambda function for TF

# Attach the basic execution policy to the role
# resource "aws_iam_role_policy_attachment" "lambda_policy_attachment" {
#   role       = aws_iam_role.lambda_role_cicd.name
#   policy_arn = "arn:aws:iam::339712758982:role/lambda_role_cicd"
# }