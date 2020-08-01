data "aws_ami" "amazon_ami" {
most_recent               = true
owners                    = ["amazon"] 

 filter {
   name                   = "owner-alias"
   values                 = ["amazon"]
 }

 filter {
   name                   = "name"
   values                 = ["amzn2-ami-hvm*"]
 }
 
}

data "aws_availability_zones" "available" {
  state                   = "available"
}

# it should be private subnets in production environment.
data "aws_subnet" "public_subnet" {
  count                   = var.kafka_nodes
  vpc_id                  = var.vpc_id
  filter {
    name                  = "tag:type"
    values                = ["public"]
  }
  availability_zone       = data.aws_availability_zones.available.names[ count.index % length(data.aws_availability_zones.available.names) ]

}