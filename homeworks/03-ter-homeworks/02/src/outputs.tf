output "vm_info_output" {

  value = [
    { vm_web = ["instance_name:  ${yandex_compute_instance.platform.name}", "external_ip: ${yandex_compute_instance.platform.network_interface[0].nat_ip_address}", "fqdn: ${yandex_compute_instance.platform.fqdn}"] },
    { vm_db = ["instance_name: ${yandex_compute_instance.DB.name}", "external_ip: ${yandex_compute_instance.DB.network_interface[0].nat_ip_address}", "fqdn: ${yandex_compute_instance.DB.fqdn}"] }
  ]
}