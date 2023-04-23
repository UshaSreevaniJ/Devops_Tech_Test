resource "aws_alb" "alb" {  
  name            = "Porttutorial-App"  
  subnets         = "${aws_subnet.public-subnet.*.id}"
  security_groups = ["${aws_security_group.sg-alb.id}"]
}

resource "aws_alb_target_group" "alb_target_group" {  

  name     = "Porttutorial-ALB-Tg"  
  port     = "80"  
  protocol = "HTTP"  
  vpc_id   = aws_vpc.myvpc.id    
   
  health_check {    
    healthy_threshold   = 3    
    unhealthy_threshold = 10    
    timeout             = 5    
    interval            = 10   
    protocol            = "HTTP" 
    path                = "/"
    port                = "traffic-port"
  }
}

locals {
  
 association = flatten([
    for instance in aws_instance.porttutorial : [
    for portnum in var.ec2_ports : {
        instance = instance
        portnum = portnum
    }
  ]])
}


resource "aws_lb_target_group_attachment" "lb_target_group_attachment" {

    count  = length(local.association)
    target_group_arn   = aws_alb_target_group.alb_target_group.arn
    target_id          = local.association[count.index].instance.id
    port               = local.association[count.index].portnum
    
}

resource "aws_alb_listener" "alb_listener" {  

  load_balancer_arn = "${aws_alb.alb.arn}"  
  port              = "80"  
  protocol          = "HTTP"
  
  default_action {    
    target_group_arn = "${aws_alb_target_group.alb_target_group.arn}"
    type             = "forward"  
  }
}