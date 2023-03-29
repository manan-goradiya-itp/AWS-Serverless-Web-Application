module "codecommit" {
  source          = "./codecommit"
  repository_name = "Manan-Goradiya-Wildrydes"
  default_branch  = "master"
}

module "iam" {
  source = "./iam"
}

module "amplify" {
  source      = "./Amplify"
  repository  = module.codecommit.clone_url_http
  branch_name = "master"
  depends_on = [
    module.codecommit,
    module.iam
  ]
  iam_service_role_arn = module.iam.arn #aws_iam_role.amplify-codecommit.arn
}

module "ses" {
  source = "./ses"
}

module "cognoito" {
  source = "./cognito"
  depends_on = [
    module.ses
  ]
  source_arn = module.ses.ses_arn
}