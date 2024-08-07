resource "aws_lambda_function" "my_lambda_function" {
  function_name = var.lambda_function_name
  role          = aws_iam_role.lambda_role.arn
  package_type  = "Image"
  image_uri     = var.docker_image_uri

  memory_size   = 512
  timeout       = 30

  environment {
    variables = {
      SPRING_PROFILES_ACTIVE = "dev"
    }
  }
}
