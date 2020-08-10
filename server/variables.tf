variable "droplet_name" {
  type = string
}

variable "image_name" {
  type = string
}

variable "region" {
  type = string
}

variable "size" {
  type = string
}

variable "private_networking" {
  type    = bool
  default = true
}

variable "vpc_id" {
  type = string
}

variable "domain_name" {
  type    = string
  default = ""
}

variable "external_domain_name" {
  type    = string
  default = ""
}

variable "project_name" {
  type    = string
  default = ""
}

variable "ssh_keys" {
  type    = list(string)
  default = []
}

variable "private_record_name" {
  type = string
}

variable "public_record_name" {
  type    = string
  default = ""
}

variable "firewall_name" {
  type    = string
  default = ""
}

variable "firewall_inbound_rules" {
  type = list(object({
    port_range       = string,
    protocol         = string,
    source_addresses = list(string)
  }))
  default = [{
    port_range       = "",
    protocol         = "",
    source_addresses = []
  }]
}

variable "firewall_outbound_rules" {
  type = list(object({
    port_range            = string,
    protocol              = string,
    destination_addresses = list(string)
  }))
  default = [{
    port_range            = "",
    protocol              = "",
    destination_addresses = []
  }]
}
