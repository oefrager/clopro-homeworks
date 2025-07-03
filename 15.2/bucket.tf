resource "yandex_storage_bucket" "iam-bucket" {
  bucket    = "goi-bucket"
  folder_id = var.folder_id
  acl    = "public-read"
}

resource "yandex_storage_object" "object" {
  bucket    = yandex_storage_bucket.iam-bucket.id
  key       = "DYGA.jpg"
  source    = "~/Netology_src/6_clopro-homeworks/DYGA.jpg"
  acl       = "public-read"
}