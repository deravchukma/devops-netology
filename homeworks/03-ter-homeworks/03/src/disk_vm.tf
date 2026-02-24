resource "yandex_compute_disk" "storage_disks" {
  count = 3
  name  = "storage-disk-${count.index}"
  size  = 1
  type  = "network-hdd"
  zone  = var.default_zone
}

resource "yandex_compute_instance" "storage" {
  name     = "storage"
  hostname = "storage"
  platform_id = "standard-v1"

  resources {
    cores  = 2
    memory = 2
  }

  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu-2404-lts.image_id
	  type     = "network-hdd"
      size     = 10
    }
  }

  dynamic "secondary_disk" {
    for_each = yandex_compute_disk.storage_disks
    content {
      disk_id = secondary_disk.value.id
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