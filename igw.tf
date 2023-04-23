#Internet Gateway 
resource "aws_internet_gateway" "igw" {
  depends_on = [
    aws_vpc.myvpc,
    aws_subnet.public-subnet,
  ]

  # VPC in which IGW will be created
  vpc_id = aws_vpc.myvpc.id

  tags = {
    Name = "IGW Porttutorial"
  }
}