# Launch a Webserver Instance hosting Porttutorial in it.
resource "aws_instance" "porttutorial" {
  depends_on = [
    aws_vpc.myvpc,
    aws_subnet.public-subnet,
    aws_key_pair.mykeypair,
    aws_security_group.sg-ec2
  ]

  # AMI ID - Amazon Linux 2 AMI (HVM) - Kernel 5.10, SSD Volume Type
  ami           = var.ami
  
  instance_type = var.instance_type

  count = length(aws_subnet.public-subnet)

  subnet_id     = aws_subnet.public-subnet[count.index].id

  key_name = "tf-deploy"

  # Security groups to use
  vpc_security_group_ids = [aws_security_group.sg-ec2.id]

  user_data     = file("container-setup.sh")

  tags = {
    Name = "Webserver Porttutorial"
  }
}