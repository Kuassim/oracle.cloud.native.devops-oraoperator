#!/bin/bash
CURRENT_TIME=$( date '+%F_%H:%M:%S' )

# set location
location=$CB_TERRAFORM_DIR

# mark start
state_set '.state.infra.terminate.STARTED |= $VAL' "$( date '+%F_%H:%M:%S' )"

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
state_set '.state.infra.terminate.DONE |= $VAL' "$( date '+%F_%H:%M:%S' )"