variable "t_ocid" {
  description = "Root Tenant ID"
  default = "ocid1.tenancy.xxxxxxxxxxxxxxxxxxxxxxxxxxxxxbdmaxhlduzwtxryat3zbha"
}

variable "u_ocid" {
  description = "User ID from compute console"
  default = "ocid1.user.xxxxxxxxxxxxxxxxxxxxxxv5shhccn7uglfoxpsa"
}

variable "compartment_ocid" {
  description = "Compartment ID"
  default = "ocid1.compartment.xxxxxxxxxxxxxxxxxxxxxxxxxxxxzba2f34w6vnw3yxaackla"
}

variable "u_fingerprint" {
  description = "User ID fingerprint from compute console"
  default = "f7:16:fd:xxxxxxxxxxxxxxxxxxxxx:ab:d4:ee:9a"
}

variable "u_private_key_pem" {
  description = "User Private PEM from Compute"
  default = "/home/davinderpal/.oci/oci_api_key.pem"
}

variable "u_region" {
  description = "User Region from Compute"
  default = "eu-frankfurt-1"
}

variable "instance_image_ocid" {
  description = "Oracle-Linux-7.6-2019.06.15-0"
  default = "ocid1.image.oc1.eu-frankfurt-1.aaaaaaaazfzlw2infpo3svzjgrcl237xsbod4l5yuzfpqdqmmawia2womz5q"
}

variable "vcn_ocid" {
  description = "Virtual Cloud Networt ID"
  default = "ocid1.vcn.oc1.eu-frankfurt-1.xxxxxxxxxxxxxxxxxxxxxxo734ycb3pn75cua"
}

variable "subnet_ocid" {
  description = "Subnet ID 1"
  default = "ocid1.subnet.oc1.eu-frankfurt-1.xxxxxxxxxxxxxxxxxxxxxxwpzaejapzt3vzuc2q"
}

variable "instance_shape" {
  description = "CPU:2,	RAM: 30GB, Block Storage only, Network:	2 Gbps,	NIC: 2"
  default = "VM.Standard2.2"
}

variable "instance_availability_domain" {
  description = "Region in which resource will be created or destoryed"
  default = "ExfZ:EU-FRANKFURT-1-AD-1"
}

variable "secuirty" {
  default = "ocid1.securitylist.oc1.eu-frankfurt-1.xxxxxxxxxxxxxxxxxxxx25ecj2sa6xe533giwiva"
}

variable "ssh_public_key" {
  default = "ssh-rsa xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx rsa-key2047@Davinder_Pal"
}

variable "kafka_instance_count" {
  default = 3
}

variable "kafka_block_volume_size_gb" {
  default = 100
}

variable "use_pblic_ip" {
  type = bool
  default = true
}
