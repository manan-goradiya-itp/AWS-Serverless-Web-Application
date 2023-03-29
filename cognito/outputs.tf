output "Manan-Goradiya-UserPool" {
  value = aws_cognito_user_pool.Manan-Goradiya-UserPool.id
}

output "Manan-Goradiya-UserPool-arn" {
  value = aws_cognito_user_pool.Manan-Goradiya-UserPool.arn
}

output "Manan-Goradiya-UserPool-clientid" {
  value = aws_cognito_user_pool_client.Manan-Goradiya-UserPool-client.id
}