#!/bin/bash
set -euo pipefail

# change directory to example
cd ../../examples/hallow-world

# create the resources
terraform init
terraform apply -auto-approve



# wait while the instance boots up
# could also use a provisioner in the TF config to do this
sleep 60

# Query the output, extract the IP and make a request
terraform output -json |\
jq -r '.instance_ip_addr.value' |\
xargs -I {} curl http://{}:8080 -m 10


# if request succeeds, destroy the resources
terraform destroy -auto-approve