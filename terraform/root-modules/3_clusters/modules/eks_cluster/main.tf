module "tags" {
  source              = "../../../../shared-modules/tags"
  env                 = var.env
  criticality         = "high"
  owner               = "platforms"
  data_classification = "confidential"
}

module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "19.10.1"

  cluster_name    = "${var.name}-${module.tags.name_suffix}"
  cluster_version = var.cluster_version

  cluster_addons = {
    vpc-cni = {
      resolve_conflicts        = "OVERWRITE"
      service_account_role_arn = module.vpc_cni_irsa.iam_role_arn
    }
  }

  vpc_id     = module.vpc.vpc_id
  subnet_ids = module.vpc.private_subnets

  eks_managed_node_group_defaults = {
    iam_role_attach_cni_policy = false
  }

  eks_managed_node_groups = {
    default = {}
  }

  tags = module.tags.aws_resource
}

module "vpc_cni_irsa" {
  source  = "terraform-aws-modules/iam/aws//modules/iam-role-for-service-accounts-eks"
  version = "5.14.3"

  role_name             = "vpc-cni-${var.name}-${module.tags.name_suffix}"
  attach_vpc_cni_policy = true
  vpc_cni_enable_ipv4   = true

  oidc_providers = {
    main = {
      provider_arn               = module.eks.oidc_provider_arn
      namespace_service_accounts = ["kube-system:aws-node"]
    }
  }

  tags = module.tags.aws_resource
}

module "karpenter_irsa" {
  source  = "terraform-aws-modules/iam/aws//modules/iam-role-for-service-accounts-eks"
  version = "5.14.3"

  role_name                          = "karpenter-${var.name}-${module.tags.name_suffix}"
  attach_karpenter_controller_policy = true

  karpenter_controller_cluster_id = module.eks.cluster_id
  karpenter_controller_node_iam_role_arns = [
    module.eks.eks_managed_node_groups["default"].iam_role_arn
  ]

  oidc_providers = {
    main = {
      provider_arn               = module.eks.oidc_provider_arn
      namespace_service_accounts = ["karpenter:karpenter"]
    }
  }

  tags = module.tags.aws_resource
}

