# Terraform Guide
Use Terraform to create resources for kafka in AWS and Other Cloud Provider and kafka being managed by Ansible.

## How to Use for AWS?
* update `aws/var.tf` file with your requirements and variables.
* update your `~/.aws/credentials` file.
* export `AWS_PROFILE=<your aws profile>`.
* update `terraform/aws/data.tf` to include public/private subnets, default it looks for public subnets.
* Run `terraform init` in `terraform/aws` folder.
* Run `terraform plan` to see resources which will be created.
* Run `terraform apply` to create resources.

## How to Use for OCI ( Oracle Cloud )?
`OCI is not 100% tested version`

Ref: https://www.terraform.io/docs/providers/oci/index.html

* update `oci/var.tf` file with your requirements and variables.
* set your OCI credentials.
* Run `terraform init` in `terraform/oci` folder.
* Run `terraform plan` to see resources which will be created.
* Run `terraform apply` to create resources.

## Terraform Tested Version
```
$ terraform version
Terraform v0.12.29
+ provider.aws v3.0.0

$ terraform version
Terraform v0.12.29
+ provider.oci v3.86.0
```