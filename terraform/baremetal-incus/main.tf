resource "incus_project" "this" {
  name        = var.project_name
  description = "Project used to test bug"
  config = {
    "features.images"          = false
    "features.networks"        = false
    "features.networks.zones"  = false
    "features.profiles"        = true
    "features.storage.buckets" = true
    "features.storage.volumes" = true
  }
}

resource "incus_profile" "this" {
  project     = incus_project.this.name
  name        = "cluster"
  description = "Profile to be used by the cluster VMs"

  config = {
    "limits.cpu"          = "4"
    "limits.memory"       = var.memory
    "security.secureboot" = "false"
  }

  device {
    type = "disk"
    name = "root"

    properties = {
      "pool" = var.storage_pool
      "path" = "/"
    }
  }

  device {
    type = "nic"
    name = "eth0"

    properties = {
      "network" = incus_network.this.name
      "name"    = "eth0"
    }
  }
}

resource "incus_instance" "instances" {
  for_each = var.instance_names

  project  = incus_project.this.name
  name     = each.value
  type     = "virtual-machine"
  image    = var.image
  profiles = ["default", incus_profile.this.name]

  device {
    type = "disk"
    name = "disk1"

    properties = {
      "pool"   = var.storage_pool
      "io.bus" = "nvme"
      "source" = incus_storage_volume.disk1[each.key].name
    }
  }

  device {
    type = "disk"
    name = "disk2"

    properties = {
      "pool"   = var.storage_pool
      "io.bus" = "nvme"
      "source" = incus_storage_volume.disk2[each.key].name
    }
  }

  device {
    type = "disk"
    name = "disk3"

    properties = {
      "pool"   = var.storage_pool
      "io.bus" = "nvme"
      "source" = incus_storage_volume.disk3[each.key].name
    }
  }

  device {
    type = "disk"
    name = "disk5"

    properties = {
      "pool"   = var.storage_pool
      "io.bus" = "nvme"
      "source" = incus_storage_volume.disk5[each.key].name
    }
  }

  lifecycle {
    ignore_changes = [running]
  }
}
