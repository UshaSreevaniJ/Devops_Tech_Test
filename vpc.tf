#  VPC
resource "aws_vpc" "myvpc" {

  # CIDR block
  cidr_block = var.cidr_block

  # DNS support
  enable_dns_support = true

  tags = {
    Name = "VPC Porttutorial"
  }
}