provider "oci" {
  tenancy_ocid = var.t_ocid
  user_ocid = var.u_ocid
  fingerprint = var.u_fingerprint
  private_key_path = var.u_private_key_pem
  region = var.u_region
}