variable "project_name" {
  type = string
}

variable "environment" {
  type = string
}

variable "internal_domain_name" {
  type    = string
  default = "internal.mimo"
}

variable "external_domain_name" {
  type    = string
  default = ""
}
