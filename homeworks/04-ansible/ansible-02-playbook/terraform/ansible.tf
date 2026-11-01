resource "local_file" "inventory" {
  content = templatefile("${path.module}/prod.yml.tftpl",
    {
      vms   = var.vms
      hosts = yandex_compute_instance.vm
    }
  )

  filename        = "${abspath(path.module)}/../playbook/inventory/prod.yml"
  file_permission = "0644"
}
