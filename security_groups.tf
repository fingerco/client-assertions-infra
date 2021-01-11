resource "aws_security_group" "client-assertions-api-lb" {
  name        = "client-assertions-api-lb"
  description = "client-assertions-api LB"
  vpc_id      = data.aws_vpc.main.id

  ingress {
    description = "Incoming HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "Incoming HTTPS"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "client-assertions-api-svc" {
  name        = "client-assertions-api-svc"
  description = "client-assertions-api Service"
  vpc_id      = data.aws_vpc.main.id

  ingress {
    description     = "Incoming HTTP"
    from_port       = 3000
    to_port         = 3000
    protocol        = "tcp"
    security_groups = [aws_security_group.client-assertions-api-lb.id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
