output "networks" {
  value = {
    tools     = module.tools.vpcs
    prod_east = module.prod_east.vpcs
    prod_west = module.prod_west.vpcs
    staging   = module.staging.vpcs
    sandbox   = module.sandbox.vpcs
  }
}

