### CLOUD vars
variable "cloud_id" {
  type        = string
  description = "https://cloud.yandex.ru/docs/resource-manager/operations/cloud/get-id"
}

variable "folder_id" {
  type        = string
  description = "https://cloud.yandex.ru/docs/resource-manager/operations/folder/get-id"
}

variable "vpc_name_develop" {
  type        = string
  default     = "develop"
  description = "VPC network name"
}

variable "default_zone" {
  type        = string
  default     = "ru-central1-a"
  description = "https://cloud.yandex.ru/docs/overview/concepts/geo-scope"
}

variable "public_subnets" {
  description = "VPC public subnet config"
  type = map(object({
    name        = string
    zone        = string
    cidr_blocks = list(string)
  }))
  default = {
    "public-a" = {
      name        = "public-a"
      zone        = "ru-central1-a"
      cidr_blocks = ["192.168.10.0/24"]
    },
    "public-b" = {
      name        = "public-b"
      zone        = "ru-central1-b"
      cidr_blocks = ["192.168.11.0/24"]
    },
    "public-d" = {
      name        = "public-d"
      zone        = "ru-central1-d"
      cidr_blocks = ["192.168.12.0/24"]
    }
  }
}

variable "private_subnets" {
  description = "VPC private subnet config"
  type = map(object({
    name        = string
    zone        = string
    cidr_blocks = list(string)
  }))
  default = {
    "private-a" = {
      name        = "private-a"
      zone        = "ru-central1-a"
      cidr_blocks = ["192.168.20.0/24"]
    },
    "private-b" = {
      name        = "private-b"
      zone        = "ru-central1-b"
      cidr_blocks = ["192.168.21.0/24"]
    }
  }
}

### HOST vars
variable "vms_resources" {
  description = "Configuration K8s node"
  type = map(object({
    version       = string
    platform_id   = string
    cores         = number
    core_fraction = number
    memory        = number
    disk_type     = string
    disk_size     = number
    preemptible   = bool
    runtime_type  = string
  }))
  default = {
    db       = {
      version       = "8.0"
      platform_id   = "b1.medium"
      cores         = 2
      core_fraction = 50
      memory        = 4
      disk_type     = "network-hdd"
      disk_size     = 20
      preemptible   = true
      runtime_type  = ""
    }  
    node-k8s = {
      version       = "1.29"
      platform_id   = "standard-v3"
      cores         = 2
      core_fraction = 50
      memory        = 2
      disk_type     = "network-hdd"
      disk_size     = 64
      preemptible   = true
      runtime_type  = "containerd"
    }
  }
}