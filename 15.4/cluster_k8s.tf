# k8s cluster.
resource "yandex_kubernetes_cluster" "cluster_k8s" {
  name       = "cluster-k8s"
  network_id = yandex_vpc_network.develop.id
  master {
    master_location {
      zone      = var.public_subnets.public-a.zone
      subnet_id = yandex_vpc_subnet.public-a.id
    }
    master_location {
      zone      = var.public_subnets.public-b.zone
      subnet_id = yandex_vpc_subnet.public-b.id
    }
    master_location {
      zone      = var.public_subnets.public-d.zone
      subnet_id = yandex_vpc_subnet.public-d.id
    }
    version   = "1.29"
    public_ip = true
  }

  
  service_account_id      = yandex_iam_service_account.sa-k8s.id
  node_service_account_id = yandex_iam_service_account.sa-k8s.id
  depends_on = [
    yandex_resourcemanager_folder_iam_member.k8s-clusters-agent,
    yandex_resourcemanager_folder_iam_member.vpc-public-admin,
    yandex_resourcemanager_folder_iam_member.images-puller
  ]
  kms_provider {
    key_id = yandex_kms_symmetric_key.kms-key.id
  }
}

# Сервисный аккаунт для k8s cluster.
resource "yandex_iam_service_account" "sa-k8s" {
  name        = "sa-k8s"
  description = "Service account for Kubernetes cluster"
}

# Сервисному аккаунту назначаются роли.
resource "yandex_resourcemanager_folder_iam_member" "k8s-clusters-agent" {
  folder_id = var.folder_id
  role      = "k8s.clusters.agent"
  member    = "serviceAccount:${yandex_iam_service_account.sa-k8s.id}"
}

resource "yandex_resourcemanager_folder_iam_member" "vpc-public-admin" {
  folder_id = var.folder_id
  role      = "vpc.publicAdmin"
  member    = "serviceAccount:${yandex_iam_service_account.sa-k8s.id}"
}

resource "yandex_resourcemanager_folder_iam_member" "images-puller" {
  folder_id = var.folder_id
  role      = "container-registry.images.puller"
  member    = "serviceAccount:${yandex_iam_service_account.sa-k8s.id}"
}

# Ключ Yandex Key Management Service для шифрования.
resource "yandex_kms_symmetric_key" "kms-key" {
  name              = "kms-key"
  default_algorithm = "AES_128"
  rotation_period   = "8760h" # 1 год.
}

#Группа узлов k6s
resource "yandex_kubernetes_node_group" "node_k8s" {
  name        = "node-k8s"
  cluster_id  = yandex_kubernetes_cluster.cluster_k8s.id
  version     = var.vms_resources.node-k8s.version
  instance_template {
    name = "k8s-{instance.short_id}"
    platform_id = var.vms_resources.node-k8s.platform_id
    resources {
      cores         = var.vms_resources.node-k8s.cores
      core_fraction = var.vms_resources.node-k8s.core_fraction
      memory        = var.vms_resources.node-k8s.memory
    }
    
    boot_disk {
      type = var.vms_resources.node-k8s.disk_type
      size = var.vms_resources.node-k8s.disk_size
    }

#    network_acceleration_type = "standard"
    network_interface {
      subnet_ids         = ["${yandex_vpc_subnet.public-a.id}"]
      nat                = true
    }
    
    scheduling_policy { preemptible = var.vms_resources.node-k8s.preemptible }
  
    container_runtime { type = var.vms_resources.node-k8s.runtime_type }

    metadata = local.metadata
  }

  scale_policy {
    auto_scale {
      min     = 3
      max     = 6
      initial = 3
    }
    }

  allocation_policy {
    location {
      zone = var.public_subnets.public-a.zone
    }
  }

  node_labels = {
    "name" = "k8s-nodes-mysql"
  }
  labels = {
    "cluster" = "k8s-cluste"
  }
}