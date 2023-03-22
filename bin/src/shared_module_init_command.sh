parent_path=$( cd "$(dirname "${BASH_SOURCE[0]}")" ; pwd -P )
template=${parent_path}/../terraform/templates/shared-module
dest=${parent_path}/../terraform/shared-modules/${args[name]}

echo "Creating a new terraform shared module at ${dest} from template"

cp -a ${template} ${dest}

