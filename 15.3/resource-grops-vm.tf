resource "yandex_iam_service_account" "ig-sa" {
  name        = "instance-group-sa"
  description = "Service account for the instance group"
}

resource "yandex_resourcemanager_folder_iam_member" "compute_editor" {
  folder_id   = var.folder_id
  role        = "editor"
  member      = "serviceAccount:${yandex_iam_service_account.ig-sa.id}"
  depends_on  = [ yandex_iam_service_account.ig-sa, ]
}

resource "yandex_compute_instance_group" "group-vm" {
  name                = "ig"
  folder_id           = var.folder_id
  service_account_id  = "${yandex_iam_service_account.ig-sa.id}"
  deletion_protection = false
  instance_template {
    platform_id = var.vms_resources.vm.platform_id
    resources {
      cores         = var.vms_resources.vm.cores
      memory        = var.vms_resources.vm.memory
      core_fraction = var.vms_resources.vm.core_fraction
    }

    boot_disk {
      mode = "READ_WRITE"
      initialize_params {
        image_id = var.vm_image_lamp
        type     = var.vms_resources.vm.type_hdd
      }
    }

    scheduling_policy { preemptible = true }

    network_interface {
      network_id = yandex_vpc_network.develop.id
      subnet_ids = ["${yandex_vpc_subnet.public.id}"]
      nat                = true
    }

    metadata = {
      ssh-keys = "ubuntu:${local.ssh-keys}"
      user-data  = <<EOF
        #!/bin/bash
        cd /var/www/html
        echo '<html><head><title>It's my picture</title></head> <body><h1></h1><img src="http://${yandex_storage_bucket.iam-bucket.bucket_domain_name}/DYGA.jpg"/></body></html>' > index.html
        EOF
    }
  }

  scale_policy {
    fixed_scale { size = 3 }
  }

  allocation_policy {
    zones = [var.default_zone]
  }

  deploy_policy {
    max_unavailable = 1
    max_expansion   = 0
  }
  
  load_balancer {
    target_group_name        = "target-group"
    target_group_description = "Network Load Balancer"
  }

  health_check {
    interval = 10
    timeout  = 5
    tcp_options {
      port = 80
    }
  }
}