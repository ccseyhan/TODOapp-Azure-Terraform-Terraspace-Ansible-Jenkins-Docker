variable "name" {
    type = string  
}

variable "location" {
    type = string
}

variable "rg_name" {
    type = string
}

variable "inbound_ports_map" {
    type = map(string)  
}
