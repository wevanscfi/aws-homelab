template=terraform/templates/shared-module
dest=terraform/shared-modules/${args[name]}

echo "Creating a new terraform shared module at ${dest} from template"

cp -a ${template} ${dest}

