variable "db_each_vm" {
  type = list(object({
    vm_name     = string
    cpu         = number
    ram         = number
    disk_volume = number
    platform_id = string
  }))
  default = [
    {
      vm_name     = "main"
      cpu         = 4
      ram         = 8
      disk_volume = 50
      platform_id = "standard-v1"
    },
    {
      vm_name     = "replica"
      cpu         = 2
      ram         = 4
      disk_volume = 25
      platform_id = "standard-v1"
    }
  ]
}

resource "yandex_compute_instance" "db_vm" {
  for_each    = { for vm in var.db_each_vm : vm.vm_name => vm }
  
  name        = each.value.vm_name
  platform_id = each.value.platform_id  

  resources {
    cores  = each.value.cpu
    memory = each.value.ram
  }

  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu-2404-lts.image_id
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