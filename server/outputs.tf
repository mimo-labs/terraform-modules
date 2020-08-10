output "droplet_ipv4" {
  value = digitalocean_droplet.this.ipv4_address
}

output "droplet_fqdn" {
  value = length(digitalocean_record.droplet_external) > 0 ? digitalocean_record.droplet_external[0].fqdn : ""
}

