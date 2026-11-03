output "vms" {
  description = "Адреса ВМ стенда"
  value = {
    for name, vm in yandex_compute_instance.vm : name => {
      external_ip = vm.network_interface[0].nat_ip_address
      internal_ip = vm.network_interface[0].ip_address
    }
  }
}
