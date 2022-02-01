module "lambda_function" {
  # Module documentation at link - https://registry.terraform.io/modules/terraform-aws-modules/lambda/aws/latest
  source = "terraform-aws-modules/lambda/aws"

  function_name = var.function_name
  description   = var.function_description
  handler       = var.handler
  runtime       = var.runtime
  timeout       = var.timeout

  source_path = var.source_path

  environment_variables = var.env_vars

  # Attach existing role to allow access to S3
  create_role = var.create_role
  lambda_role = var.lambda_role

  layers = var.layers

  tags = {
    Name = var.function_name
  }
}
