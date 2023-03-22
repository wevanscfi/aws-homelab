template=terraform/templates/root-module
dest=terraform/root-modules/${args[name]}

echo "Creating a new terraform root module at ${dest} from template"

cp -a ${template} ${dest}
sed -i "" "s/<module_name>/${args[name]}/g" $dest/backend.tf

