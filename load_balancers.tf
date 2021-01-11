resource "aws_lb" "client-assertions-api" {
  name               = "client-assertions-api"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.client-assertions-api-lb.id]
  subnets            = [aws_subnet.public-west-2a.id, aws_subnet.public-west-2b.id]

  enable_deletion_protection = true
  depends_on         = [aws_internet_gateway.main]
}

resource "aws_lb_target_group" "client-assertions-api" {
  name        = "client-assertions-api"
  port        = "80"
  protocol    = "HTTP"
  vpc_id      = data.aws_vpc.main.id
  target_type = "ip"

  health_check {
    path     = "/health_check"
    protocol = "HTTP"
    interval = 60
  }
}

resource "aws_lb_listener" "client-assertions-api" {
  load_balancer_arn = aws_lb.client-assertions-api.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.client-assertions-api.arn
  }
}
