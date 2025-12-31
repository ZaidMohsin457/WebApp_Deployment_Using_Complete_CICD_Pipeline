resource "aws_iam_user" "devops_user" {
  name = "devops_user"

  force_destroy = true
}

resource "aws_iam_user_policy_attachment" "admin_policy" {
  user = aws_iam_user.devops_user.name
  policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess"
}

resource "aws_iam_access_key" "devops_user_access_key" {
  user = aws_iam_user.devops_user.name
}

resource "aws_iam_user_login_profile" "devops_user_console_access" {
  user = aws_iam_user.devops_user.name
}

data "aws_iam_policy_document" "ec2_ecr_assume" {
  statement {
    actions = ["sts:AssumeRole"]
    principals {
      type = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }
  }
}

resource "aws_iam_role" "ec2_role" {
  name               = "ec2-ecr-pull-role"
  assume_role_policy = data.aws_iam_policy_document.ec2_ecr_assume.json
}

resource "aws_iam_role_policy_attachment" "attach_ecr" {
  role       = aws_iam_role.ec2_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
}

resource "aws_iam_instance_profile" "ec2_profile" {
  name = "ec2-ecr-profile"
  role = aws_iam_role.ec2_role.name
}
