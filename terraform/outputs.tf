
output "network_info" {
  value = {
    vpc_id               = module.vpc.vpc_id
    public_subnet_id     = module.vpc.public_subnet_id
    private_subnet_id    = module.vpc.private_subnet_id
    igw_id               = module.vpc.igw_id
    nat_gateway_id       = module.nat.nat_gateway_id
    public_route_table   = module.route_table.public_route_table_id
    private_route_table  = module.route_table.private_route_table_id
  }
}