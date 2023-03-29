output "arn" {
  value = aws_iam_role.amplify-codecommit.arn
}


output "lambda-iam" {
  value = aws_iam_role.lambda-role.arn
}