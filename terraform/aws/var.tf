variable region {
  type                    = string
  default                 = "eu-central-1"
  description             = "AWS Region"
}

variable env {
  type                    = string
  default                 = "development"
  description             = "environment name"
}

variable vpc_id {
  type                    = string
  default                 = "vpc-0935362fca368f01f"
}

variable subnet_id {
  type                    = string
  default                 = "subnet-00f117908461e14c4"
}

variable instance_type {
  type                    = string
  default                 = "t2.micro"
  description             = "Instance Type"
}

variable key_name {
  type                    = string
  default                 = "davinder-test-terraform"
  description             = "aws ec2 ssh key pair name"
}

variable kafka_nodes {
  type                    = number
  default                 = 1
  description             = "how many nodes of kafka cluster is required?"
}

variable kafka_volume_size {
  type                    = number
  default                 = 30
  description             = "how much size of kafka data volume is required?"
}

variable kafka_root_volume_size {
  type                    = number
  default                 = 10
  description             = "how much size of kafka root volume is required?"
}

variable kafka_ebs_attach_location {
  type                    = string
  default                 = "/dev/sdc"
  description             = "disk location in linux machine"
}

variable ec2_cloudwatch_role {
  type                    = string
  default                 = "Kafka-CloudWatchAgentServerRole"
  description             = "aws ec2 cloudwatch role"
}