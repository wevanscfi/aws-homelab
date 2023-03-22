parent_path=$( cd "$(dirname "${BASH_SOURCE[0]}")" ; pwd -P )
dest=${parent_path}/../terraform/root-modules

for dir in ${dest}/*
do
  test -d "$dir" || continue
  cd ${dir}
  echo $PWD
  rm -f tfplan
done

