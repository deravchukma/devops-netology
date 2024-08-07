locals {
  vm_role = {web = "web", db = "db"}
  vm_web_name = "netology-${var.vpc_name}-platform-${local.vm_role["web"]}"
  vm_db_name  = "netology-${var.vpc_name}-platform-${local.vm_role["db"]}"
}
