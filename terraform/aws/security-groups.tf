resource "aws_security_group" "kafka_sg" {
  name                    = "kafka-sg-${var.env}"
  description             = "Allow kafka traffic"
  vpc_id                  = var.vpc_id

  ingress {
    from_port             = 22
    to_port               = 22
    protocol              = "tcp"
    cidr_blocks           = ["0.0.0.0/0"]
  }

  ingress {
    from_port             = 0
    to_port               = 0
    protocol              = "-1"
    self                  = true
  }

  ingress {
    from_port             = 9092
    to_port               = 9092
    protocol              = "tcp"
    cidr_blocks           = ["0.0.0.0/0"]
  }

  egress {
    from_port             = 0
    to_port               = 0
    protocol              = "-1"
    cidr_blocks           = ["0.0.0.0/0"]
  }

  tags                    = {
    Name                  = "kafka-sg-${var.env}"
    Env                   = var.env
    Owner                 = "Terraform"
  }
}