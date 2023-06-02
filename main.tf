module "networking" {
  source            = "./networking"
  vpc_cidr          = var.vpc_cidr
  public_cidrs      = var.public_cidrs
  private_cidrs     = var.private_cidrs
  availability_zone = var.availability_zone
}

module "compute" {
  source          = "./compute"
  bastion_host_sg = module.networking.bastion_host_sg
  webserver_sg    = module.networking.webserver_sg
  rds_sg          = module.networking.rds_sg
  private_subnets = module.networking.private_subnets
  public_subnets  = module.networking.public_subnets
  elb             = module.loadbalancing.elb
  alb_tg          = module.loadbalancing.alb_tg
}

module "loadbalancing" {
  source         = "./loadbalancing"
  public_subnets = module.networking.public_subnets
  vpc_id         = module.networking.vpc_id
  webserver_sg   = module.networking.webserver_sg
  webserver_asg  = module.compute.webserver_asg
}