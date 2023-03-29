resource "aws_api_gateway_rest_api" "wildrydes-apigateway" {
  body = jsonencode({
    openapi = "3.0.1"
    info = {
      title   = "WildRydes"
      version = "1.0"
    }
  })

  name = "Manan-goradiya-wildrydes"

  endpoint_configuration {
    types = ["EDGE"]
  }
}



resource "aws_api_gateway_resource" "Manan-goradiya-wildrydes-resource" {
  #authorizer_id = aws_api_gateway_authorizer.wildrydes-authorizer.id
  rest_api_id = aws_api_gateway_rest_api.wildrydes-apigateway.id
  parent_id   = aws_api_gateway_rest_api.wildrydes-apigateway.root_resource_id
  path_part   = "ride"
  depends_on = [
    aws_api_gateway_rest_api.wildrydes-apigateway
  ]
}



resource "aws_api_gateway_authorizer" "wildrydes-authorizer" {
  name        = "Manan-goradiya-wildrydes-authorizer"
  rest_api_id = aws_api_gateway_rest_api.wildrydes-apigateway.id
  #authorizer_uri         = aws_lambda_function.authorizer.invoke_arn
  #authorizer_credentials = aws_iam_role.invocation_role.arn
  type          = "COGNITO_USER_POOLS"
  provider_arns = [module.cognoito.Manan-Goradiya-UserPool-arn] #module.cognoito.Manan-Goradiya-UserPool.arn]


}



resource "aws_api_gateway_method" "Manan-goradiya-wildrydes-method" {
  rest_api_id   = aws_api_gateway_rest_api.wildrydes-apigateway.id
  resource_id   = aws_api_gateway_resource.Manan-goradiya-wildrydes-resource.id
  http_method   = "POST"
  authorization = "COGNITO_USER_POOLS"
  authorizer_id = aws_api_gateway_authorizer.wildrydes-authorizer.id
  depends_on = [
    aws_api_gateway_resource.Manan-goradiya-wildrydes-resource
  ]
}



resource "aws_api_gateway_integration" "Manan-goradiya-wildrydes-integration" {
  rest_api_id             = aws_api_gateway_rest_api.wildrydes-apigateway.id
  resource_id             = aws_api_gateway_resource.Manan-goradiya-wildrydes-resource.id
  http_method             = aws_api_gateway_method.Manan-goradiya-wildrydes-method.http_method
  integration_http_method = "POST"
  type                    = "AWS_PROXY"
  uri                     = "arn:aws:apigateway:us-east-2:lambda:path/2015-03-31/functions/${module.lambda_function.lambda_function_arn}/invocations" #module.lambda_function.lambda_function_arn  #module.lambda_function.lambda_function_arn
  depends_on = [
    aws_api_gateway_method.Manan-goradiya-wildrydes-method,
    aws_api_gateway_resource.Manan-goradiya-wildrydes-resource
  ]
}



resource "aws_api_gateway_deployment" "wildrydes-restapi-deployment" {
  rest_api_id = aws_api_gateway_rest_api.wildrydes-apigateway.id

  depends_on = [
    aws_api_gateway_integration.Manan-goradiya-wildrydes-integration
  ]


  triggers = {
    redeployment = sha1(jsonencode([
      aws_api_gateway_resource.Manan-goradiya-wildrydes-resource.id,
      aws_api_gateway_method.Manan-goradiya-wildrydes-method.id,
      aws_api_gateway_integration.Manan-goradiya-wildrydes-integration.id,
    ]))
  }

  lifecycle {
    create_before_destroy = true
  }


}



resource "aws_api_gateway_stage" "example" {
  deployment_id = aws_api_gateway_deployment.wildrydes-restapi-deployment.id
  rest_api_id   = aws_api_gateway_rest_api.wildrydes-apigateway.id
  stage_name    = "test"
}





