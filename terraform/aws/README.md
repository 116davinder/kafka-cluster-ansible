## Requirements

| Name | Version |
|------|---------|
| terraform | >= 0.12 |
| aws | >= 3, <= 4 |

## Providers

| Name | Version |
|------|---------|
| aws | >= 3, <= 4 |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| allowed\_inbound\_client\_cidrs | list of cidrs to allow inbound client port (9092) | `list(string)` | <pre>[<br>  "0.0.0.0/0"<br>]</pre> | no |
| allowed\_inbound\_ssh\_cidrs | list of cidrs to allow inbound ssh access from | `list(string)` | <pre>[<br>  "0.0.0.0/0"<br>]</pre> | no |
| associate\_public\_ip\_address | do you want to assign public ip to kafka instances? | `bool` | `true` | no |
| az\_subnet\_mapping | list of map of private / public subnets with respective az | `list(map(string))` | <pre>[<br>  {<br>    "us-east-1a": "subnet-08eb68191564b2f17"<br>  },<br>  {<br>    "us-east-1b": "subnet-06575de9cbffc4085"<br>  },<br>  {<br>    "us-east-1c": "subnet-01ed603570aa2ee80"<br>  }<br>]</pre> | no |
| env | environment name | `string` | `"development"` | no |
| instance\_type | Instance Type | `string` | `"t2.micro"` | no |
| kafka\_ebs\_attach\_location | disk location in linux machine | `string` | `"/dev/sdc"` | no |
| kafka\_nodes | how many nodes of kafka cluster is required? | `number` | `1` | no |
| kafka\_root\_volume\_size | how much size of kafka root volume is required? | `number` | `10` | no |
| kafka\_volume\_size | how much size of kafka data volume is required? | `number` | `30` | no |
| key\_name | aws ec2 ssh key pair name | `string` | `"davinder-terraform"` | no |
| region | AWS Region | `string` | `"us-east-1"` | no |
| tags | Tags to be Added to All Resources, except Env & Name Tag | `map(string)` | <pre>{<br>  "owner": "Terraform",<br>  "software": "Apache Zookeeper"<br>}</pre> | no |
| vpc\_id | n/a | `string` | `"vpc-0646ae67a3f8ac6d7"` | no |

## Outputs

| Name | Description |
|------|-------------|
| private\_dns | n/a |
| public\_ips | n/a |

