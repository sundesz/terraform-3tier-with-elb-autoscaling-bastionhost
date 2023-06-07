output "web_alb_dns" {
  value = module.loadbalancing.web_alb_dns
}

output "app_alb_dns" {
  value = module.loadbalancing.app_alb_dns
}

output "bastion_ip" {
  value = module.compute.bastion_ip
}