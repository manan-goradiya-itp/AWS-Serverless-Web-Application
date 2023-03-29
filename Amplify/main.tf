resource "aws_amplify_app" "Manan-goradiya-wildrydes" {
  name                 = "Manan-goradiya-wildrydes"
  repository           = var.repository
  iam_service_role_arn = var.iam_service_role_arn #aws_iam_role.amplify-codecommit.arn
  #branch_name ="master" #var.branch_name

}


resource "aws_amplify_branch" "Manan-goradiya-wildrydes-branch" {
  app_id      = aws_amplify_app.Manan-goradiya-wildrydes.id
  branch_name = var.branch_name
}