# VPC
output "vpc_id" {
  value = module.vpc.vpc_id
}

output "public_subnet_ids" {
  value = module.vpc.public_subnet_ids
}

output "private_subnet_ids" {
  value = module.vpc.private_subnet_ids
}

output "vpc_endpoints" {
  value = module.vpc.vpc_endpoints
}

output "vpc_link_sg_id" {
  value = module.vpc.vpc_link_sg_id
}

# Load Balancer
output "nlb_dns_name" {
  value = module.load_balancer.load_balancer_dns_name
}

output "nlb_arn" {
  value = module.load_balancer.load_balancer_arn
}

output "load_balancer_dns_name" {
  value = module.load_balancer.load_balancer_dns_name
}

output "listener_arn" {
  value = module.load_balancer.listener_arn
}

output "load_balancer_arn" {
  value = module.load_balancer.load_balancer_arn
}

output "target_group_arn" {
  value = module.load_balancer.target_group_arn
}

output "lb_security_group_id" {
  value = module.load_balancer.security_group_id
}
