resource "aws_codecommit_repository" "Manan-Goradiya-Wildrydes" {
  repository_name = "Manan-Goradiya-Wildrydes"
  description     = "This is the Repository for Wildrydes task"
  default_branch  = var.default_branch
  tags = {
    "Name" = "Manan-Goradiya-Wildrydes"
  }
}

