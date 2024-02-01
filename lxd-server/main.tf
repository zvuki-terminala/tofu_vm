terraform {
    required_providers {
      lxd = {
        source = "terraform-lxd/lxd"
      }
    }
}

provider "lxd" {
    generate_client_certificates = true
    accept_remote_certificate = true
}

resource "lxd_container" "lxd_container_testubuntu" {
    name = "testubuntu"
    image = "ubuntu:22.04"

    config = {
        "boot.autostart" = true
    }

    limits = {
        cpu = 1
    }
}