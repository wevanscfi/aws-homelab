dest=terraform/root-modules/${args[name]}

cd $dest
terraform apply tfplan

