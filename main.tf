terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = var.region
}

data "aws_availability_zones" "available" {
  state = "available"

}


module "networking" {
  source             = "./modules/networking"
  availability_zones = data.aws_availability_zones.available.names
}

module "ec2" {
  source            = "./modules/ec2"
  instance_type     = var.instance_type
  subnet_id         = module.networking.public_subnet_ids[0]
  web_sg_id         = module.networking.web_sg_id
  key_name          = var.key_name
  ami_name_filter   = var.ami_name_filter
  ami_owners        = var.ami_owners
  availability_zone = data.aws_availability_zones.available.names[0]
}


module "rds" {
  source                = "./modules/rds"
  wordpress_db_name     = var.wordpress_db_name
  wordpress_db_user     = var.wordpress_db_user
  wordpress_db_password = var.wordpress_db_password
  db_instance_type      = var.db_instance_type
  db_sg_id              = module.networking.db_sg_id
  subnet_group_name     = module.networking.subnet_group_name
}

module "ebs" {
  source            = "./modules/ebs"
  availability_zone = data.aws_availability_zones.available.names[0]
  instance_id       = module.ec2.instance_id
}


