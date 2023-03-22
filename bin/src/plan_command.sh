dest=terraform/root-modules/${args[name]}

cd $dest
terraform plan -out=tfplan

