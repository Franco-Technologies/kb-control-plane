locals { env = var.is_prod_branch == true ? "prod" : "dev" }
locals {
  app_vars_decoded = jsondecode(var.app_vars)
}

module "vpc" {
  source = "./modules/vpc"
  # Environment-specific variables
  vpc_cidr = var.vpc_cidr
  env      = local.env
}

module "load_balancer" {
  source = "./modules/load_balancer"
  # Environment-specific variables
  env            = local.env
  subnet_ids     = module.vpc.public_subnet_ids
  vpc_id         = module.vpc.vpc_id
  vpc_link_sg_id = module.vpc.vpc_link_sg_id
  tags = {
    Environment = "dev"
    Project     = "example"
  }
}


module "api_gateway" {
  source = "./modules/api_gateway"
  # Environment-specific variables
  rest_api_id   = local.app_vars_decoded.rest_api_id
  parent_id     = local.app_vars_decoded.parent_id
  authorizer_id = local.app_vars_decoded.authorizer_id
  nlb_dns_name  = module.load_balancer.nlb_dns_name
  nlb_arn       = module.load_balancer.nlb_arn
  tags = {
    Environment = "dev"
    Project     = "example"
  }
}

module "ssm" {
  providers = {
    aws = aws.default
  }
  depends_on = [
    module.vpc,
    module.load_balancer,
    module.api_gateway
  ]
  source = "./modules/ssm"

  # Environment-specific variables 
  param_name = "/${var.app_name}-cpservice/${local.env}/appvars"
  outputs = {
    vpc_id                      = module.vpc.vpc_id
    public_subnet_ids           = jsonencode(module.vpc.public_subnet_ids)
    private_subnet_ids          = jsonencode(module.vpc.private_subnet_ids)
    ecr_repository_url          = local.app_vars_decoded.ecr_repository_url
    ecs_cluster_arn             = local.app_vars_decoded.ecs_cluster_arn
    ecs_task_execution_role_arn = local.app_vars_decoded.ecs_task_execution_role_arn
    load_balancer_dns_name      = module.load_balancer.load_balancer_dns_name
    load_balancer_sg_id         = module.load_balancer.security_group_id
    listener_arn                = module.load_balancer.listener_arn
    load_balancer_arn           = module.load_balancer.load_balancer_arn
    api_gateway_id              = local.app_vars_decoded.rest_api_id
    api_gateway_root_resource   = local.app_vars_decoded.parent_id
    api_gateway_authorizer_id   = local.app_vars_decoded.authorizer_id
  }
}
