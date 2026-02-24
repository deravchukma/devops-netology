resource "yandex_compute_instance" "web" {
  count = 2
  name     = "web-${count.index + 1}"
  hostname = "web-${count.index + 1}"
  platform_id = "standard-v1"

  resources {
    cores  = 2
    memory = 1
	core_fraction = 20
  }

  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu-2404-lts.image_id
	  type     = "network-hdd"
      size     = 15
    }
  }

  network_interface {
    subnet_id          = yandex_vpc_subnet.develop.id
    nat                = true
    security_group_ids = [yandex_vpc_security_group.example.id]
  }
}