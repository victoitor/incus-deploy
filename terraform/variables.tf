variable "incus_remote" {
  type    = string
  default = "local"
}

variable "incus_instance_names" {
  type    = list(string)
  default = ["server01", "server02", "server03"]
}

variable "incus_image" {
  type    = string
  default = "ubuntu/22.04"
}

variable "incus_storage_pool" {
  type    = string
  default = "default"
}

variable "incus_network" {
  type    = string
  default = "incusbr0"
}
