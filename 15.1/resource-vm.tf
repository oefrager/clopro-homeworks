data "yandex_compute_image" "os" {
  family = var.vm_image
}

resource "yandex_compute_instance" "public" {
  name        = "public"
  hostname    = "public"
  platform_id = var.vms_resources.vm.platform_id
  resources {
    cores         = var.vms_resources.vm.cores
    memory        = var.vms_resources.vm.memory
    core_fraction = var.vms_resources.vm.core_fraction
  }
  
  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.os.image_id
      type     = var.vms_resources.vm.type_hdd
    }
  }
  
  scheduling_policy { preemptible = true }

  network_interface {
    subnet_id          = yandex_vpc_subnet.public.id
    nat                = true
    #security_group_ids = [yandex_vpc_security_group.example.id]
    }

  metadata = local.metadata
}

resource "yandex_compute_instance" "private" {
  count       = 1
  name        = "private"
  hostname    = "private"
  platform_id = var.vms_resources.vm.platform_id
  resources {
    cores         = var.vms_resources.vm.cores
    memory        = var.vms_resources.vm.memory
    core_fraction = var.vms_resources.vm.core_fraction
  }
  
  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.os.image_id
      type     = var.vms_resources.vm.type_hdd
    }
  }
  
  scheduling_policy { preemptible = true }

  network_interface {
    subnet_id          = yandex_vpc_subnet.private.id
    }

  metadata = local.metadata
}