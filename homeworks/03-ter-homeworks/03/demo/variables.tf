###cloud vars

variable "public_key" {
  type    = string  
  default = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIOAwDcuxsyI3SHYgEFsA1cjwKlYkNOEDq8fhcmUUro6Z dma@ubuntu"
}

variable "yc_token" {
  type        = string
  description = "OAuth-token; https://cloud.yandex.ru/docs/iam/concepts/authorization/oauth-token"
}

variable "cloud_id" {
  type        = string
  description = "https://cloud.yandex.ru/docs/resource-manager/operations/cloud/get-id"
}

variable "folder_id" {
  type        = string
  description = "https://cloud.yandex.ru/docs/resource-manager/operations/folder/get-id"
}
