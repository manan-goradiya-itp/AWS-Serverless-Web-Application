module "lambda_function" {
  source = "terraform-aws-modules/lambda/aws"

  function_name = "Manan-RequestUnicorn"
  description   = "Lambda function for Wildride task"
  handler       = "index.handler"
  runtime       = "nodejs16.x" #"python3.8"
  #lambda_role = "MananLambdaDynamoDB"
  lambda_role = module.iam.lambda-iam
  source_path = "C:/Terraform training/AWS-wildrydes/index.js" #"../src/lambda-function1"
  create_role = false

}