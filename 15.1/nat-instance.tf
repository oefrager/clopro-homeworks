data "yandex_compute_image" "nat-os" {
  image_id = var.nat_image
}

resource "yandex_compute_instance" "nat-instance" {
  name        = "nat-instance"
  hostname    = "nat-instance"
  platform_id = var.vms_resources.vm.platform_id
  resources {
    cores         = var.vms_resources.vm.cores
    memory        = var.vms_resources.vm.memory
    core_fraction = var.vms_resources.vm.core_fraction
  }
  
  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.nat-os.image_id
      type     = var.vms_resources.vm.type_hdd
    }
  }
 
  scheduling_policy { preemptible = true }

  network_interface {
    subnet_id          = yandex_vpc_subnet.public.id
    ip_address         = "192.168.10.254"
  }

  metadata = local.metadata
}
