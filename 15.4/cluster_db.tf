resource "yandex_mdb_mysql_cluster" "cluster_db" {
  name                = "cluster-db"
  environment         = "PRESTABLE"
  network_id          = yandex_vpc_network.develop.id
  version             = var.vms_resources.db.version
  deletion_protection = false #true
  maintenance_window {
    type = "ANYTIME"

  }
  backup_window_start {
    hours   = "23"
    minutes = "59"
  }

  resources {
    resource_preset_id = var.vms_resources.db.platform_id
    disk_type_id       = var.vms_resources.db.disk_type
    disk_size          = var.vms_resources.db.disk_size
  }

  host {
    name            = "hostdb-1"
    zone             = var.private_subnets.private-a.zone
    subnet_id        = yandex_vpc_subnet.private-a.id
    assign_public_ip = false
  }
  
  host {
    name            = "hostdb-2"
    zone             = var.private_subnets.private-b.zone
    subnet_id        = yandex_vpc_subnet.private-b.id
    assign_public_ip = false
  }
}

# DataBase
resource "yandex_mdb_mysql_database" "netology_db" {
  cluster_id = yandex_mdb_mysql_cluster.cluster_db.id
  name       = "netology_db"
}

resource "yandex_mdb_mysql_user" "user_bd" {
  cluster_id = yandex_mdb_mysql_cluster.cluster_db.id
  name       = local.user
  password   = local.password
  permission {
    database_name = yandex_mdb_mysql_database.netology_db.id #"netology_db"
    roles         = [ "ALL" ]
  }
}