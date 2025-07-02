# Домашнее задание к занятию «Организация сети»

### Задание 1. Yandex Cloud 

1. Создать пустую VPC. Выбрать зону. [VPC NET](main.tf)
2. Публичная подсеть.
 - Создать в VPC subnet с названием public, сетью 192.168.10.0/24.
 - Создать в этой подсети [NAT-инстанс](nat-instance.tf), присвоив ему адрес 192.168.10.254. В качестве image_id использовать fd80mrhj8fl2oe87o4e1.
 - Создать в этой публичной подсети виртуальную машину [public](resource-vm.tf) с публичным IP, подключиться к ней и убедиться, что есть доступ к интернету.

![изображение](https://github.com/user-attachments/assets/229a360c-bd46-4097-91bb-259b9dfb67e9)

3. Приватная подсеть.
 - Создать в VPC subnet с названием private, сетью 192.168.20.0/24.
 - Создать route table. Добавить статический маршрут, направляющий весь исходящий трафик private сети в NAT-инстанс.
   ```
   resource "yandex_vpc_route_table" "nat-instance-route" {
    name       = "private-route"
    network_id = yandex_vpc_network.develop.id
    static_route {
     destination_prefix = "0.0.0.0/0"
     next_hop_address   = "192.168.10.254"
    }}
   ```
 - Создать в этой приватной подсети виртуальную машину [private](resource-vm.tf) с внутренним IP, подключиться к ней через public, созданную ранее,
   ```
   используем команду: ssh -J ubuntu@158.160.46.7 ubuntu@192.168.20.6
   ```
    и убедиться, что есть доступ к интернету.

![изображение](https://github.com/user-attachments/assets/24348e3d-35fa-401b-adaa-72df8bfd47c3)

Получаем следующие виртуальные машины:

![изображение](https://github.com/user-attachments/assets/7fab0cec-bb6f-4ecf-a6d3-c8cefe272bdd)

![изображение](https://github.com/user-attachments/assets/fd138b53-a6b1-468b-9dba-0f40b60262a7)
