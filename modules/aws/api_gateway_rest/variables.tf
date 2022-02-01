variable "api_name" {
  description = "Name of the API"
}

variable "api_description" {
  description = "Description for the api"
}

variable "api_resource" {
  description = "The last path segment of this API resource."
}

variable "api_http_method" {
  description = "The last path segment of this API resource."
}

variable "api_authorization" {
  description = "The last path segment of this API resource."
}

variable "lambda_integration_type" {
  description = "The integration input's type.  Valid values are AWS, AWS_PROXY for lambda"
}

variable "invocation_type_header" {
  description = "A map of request query string parameters and headers that should be passed to the backend responder."
  default = "'RequestResponse'"
}

variable "region" {
  description = "Name of current region"
}

variable "aws_account" {
  description = "AWS Account ID"
}