resource "aws_security_group" "kafka_sg" {
  name        = "kafka-sg-${var.env}"
  description = "Allow kafka traffic"
  vpc_id      = var.vpc_id

  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    self        = true
    description = "allow traffic within sg"
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = var.allowed_inbound_ssh_cidrs
    description = "allow ssh connections"
  }

  ingress {
    from_port   = 9092
    to_port     = 9092
    protocol    = "tcp"
    cidr_blocks = var.allowed_inbound_client_cidrs
    description = "allow client connections"
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name  = "kafka-sg-${var.env}"
    Env   = var.env
    Owner = "Terraform"
  }
}

resource "aws_security_group" "this" {
  count       = local.create ? 1 : 0
  name        = "zookeeper-sg-${var.env}"
  description = "Allow Zookeeper traffic"
  vpc_id      = var.vpc_id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = var.allowed_inbound_ssh_cidrs
    description = "allow ssh connections"
  }

  ingress {
    from_port   = 2181
    to_port     = 2181
    protocol    = "tcp"
    cidr_blocks = var.allowed_inbound_client_cidrs
    description = "allow client connections"
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge(local.tags, map("Name", "zookeeper-sg-${var.env}"))
}