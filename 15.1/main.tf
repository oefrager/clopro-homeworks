resource "yandex_vpc_network" "develop" {
  name = var.vpc_name_public
}

resource "yandex_vpc_subnet" "public" {
  name           = var.vpc_name_public
  zone           = var.default_zone
  network_id     = yandex_vpc_network.develop.id
  v4_cidr_blocks = var.default_cidr_public
}

resource "yandex_vpc_subnet" "private" {
  name           = var.vpc_name_private
  zone           = var.default_zone
  network_id     = yandex_vpc_network.develop.id
  v4_cidr_blocks = var.default_cidr_private
  route_table_id = yandex_vpc_route_table.nat-instance-route.id
}

resource "yandex_vpc_route_table" "nat-instance-route" {
  name       = "private-route"
  network_id = yandex_vpc_network.develop.id
  static_route {
    destination_prefix = "0.0.0.0/0"
    next_hop_address   = "192.168.10.254"
  }
}