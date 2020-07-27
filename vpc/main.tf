terraform {
  required_version = ">=0.12.0"
}

provider "digitalocean" {}

resource "digitalocean_vpc" "this" {
  name        = var.vpc_name
  description = var.description
  region      = var.region
  ip_range    = var.ip_range
}
