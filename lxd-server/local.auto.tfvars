xs_storage_pool = {
    name = "default"
}

xs_network = {
    ipv4 = { address = "192.168.42.1/24" }
}

xs_profiles = {
    name = "test"
    limits = {
      cpu    = 1
      memory = "1GiB"
    }
}

xs_containers = {
    name    = "test-01"
    profile = "xs_master"
    ip      = "192.168.42.11"
}