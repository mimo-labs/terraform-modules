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

variable "project_name" {
  type    = string
  default = ""
}

variable "ssh_keys" {
  type    = list(string)
  default = []
}
