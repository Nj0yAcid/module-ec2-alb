resource "tls_private_key" "pv-key" {
  algorithm = "RSA"
  rsa_bits  = 2048
}

resource "aws_key_pair" "keylamp" {
  key_name   = "keytra"
  public_key = tls_private_key.pv-key.public_key_openssh
}

resource "local_file" "key" {
  filename = "keytra.pem"
  content  = tls_private_key.pv-key.private_key_pem
}