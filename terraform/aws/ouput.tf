output "public_ips" {
  value = try(aws_instance.this[*].public_ip, [])
}

output "private_dns" {
  value = try(aws_instance.this[*].private_dns, [])
}