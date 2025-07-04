# Домашнее задание к занятию «Вычислительные мощности. Балансировщики нагрузки»  

## Задание 1. Yandex Cloud 

1. Создать бакет Object Storage и разместить в нём файл с картинкой:

 - Создать [бакет](bucket.tf) в Object Storage с произвольным именем (например, _имя_студента_дата_).

![изображение](https://github.com/user-attachments/assets/74852382-de61-4513-967c-14f2ece81f70)

 - Положить в бакет файл с картинкой.

![изображение](https://github.com/user-attachments/assets/24cdd6bc-c732-4253-a6dd-23627221b578)

 - Сделать файл доступным из интернета.
 
 ![изображение](https://github.com/user-attachments/assets/b247994c-3450-45c8-9a62-3f9f56519ec4)

2. Создать группу ВМ в public подсети фиксированного размера с шаблоном LAMP и веб-страницей, содержащей ссылку на картинку из бакета:

 - Создать [Instance Group](resourse-vn.tf) с тремя ВМ и шаблоном LAMP. Для LAMP рекомендуется использовать `image_id = fd827b91d99psvq5fjit`.

![изображение](https://github.com/user-attachments/assets/5bb58b32-5399-4227-a4c1-fad0eb9e8fab)

![изображение](https://github.com/user-attachments/assets/61b7c98b-9e88-453b-92a0-1f8f9e98ed89)

 - Для создания стартовой веб-страницы рекомендуется использовать раздел `user_data` в [meta_data](https://cloud.yandex.ru/docs/compute/concepts/vm-metadata).
 - Разместить в стартовой веб-странице шаблонной ВМ ссылку на картинку из бакета.
   ```
      user-data  = <<EOF
        !/bin/bash
        cd /var/www/html
        echo '<html><head><title>It's my picture</title></head> <body><h1></h1><img src="http://${yandex_storage_bucket.iam-bucket.bucket_domain_name}/DYGA.jpg"/></body></html>' > index.html
        EOF
   ```
 - Настроить проверку состояния ВМ.
   ```
   health_check {
     interval = 10
     timeout  = 5
     tcp_options {
       port = 80
   ```

3. Подключить группу к сетевому балансировщику:

 - Создать [сетевой балансировщик]().
 
 ![изображение](https://github.com/user-attachments/assets/6ca4aaec-4cb0-46e4-9121-94dbca02b9b9)
 
 ![изображение](https://github.com/user-attachments/assets/297ea0b0-5f90-470a-95b4-e70168615551)

 - Проверить работоспособность, удалив одну или несколько ВМ.

![изображение](https://github.com/user-attachments/assets/69a6fefe-8ab8-4a8b-a476-ab9a5077efe6)


4. (дополнительно)* Создать Application Load Balancer с использованием Instance group и проверкой состояния.
