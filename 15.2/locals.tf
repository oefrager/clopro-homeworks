###ssh vars
locals {
#  serial-port-enable = 0
  ssh-keys           = "goi:${file("~/.ssh/id_ed25519.pub")}"
}
