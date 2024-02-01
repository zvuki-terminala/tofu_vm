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

resource "lxd_container" "lxd_container_test_ubuntu" {
    name = "test_ubuntu"
    image = "ubuntu:22.04"

    config = {
        "boot.autostart" = true
    }

    limits = {
        cpu = 1
    }
}