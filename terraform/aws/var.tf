variable "region" {
  type        = string
  default     = "us-east-1"
  description = "AWS Region"
}

variable "env" {
  type        = string
  default     = "development"
  description = "environment name"
}

variable "vpc_id" {
  type    = string
  default = "vpc-0646ae67a3f8ac6d7"
}

variable "az_subnet_mapping" {
  type = list(map(string))
  default = [
    { "us-east-1a" = "subnet-08eb68191564b2f17" },
    { "us-east-1b" = "subnet-06575de9cbffc4085" },
    { "us-east-1c" = "subnet-01ed603570aa2ee80" },
  ]
  description = "list of map of private / public subnets with respective az"
}

variable "allowed_inbound_ssh_cidrs" {
  type        = list(string)
  default     = ["0.0.0.0/0"]
  description = "list of cidrs to allow inbound ssh access from"
}

variable "allowed_inbound_client_cidrs" {
  type        = list(string)
  default     = ["0.0.0.0/0"]
  description = "list of cidrs to allow inbound client port (9092)"
}

variable "instance_type" {
  type        = string
  default     = "t3a.xlarge"
  description = "Instance Type"
}

variable "key_name" {
  type        = string
  default     = "davinder-terraform"
  description = "aws ec2 ssh key pair name"
}

variable "kafka_nodes" {
  type        = number
  default     = 2
  description = "how many nodes of kafka cluster is required?"
}

variable "kafka_volume_size" {
  type        = number
  default     = 30
  description = "how much size of kafka data volume is required?"
}

variable "kafka_root_volume_size" {
  type        = number
  default     = 10
  description = "how much size of kafka root volume is required?"
}

variable "kafka_ebs_attach_location" {
  type        = string
  default     = "/dev/sdc"
  description = "disk location in linux machine"
}

variable "associate_public_ip_address" {
  type        = bool
  default     = true
  description = "do you want to assign public ip to kafka instances?"
}

variable "tags" {
  type        = map(string)
  description = "Tags to be Added to All Resources, except Env & Name Tag"
  default = {
    "owner"    = "Terraform"
    "software" = "Apache Kafka"
  }
}
