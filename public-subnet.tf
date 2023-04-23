# Public subnet with 2 AZs
resource "aws_subnet" "public-subnet" {
  depends_on = [
    aws_vpc.myvpc
  ]

  count = length(var.az_public)

  # VPC in which subnet will be created
  vpc_id     = aws_vpc.myvpc.id
  cidr_block = var.public_subnet_range[count.index]


  # The AZs for the subnet
  availability_zone = var.az_public[count.index]


  # Specify true to indicate that instances launched into the subnet should be assigned a public IP address
  map_public_ip_on_launch = true

  tags = {
    Name = "Public Subnet Porttutorial"
  }
}