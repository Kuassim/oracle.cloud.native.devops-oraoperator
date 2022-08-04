#!/bin/bash
# set location
location=$CB_TERRAFORM_DIR

# mark start
state_set '.state.infra.terminate|= $VAL' STARTED

# create log-file
logfile=$CB_STATE_DIR/logs/$CURRENT_TIME-terraform-destroy.log
touch $logfile

# terraform destroy workaround
(cd "$location" || exit ; rm -r .terraform)
(cd "$location" || exit ; rm .terraform.lock.hcl)

# init
terraform -chdir="${location}" init > $logfile

# destroy
terraform -chdir="${location}" destroy --auto-approve > $logfile

# mark complete
state_set '.state.infra.terminate|= $VAL' DONE