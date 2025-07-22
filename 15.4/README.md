# Домашнее задание к занятию «Кластеры. Ресурсы под управлением облачных провайдеров»

---

## Задание 1. Yandex Cloud

1. Настроить с помощью Terraform кластер баз данных [MySQL](cluster_db.tf).

 - Используя настройки VPC из предыдущих домашних заданий, добавить дополнительно подсеть private в разных зонах, чтобы обеспечить отказоустойчивость. 
 
 - Разместить ноды кластера MySQL в разных подсетях.
 - Необходимо предусмотреть репликацию с произвольным временем технического обслуживания.

<img width="969" height="184" alt="изображение" src="https://github.com/user-attachments/assets/dc3e0140-7564-43eb-80d6-4e7f3e4b9522" />

 - Использовать окружение Prestable, платформу Intel Broadwell с производительностью 50% CPU и размером диска 20 Гб.
 - Задать время начала резервного копирования — 23:59.
 - Включить защиту кластера от непреднамеренного удаления.
 - Создать БД с именем `netology_db`, логином и паролем.

<img width="627" height="818" alt="изображение" src="https://github.com/user-attachments/assets/1a046d74-2fbe-4c6c-9bc1-c1fcadc88e42" />

2. Настроить с помощью Terraform кластер [Kubernetes](cluster_k8s.tf).

 - Используя настройки VPC из предыдущих домашних заданий, добавить дополнительно две подсети public в разных зонах, чтобы обеспечить отказоустойчивость.
 - Создать отдельный сервис-аккаунт с необходимыми правами. 
 - Создать региональный мастер Kubernetes с размещением нод в трёх разных подсетях.

 <img width="1047" height="85" alt="изображение" src="https://github.com/user-attachments/assets/fee647da-410f-4eb3-8a29-ff3daecaaefc" />

 - Добавить возможность шифрования ключом из KMS, созданным в предыдущем домашнем задании.
 - Создать группу узлов, состояющую из трёх машин с автомасштабированием до шести.
 
 <img width="992" height="231" alt="изображение" src="https://github.com/user-attachments/assets/c2f8cfbd-e121-47b7-91b0-a6dd04d31b79" />

 - Подключиться к кластеру с помощью `kubectl`.
  ```
  yc managed-kubernetes cluster get-credentials --id xxx --external
  ```
<img width="834" height="169" alt="изображение" src="https://github.com/user-attachments/assets/82c8af12-f77a-4c0c-a849-0f12f9a37470" />

 - *Запустить микросервис phpmyadmin и подключиться к ранее созданной БД.
 - *Создать сервис-типы Load Balancer и подключиться к phpmyadmin. Предоставить скриншот с публичным адресом и подключением к БД.

Полезные документы:

- [MySQL cluster](https://registry.terraform.io/providers/yandex-cloud/yandex/latest/docs/resources/mdb_mysql_cluster).
- [Создание кластера Kubernetes](https://cloud.yandex.ru/docs/managed-kubernetes/operations/kubernetes-cluster/kubernetes-cluster-create)
- [K8S Cluster](https://registry.terraform.io/providers/yandex-cloud/yandex/latest/docs/resources/kubernetes_cluster).
- [K8S node group](https://registry.terraform.io/providers/yandex-cloud/yandex/latest/docs/resources/kubernetes_node_group).

---
