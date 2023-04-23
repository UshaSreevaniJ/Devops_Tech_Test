# Associate the routing table to the Public Subnet 
resource "aws_route_table_association" "rt-association" {
  depends_on = [
    aws_vpc.myvpc,
    aws_subnet.public-subnet,
    aws_route_table.public-subnet-rt
  ]

  # Public Subnet ID
  count = length(aws_subnet.public-subnet)

  subnet_id     = aws_subnet.public-subnet[count.index].id

  #  Route Table ID
  route_table_id = aws_route_table.public-subnet-rt.id
}