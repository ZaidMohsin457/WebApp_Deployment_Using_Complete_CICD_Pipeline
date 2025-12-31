resource "aws_ecr_repository" "devops_repo" {
  name         = "devops-practice"
  force_delete = true  # Allows Terraform to delete the repo even if it contains images
}
