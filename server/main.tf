terraform {
  required_version = ">=0.12.0"
}

provider "digitalocean" {}

data "digitalocean_image" "this" {
  name = var.image_name
}

resource "digitalocean_droplet" "this" {
  name   = var.droplet_name
  image  = data.digitalocean_image.this.id
  region = var.region
  size   = var.size

  private_networking = var.private_networking
  vpc_uuid           = var.vpc_id
  ssh_keys           = var.ssh_keys
}

resource "digitalocean_project_resources" "droplet_project" {
  count = var.project_name != "" ? 1 : 0

  project = var.project_name
  resources = [
    digitalocean_droplet.this.urn
  ]
}

resource "digitalocean_record" "droplet_internal" {
  count = var.domain_name != "" ? 1 : 0

  domain = var.domain_name
  type   = "A"
  name   = var.private_record_name
  value  = digitalocean_droplet.this.ipv4_address_private
}

resource "digitalocean_record" "droplet_external" {
  count = var.external_domain_name != "" ? 1 : 0

  domain = var.external_domain_name
  type   = "A"
  name   = var.public_record_name
  value  = digitalocean_droplet.this.ipv4_address
}

resource "digitalocean_firewall" "this" {
  count = var.firewall_name != "" ? 1 : 0

  name = var.firewall_name
  droplet_ids = [
    digitalocean_droplet.this.id
  ]

  dynamic "inbound_rule" {
    for_each = var.firewall_inbound_rules
    content {
      protocol         = inbound_rule.value["protocol"]
      port_range       = inbound_rule.value["port_range"]
      source_addresses = inbound_rule.value["source_addresses"]
    }
  }

  dynamic "outbound_rule" {
    for_each = var.firewall_outbound_rules
    content {
      protocol              = outbound_rule.value["protocol"]
      port_range            = outbound_rule.value["port_range"]
      destination_addresses = outbound_rule.value["destination_addresses"]
    }
  }
}
