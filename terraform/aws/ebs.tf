resource "aws_ebs_volume" "kafka" {
  count                   = var.kafka_nodes
  availability_zone       = data.aws_availability_zones.available.names[ count.index % length(data.aws_availability_zones.available.names) ]
  size                    = var.kafka_volume_size

  tags = {
    Name                  = "kafka-data-vol-${var.env}-${count.index}"
    Env                   = var.env
    Owner                 = "Terraform"
  }

}