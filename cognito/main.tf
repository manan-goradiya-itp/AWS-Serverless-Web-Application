resource "aws_cognito_user_pool" "Manan-Goradiya-UserPool" {
  name              = "Manan-Goradiya-wildrudes"
  mfa_configuration = "OFF"

  email_configuration {
    email_sending_account = "DEVELOPER"
    from_email_address    = "manangoradiya.devops@gmail.com"
    source_arn            = var.source_arn
  }
}


resource "aws_cognito_user_pool_client" "Manan-Goradiya-UserPool-client" {
  name = "Manan-Goradiya-wildrydes"

  user_pool_id = aws_cognito_user_pool.Manan-Goradiya-UserPool.id
}


