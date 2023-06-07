terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}

provider "aws" {
  region  = var.aws_region
  profile = "default"
}

module "vpc" {
  source   = "./modules/vpc"
  vpc_cidr = var.vpc_cidr
}

module "networking" {
  source             = "./modules/networking"
  vpc_id             = module.vpc.vpc_id
  public_cidrs       = var.public_cidrs
  private_cidrs      = var.private_cidrs
  availability_zones = var.availability_zones
}

module "database" {
  source            = "./modules/database"
  private_subnet_1a = module.networking.private_subnet_1a
  private_subnet_1b = module.networking.private_subnet_1b
  rds_sg            = module.networking.rds_sg
  rds_settings      = var.settings.database_instance
}

module "loadbalancing" {
  source         = "./modules/loadbalancing"
  public_subnets = module.networking.public_subnets
  vpc_id         = module.vpc.vpc_id
  web_sg         = module.networking.web_sg
  app_sg         = module.networking.app_sg
}

module "compute" {
  source          = "./modules/compute"
  db_instance     = module.database.db_instance
  dbEndpoint      = module.database.dbEndpoint
  public_subnets  = module.networking.public_subnets
  private_subnets = module.networking.private_subnets
  bastion_sg      = module.networking.bastion_sg
  rds_sg          = module.networking.rds_sg

  web_sg     = module.networking.web_sg
  web_alb    = module.loadbalancing.web_alb
  web_alb_tg = module.loadbalancing.web_alb_tg

  app_sg      = module.networking.app_sg
  app_alb     = module.loadbalancing.app_alb
  app_alb_tg  = module.loadbalancing.app_alb_tg
  app_alb_dns = module.loadbalancing.app_alb_dns

  settings = var.settings
}
