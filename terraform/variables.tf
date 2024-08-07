variable "aws_region" {
    description = "The AWS Region to deploy to"
    type = string
    default = "us-east-2"
}
variable "lambda_function_name"{
    description = "The name of the lambda function"
    type = string
    default = "my_lambda_function"
}

variable "docker-image_uri"{
    description = "The name of the docker image uri in docker hub"
    type = string
}
