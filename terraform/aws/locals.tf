locals {
  tags         = merge(var.tags, map("env", var.env))
  subnet_count = length(var.az_subnet_mapping)
  create       = var.kafka_nodes > 0 && local.subnet_count > 0 ? true : false
}
