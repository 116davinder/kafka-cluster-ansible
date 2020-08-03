resource "aws_instance" "kafka" {
  count                   = var.kafka_nodes

  ami                     = data.aws_ami.amazon_ami.id
  instance_type           = var.instance_type
  key_name                = var.key_name
  subnet_id               = element(data.aws_subnet.public_subnet.*.id, count.index)
  vpc_security_group_ids  = ["${aws_security_group.kafka_sg.id}"]
  
  root_block_device {
    volume_type           = "gp2"
    volume_size           = var.kafka_root_volume_size
  }

  tags = {
    Name                  = "kafka-${var.env}-${count.index}"
    Env                   = var.env
    Owner                 = "Terraform"
    Software              = "Apache Kafka"
  }

  volume_tags = {
    Owner                 = "Terraform"
  }

  monitoring              = false

  availability_zone       = data.aws_availability_zones.available.names[ count.index % length(data.aws_availability_zones.available.names) ]
  iam_instance_profile    = var.ec2_cloudwatch_role
  depends_on              = [aws_security_group.kafka_sg,aws_iam_instance_profile.Kafka-CloudWatchAgentServerRole-Profile]

}

resource "aws_volume_attachment" "kafka_ebs_attach" {
  count                   = var.kafka_nodes
  device_name             = var.kafka_ebs_attach_location
  volume_id               = element(aws_ebs_volume.kafka.*.id, count.index)
  instance_id             = element(aws_instance.kafka.*.id, count.index)
  force_detach            = true
}