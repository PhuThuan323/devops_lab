module "vpc" {
  source = "./modules/vpc"
  cidr           = var.cidr
  public_subnet  = var.public_subnet
  private_subnet = var.private_subnet
}

module "nat" {
  source = "./modules/natgateway"
  public_subnet_id = module.vpc.public_subnet_id
}

module "route_table" {
  source = "./modules/route_tables"

  vpc_id            = module.vpc.vpc_id
  public_subnet_id  = module.vpc.public_subnet_id
  private_subnet_id = module.vpc.private_subnet_id

  igw_id            = module.vpc.igw_id
  nat_gateway_id    = module.nat.nat_gateway_id
}
module "secu_groups" {
  source = "./modules/secu_groups"
  vpc_id = module.vpc.vpc_id
}

module "ec2" {
  source = "./modules/ec2"
  public_subnet_id  = module.vpc.public_subnet_id
  private_subnet_id = module.vpc.private_subnet_id

  public_sg_id  = module.secu_groups.public_sg_id
  private_sg_id = module.secu_groups.private_sg_id
  key_name = "my-keypair"
}