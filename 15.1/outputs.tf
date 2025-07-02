output "nat-instance" {
  value = {
    name        = yandex_compute_instance.nat-instance.name
    ip_external = yandex_compute_instance.nat-instance.network_interface[0].nat_ip_address
    ip_internal = yandex_compute_instance.nat-instance.network_interface[0].ip_address
  }
}

output "VM-public" {
  value = {
    name        = yandex_compute_instance.public.name
    ip_external = yandex_compute_instance.public.network_interface[0].nat_ip_address
    ip_internal = yandex_compute_instance.public.network_interface[0].ip_address
  }
}

output "VM-private" {
  value = {
    name        = yandex_compute_instance.private.name
    ip_external = yandex_compute_instance.private.network_interface[0].nat_ip_address
    ip_internal = yandex_compute_instance.private.network_interface[0].ip_address
  }
}