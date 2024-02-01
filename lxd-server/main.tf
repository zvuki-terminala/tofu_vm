#Storage pools
#resource "lxd_storage_pool" "xs_storage_pool" {
#    name = var.xs_storage_pool.name
#    driver = "zfs"
#}

#Networks
resource "lxd_network" "xs_network" {
    name = "xsbr0"

    config = {
        "ipv4.address" = var.xs_network.ipv4.address
        "ipv4.nat" = "true"
        "ipv6.address" = "none"
    }
}

#Profiles
resource "lxd_profile" "xs_profiles" {
    #depends_on = [
    #    lxd_storage_pool.xs_storage_pool
    #]

    for_each = {
        for index, profile in var.xs_profiles :
        profile.name => profile.limits
    } 

    name = each.key

    config = {
        "boot.autostart" = false
        "limits.cpu" = each.value.cpu
        "limits.memory" = each.value.memory
    }

    #device {
    #    type = "disk"
    #    name = "root"
#
    #    properties = {
    #        pool = var.xs_storage_pool.name
    #        path = "/"
    #    }
    #}
}

#Containers
resource "lxd_container" "xs_containers" {
    depends_on = [
        lxd_network.xs_network,
        lxd_profile.xs_profiles
    ]

    for_each = {
        for index, container in var.xs_containers :
        container.name => container
    }

    name = each.key
    image = var.xs_image
    profiles = [
        each.value.profile
    ]

    device {
        name = "eth0"
        type = "nic"
        properties = {
            network = lxd_network.xs_network.name
            "ipv4.address" = "${each.value.ip}"
        }
    }
}