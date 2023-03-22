parent_path=$( cd "$(dirname "${BASH_SOURCE[0]}")" ; pwd -P )
dest=$(dirname ${parent_path})/terraform

find ${dest} -type f -name 'main.tf' -not -path '*/.*' -execdir bash -c "terraform-docs markdown ./ > README.md" \;

