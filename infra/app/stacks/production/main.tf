module "rg" {
    source = "../../modules/resource_group"
    name = var.rg_name
    location = var.location
}

module "vnet" {
    source = "../../modules/vnet"
    name = var.vnet_name
    location = var.location
    rg_name = var.rg_name
    address_space = var.vnet_address_space 
}

module "subnet" {
    source = "../../modules/subnet"
    name = var.subnet_name
    rg_name = var.rg_name
    vnet_name = module.vnet.name
    address_prefix = var.subnet_address_prefix
}

module "vm_postgresql" {
    source = "../../modules/virtual_machine"
    vm_name = var.vm_name_postgre
    location = var.location
    rg_name = var.rg_name
    admin_username = var.admin_username
    subnet_id = module.subnet.subnet_id
    ssh_key_name = var.ssh_key_name
    ssh_key_rg = var.ssh_key_rg
}

module "vm_nodejs" {
    source = "../../modules/virtual_machine"
    vm_name = var.vm_name_nodejs
    location = var.location
    rg_name = var.rg_name
    admin_username = var.admin_username
    subnet_id = module.subnet.subnet_id
    ssh_key_name = var.ssh_key_name
    ssh_key_rg = var.ssh_key_rg
}

module "vm_react" {
    source = "../../modules/virtual_machine"
    vm_name = var.vm_name_react
    location = var.location
    rg_name = var.rg_name
    admin_username = var.admin_username
    subnet_id = module.subnet.subnet_id
    ssh_key_name = var.ssh_key_name
    ssh_key_rg = var.ssh_key_rg
}

module "nsg" {
    source = "../../modules/nsg"
    name = var.nsg_name
    location = var.location
    rg_name = var.rg_name
    inbound_ports_map = var.inbound_ports_map
}


