variable "function_name" {
  description = "A unique name for your Lambda Function"
}

variable "function_description" {
  description = "Description of your Lambda Function"
}

variable "handler" {
  description = "Lambda Function entrypoint in your code"
}

variable "runtime" {
  description = "Lambda Function runtime"
}

variable "timeout" {
  description = "The amount of time your Lambda Function has to run in seconds."
}

variable "source_path" {
  description = "The absolute path to a local file or directory containing your Lambda source code"
}

variable "create_role" {
  description = "Controls whether IAM role for Lambda Function should be created"
}

#variable "lambda_role" {
#  description = "IAM role ARN attached to the Lambda Function. This governs both who / what can invoke your Lambda Function, as well as what resources our Lambda Function has access to. See Lambda Permission Model for more details."
#}

variable "layers" {
  description = "List of Lambda Layer Version ARNs (maximum of 5) to attach to your Lambda Function."
}

variable "env_vars" {
  description = "A map that defines environment variables for the Lambda Function"
  type = map(string)
}
