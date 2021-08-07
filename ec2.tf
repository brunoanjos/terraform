resource "aws_instance" "hammer-instance" {
  ami           = var.ami
  instance_type = var.instance_type

  tags = {
    Name        = var.name
    Environment = var.env
    Provisioner = "Terraform"
    Auto-Start  = "true"
  }
}