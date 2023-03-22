parent_path=$( cd "$(dirname "${BASH_SOURCE[0]}")" ; pwd -P )
template=${parent_path}/../terraform/templates/root-module
dest=${parent_path}/../terraform/root-modules/${args[name]}

echo "Creating a new terraform root module: ${args[name]}"

cp -a ${template} ${dest}
sed -i "" "s/<module_name>/${args[name]}/g" $dest/backend.tf

for provider in $(echo ${args[--providers]} | sed "s/,/ /g"); do
  echo "Using provider ${provider} in new module"
  cd $dest
  ln -s ../../providers/${provider}.tf ${provider}.tf
done

