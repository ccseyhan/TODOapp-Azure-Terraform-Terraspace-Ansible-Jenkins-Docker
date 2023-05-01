# variable "enable_https_traffic_only" {
#   description = "forces HTTPS if enabled"
#   type        = string
#   default     = true
# }


variable "rg_name" {
  type = string
}

variable "location" {
  type = string  
}

variable "vnet_name" {
  type = string  
}

variable "vnet_address_space" {
  type = list(string)
}

variable "subnet_name" {
  type = string  
}

variable "subnet_address_prefix" {
  type = list(string)
}

variable "vm_name_postgre" {
  type = string  
}

variable "vm_name_nodejs" {
  type = string  
}

variable "vm_name_react" {
  type = string  
}

variable "admin_username" {
  type = string 
}

variable "ssh_key_name" {
  type = string  
}

variable "ssh_key_rg" {
  type = string  
}

variable "nsg_name" {
  type = string  
}

variable "inbound_ports_map" {
  type = map(string)
  
}