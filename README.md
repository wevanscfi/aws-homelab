# Example terraform mono repo structure for management of multiple AWS org accounts

## Best practices demonstrated in this repository 
### Clear separation of root and shared modules
```
terraform
|-root-modules
  |- 0_remote_state
  |- 1_organization
  |- 2_sso
  |- 3_clusters
|-shared-modules
  |- tags
```

### Shared provider config for all root modules
A single providers.tf file is symlinked to all root modules, allowing addition and utilization of new AWS accounts in a single location.
The providers for each AWS account utilize IAM roles instead of permanent credentials for each account.

### Example utilization of inline modules to dry up configuration within a root module
[This terraform module](terraform/root-modules/3_clusters/) utilizes an inline module to contain all of the eks cluster resources and standard configuration. 
[The main.tf file](terraform/root-modules/3_clusters/main.tf) in the root module only needs to set environment specific configuration for each cluster, and pass in the appropriate provider. 

### Example utilization of shared modules to dry up configuration between root moudles
[A shared module](terraform/shared-modules/tags/main.tf) is utilized for containing the standard resource tagging dictionary. In this way, changes to our tag schema can be updated on all resources by only modifying them in one location, and we can be sure that all resources are tagged with the same fields.

The shared module can be initialized once in each modules that creates resources
```
module "tags" {
  source              = "../../../../shared-modules/tags"
  env                 = var.env
  criticality         = "high"
  owner               = "platforms"
  data_classification = "confidential"
}
```

And then utilized each time tags are needed
```
module "eks" {
  source = "terraform-aws-modules/eks/aws"
  cluster_name    = var.name
  cluster_version = var.cluster_version

  ...

  tags = module.tags.aws_resource
}

```

Resulting in resources that are tagged like this
```
  # module.staging_1_cluster.module.eks.module.eks_managed_node_group["default"].aws_eks_node_group.this[0] will be created
  + resource "aws_eks_node_group" "this" {
      + cluster_name           = "staging1"
      ...
      + tags                   = {
          + "Criticality"        = "high"
          + "DataClassification" = "confidential"
          + "Environment"        = "staging"
          + "Name"               = "default"
          + "Owner"              = "platforms"
          + "Terraform"          = "true"
        }
    }
```

