output public_ip {
  value                   = aws_instance.kafka[*].public_ip
  sensitive               = false
}
