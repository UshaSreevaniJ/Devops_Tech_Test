# Create a Security Group for the Porttutorial ALB, so that anyone in the outside world can send requests
resource "aws_security_group" "sg-alb" {


  # Name of the ALB security group
  name        = "Porttutorial-ALB-Sg"
  description = "Allow outside world to access the instance via HTTP"

  # VPC ID in which Security group has to be created!
  vpc_id = aws_vpc.myvpc.id

  # Create an inbound rule for ALB HTTP access
  ingress {
    description = "HTTP to ALB"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }


  # Outward Network Traffic from the Porttutorial ALB
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "Porttutorial-ALB-Sg"
  }
}