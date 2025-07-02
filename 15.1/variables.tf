### CLOUD vars

variable "cloud_id" {
  type        = string
  description = "https://cloud.yandex.ru/docs/resource-manager/operations/cloud/get-id"
}

variable "folder_id" {
  type        = string
  description = "https://cloud.yandex.ru/docs/resource-manager/operations/folder/get-id"
}

variable "default_zone" {
  type        = string
  default     = "ru-central1-a"
  description = "https://cloud.yandex.ru/docs/overview/concepts/geo-scope"
}

variable "default_cidr_public" {
  type        = list(string)
  default     = ["192.168.10.0/24"]
  description = "https://cloud.yandex.ru/docs/vpc/operations/subnet-create"
}

variable "default_cidr_private" {
  type        = list(string)
  default     = ["192.168.20.0/24"]
  description = "https://cloud.yandex.ru/docs/vpc/operations/subnet-create"
}

variable "vpc_name_public" {
  type        = string
  default     = "public"
  description = "VPC network&subnet name"
}

variable "vpc_name_private" {
  type        = string
  default     = "private"
  description = "VPC network&subnet name"
}


### HOST vars

variable  "nat_image" {
  type        = string
  default     = "fd80mrhj8fl2oe87o4e1"
  description = "NAT-instans image"
}

variable  "vm_image" {
  type        = string
  default     = "ubuntu-2404-lts-oslogin"
  description = "VM image OS"
}

variable "vms_resources" {
  type = map(object({
    platform_id    = string
    type_hdd       = string
    cores          = number
    memory         = number
    core_fraction  = number
  }))
  default = {
    vm= {
      platform_id    = "standard-v3"
      type_hdd       = "network-hdd"
      cores          = 2
      memory         = 4
      core_fraction  = 20
    },
  }
}