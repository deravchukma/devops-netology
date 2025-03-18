terraform {
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
      version = "0.135.0"
    }
  }
  required_version = ">=1.8.4"
}

provider "yandex" {  
  cloud_id                 = "b1g7s2ff22026b6543bd"
  folder_id                = "b1gido7jghida49n0l1h"
  service_account_key_file = file("~/.authorized_key.json")
  zone                     = "ru-central1-a" #(Optional) 
}
