variable "vms" {
  description = "ВМ стенда; group - группа хоста в inventory ansible"
  type = list(object({
    vm_name       = string
    group         = string
    cpu           = number
    ram           = number
    core_fraction = number
    disk_volume   = number
  }))
  default = [
    {
      vm_name       = "clickhouse-01"
      group         = "clickhouse"
      cpu           = 2
      ram           = 4
      core_fraction = 20
      disk_volume   = 15
    },
    {
      vm_name       = "vector-01"
      group         = "vector"
      cpu           = 2
      ram           = 2
      core_fraction = 20
      disk_volume   = 15
    },
  ]
}

resource "yandex_compute_instance" "vm" {
  for_each = { for vm in var.vms : vm.vm_name => vm }

  name        = each.value.vm_name
  hostname    = each.value.vm_name
  platform_id = "standard-v3"

  resources {
    cores         = each.value.cpu
    memory        = each.value.ram
    core_fraction = each.value.core_fraction
  }

  scheduling_policy {
    preemptible = true
  }

  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.os.image_id
      type     = "network-hdd"
      size     = each.value.disk_volume
    }
  }

  network_interface {
    subnet_id          = yandex_vpc_subnet.develop.id
    nat                = true
    security_group_ids = [yandex_vpc_security_group.example.id]
  }

  metadata = {
    ssh-keys = "ubuntu:${local.public_key}"
  }
}
