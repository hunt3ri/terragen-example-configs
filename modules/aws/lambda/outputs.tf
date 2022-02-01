output "lambda_function_name" {
  description = "The name of the Lambda Function"
  value = module.lambda_function.lambda_function_name
}

output "lambda_function_invoke_arn" {
  description = "The Invoke ARN of the Lambda Function"
  value = module.lambda_function.lambda_function_invoke_arn
}