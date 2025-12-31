resource "tls_private_key" "devops_ssh_key_algorithm" {
  algorithm = "RSA"
  rsa_bits = 4096
}

resource "aws_key_pair" "devops_ssh_key" {
  key_name = "devops_ssh_key"
  public_key = tls_private_key.devops_ssh_key_algorithm.public_key_openssh
}

resource "local_file" "ssh_private_key" {
  content = tls_private_key.devops_ssh_key_algorithm.private_key_pem
  filename = "devops-ssh-key.pem"
  file_permission = "0400"
}
