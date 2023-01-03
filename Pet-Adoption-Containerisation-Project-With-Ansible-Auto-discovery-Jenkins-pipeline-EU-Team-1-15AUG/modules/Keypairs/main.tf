#create Keypair
resource "aws_key_pair" "PACAAD1" {
  key_name   = var.key_name
  public_key = file(var.path-to-publickey)
}
