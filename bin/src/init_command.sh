parent_path=$( cd "$(dirname "${BASH_SOURCE[0]}")" ; pwd -P )
dest=${parent_path}/../terraform/root-modules/${args[name]}

cd $dest
terraform init -upgrade

