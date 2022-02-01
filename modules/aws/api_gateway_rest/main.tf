resource "aws_api_gateway_rest_api" "api" {
  # Create the empty api-gateway
  name        = var.api_name
  description = var.api_description
  endpoint_configuration {
    types = ["REGIONAL"]
  }
}

resource "aws_api_gateway_resource" "resource" {
  # Attach a resource to the API
  path_part   = var.api_resource
  parent_id   = aws_api_gateway_rest_api.api.root_resource_id
  rest_api_id = aws_api_gateway_rest_api.api.id
}

resource "aws_api_gateway_method" "method" {
  # Provides a HTTP Method for an API Gateway Resource, eg GET, POST etc
  rest_api_id   = aws_api_gateway_rest_api.api.id
  resource_id   = aws_api_gateway_resource.resource.id
  http_method   = var.api_http_method
  authorization = var.api_authorization
}

resource "aws_api_gateway_integration" "integration" {
  #Provides an HTTP Method Integration for an API Gateway Integration.
  rest_api_id             = aws_api_gateway_rest_api.api.id
  resource_id             = aws_api_gateway_resource.resource.id
  http_method             = aws_api_gateway_method.method.http_method
  integration_http_method = "POST"    # Note lambda function can only be invoked via POST
  type                    = var.lambda_integration_type
  uri                     = data.terraform_remote_state.lambda.outputs.lambda_function_invoke_arn

  # X-Amz-Invocation-Type header allows to control whether endpoint is async or not, see docs at link below
  # https://docs.aws.amazon.com/apigateway/latest/developerguide/set-up-lambda-integration-async.html
  request_parameters = {
    "integration.request.header.X-Amz-Invocation-Type" = var.invocation_type_header
  }
}

# Lambda
resource "aws_lambda_permission" "apigw_lambda" {
  # Gives API-Gateway permission to access the Lambda function.
  statement_id  = "AllowExecutionFromAPIGateway"
  action        = "lambda:InvokeFunction"
  #function_name = "scot_covid_geocoder"
  function_name = data.terraform_remote_state.lambda.outputs.lambda_function_name
  principal     = "apigateway.amazonaws.com"

  # More: http://docs.aws.amazon.com/apigateway/latest/developerguide/api-gateway-control-access-using-iam-policies-to-invoke-api.html
  source_arn = "arn:aws:execute-api:${var.region}:${var.aws_account}:${aws_api_gateway_rest_api.api.id}/*/${aws_api_gateway_method.method.http_method}${aws_api_gateway_resource.resource.path}"
}

resource "aws_api_gateway_method_response" "response_200" {
  # Provides an HTTP Method Response for an API Gateway Resource.
  rest_api_id = aws_api_gateway_rest_api.api.id
  resource_id = aws_api_gateway_resource.resource.id
  http_method = aws_api_gateway_method.method.http_method
  status_code = "200"
}

resource "aws_api_gateway_integration_response" "api_integration_response" {
  # Provides an HTTP Method Integration Response for an API Gateway Resource
  rest_api_id = aws_api_gateway_rest_api.api.id
  resource_id = aws_api_gateway_resource.resource.id
  http_method = aws_api_gateway_method.method.http_method
  status_code = aws_api_gateway_method_response.response_200.status_code
}
