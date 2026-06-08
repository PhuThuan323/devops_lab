module "vpc" {
  source = "./modules/vpc"
  cidr           = var.cidr
  public_subnet  = var.public_subnet
  private_subnet = var.private_subnet
}