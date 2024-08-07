###vm_web vars

/*variable "vm_web_name" {
  type        = string
  default     = "netology-develop-platform-web"
  description = "VM WEB name"
}*/

variable "vm_web_platform_id" {
  type        = string
  default     = "standard-v1"
  description = "VM WEB platform id"
}

/*variable "vm_web_cores" {
  type        = number
  default     = 2
  description = "VM WEB resources cores"
}

variable "vm_web_memory" {
  type        = number
  default     = 1
  description = "VM WEB resources memory"
}

variable "vm_web_core_fraction" {
  type        = number
  default     = 5
  description = "VM WEB resources core fraction"
}*/

variable "vm_web_preemptible" {
  type        = bool
  default     = true
  description = "VM WEB scheduling policy preemptible"
}

variable "vm_web_nat" {
  type        = bool
  default     = true
  description = "VM WEB network interface nat"
}

/*variable "vm_web_serial_port_enable" {
  type        = number
  default     = 1
  description = "VM WEB metadata serial-port-enable"
}*/

###vm_db vars

/*variable "vm_db_name" {
  type        = string
  default     = "netology-develop-platform-db"
  description = "VM DB name"
}*/

variable "vm_db_platform_id" {
  type        = string
  default     = "standard-v1"
  description = "VM DB platform id"
}

variable "vm_db_zone" {
  type        = string
  default     = "ru-central1-b"
  description = "VM DB zone"
}

variable "vm_db_subnet_name" {
  type        = string
  default     = "develop_db"
  description = "VM DB subnet name"
}

variable "vm_db_cidr" {
  type        = list(string)
  default     = ["10.0.2.0/24"]
  description = "https://cloud.yandex.ru/docs/vpc/operations/subnet-create"
}

/*variable "vm_db_cores" {
  type        = number
  default     = 2
  description = "VM DB resources cores"
}

variable "vm_db_memory" {
  type        = number
  default     = 2
  description = "VM DB resources memory"
}

variable "vm_db_core_fraction" {
  type        = number
  default     = 20
  description = "VM DB resources core fraction"
}*/

variable "vm_db_preemptible" {
  type        = bool
  default     = true
  description = "VM DB scheduling policy preemptible"
}

variable "vm_db_nat" {
  type        = bool
  default     = true
  description = "VM DB network interface nat"
}

/*variable "vm_db_serial_port_enable" {
  type        = number
  default     = 1
  description = "VM DB metadata serial-port-enable"
}*/

variable "vms_resources" {
  type        = map
  default = {
    web = {
      cores          = 2
      memory         = 1
      core_fraction  = 5
    }
    db = {
      cores          = 2
      memory         = 2
      core_fraction  = 20
    }
  }
  description = "VM resources"
}

variable "vm_metadata" {
  type = map
  default = {
    serial-port-enable = 1
    ssh-keys           = "ubuntu:ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIOAwDcuxsyI3SHYgEFsA1cjwKlYkNOEDq8fhcmUUro6Z dma@ubuntu"
  }
}