resource "oci_core_volume" "kafka-volume" {
    count = var.kafka_instance_count
    availability_domain = var.instance_availability_domain
    compartment_id = var.compartment_ocid
    display_name = "kafka-volume-${count.index + 1}"
    size_in_gbs = var.kafka_block_volume_size_gb
}

resource "oci_core_volume_attachment" "kafka_volume_attachment" {
    count = var.kafka_instance_count
    attachment_type = "iscsi"
    instance_id = element(oci_core_instance.kafka.*.id, count.index)
    volume_id = element(oci_core_volume.kafka-volume.*.id, count.index)

    display_name = "kafka-volume-attachment-${count.index + 1}"
    is_pv_encryption_in_transit_enabled = false
    is_read_only = false
    use_chap = false
}

output "kafka-volume-attachment-details" {
  value = oci_core_volume_attachment.kafka_volume_attachment[*].id
}
