module "baremetal" {
  source = "./baremetal-incus"

  project_name   = "dev-incus-deploy"
  instance_names = var.incus_instance_names
  image          = "images:${var.incus_image}"
  memory         = "4GiB"

  storage_pool = var.incus_storage_pool
  network      = var.incus_network

  ovn_uplink_ipv4_address = var.ovn_uplink_ipv4_address
  ovn_uplink_ipv6_address = var.ovn_uplink_ipv6_address
}
