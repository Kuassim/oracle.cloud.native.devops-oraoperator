#!/bin/bash

# Generate Tokens
PYTHON_FUNCTION=$CB_STATE_DIR/tasks/generate.py

# location of terraform
TF_LOCATION=$CB_STATE_DIR/terraform

# Generate Webhooks
IP_ADDRESS="$(terraform --chdir="${TF_LOCATION}" output -json | jq -r .jenkins_public_ip.value)"

CREATE_BRANCH_TOKEN="$(python $PYTHON_FUNCTION)"
state_set '.lab.tokens.create_branch_webhook.id |= $VAL' 'cbworkshop-create-branch-token'
state_set '.lab.tokens.create_branch_webhook.secret |= $VAL' "$CREATE_BRANCH_TOKEN"

DELETE_BRANCH_TOKEN="$(python $PYTHON_FUNCTION)"
state_set '.lab.tokens.delete_branch_webhook.id |= $VAL' 'cbworkshop-delete-branch-token'
state_set '.lab.tokens.delete_branch_webhook.secret |= $VAL' "$DELETE_BRANCH_TOKEN"

PUSH_BRANCH_TOKEN="$(python $PYTHON_FUNCTION)"
state_set '.lab.tokens.push_branch_webhook.id |= $VAL' 'cbworkshop-push-token'
state_set '.lab.tokens.push_branch_webhook.secret |= $VAL' "$PUSH_BRANCH_TOKEN"

CREATE_WEBHOOK_ADDRESS="${IP_ADDRESS}/generic-webhook-trigger/invoke?token=${CREATE_BRANCH_TOKEN}"
state_set '.lab.webhooks.create_branch_webhook.payload_url |= $VAL' $CREATE_WEBHOOK_ADDRESS
state_set '.lab.webhooks.create_branch_webhook.content_type |= $VAL' 'application/json'
state_set '.lab.webhooks.create_branch_webhook.event |= $VAL' 'Branch or tag creation only'

DELETE_WEBHOOK_ADDRESS="${IP_ADDRESS}/generic-webhook-trigger/invoke?token=${DELETE_BRANCH_TOKEN}"
state_set '.lab.webhooks.create_branch_webhook.payload_url |= $VAL' $DELETE_WEBHOOK_ADDRESS
state_set '.lab.webhooks.create_branch_webhook.content_type |= $VAL' 'application/json'
state_set '.lab.webhooks.create_branch_webhook.event |= $VAL' 'Branch or tag deletion only'

PUSH_WEBHOOK_ADDRESS="${IP_ADDRESS}/multibranch-webhook-trigger/invoke?token=${PUSH_BRANCH_TOKEN}"
state_set '.lab.webhooks.create_branch_webhook.payload_url |= $VAL' $PUSH_WEBHOOK_ADDRESS
state_set '.lab.webhooks.create_branch_webhook.content_type |= $VAL' 'application/json'
state_set '.lab.webhooks.create_branch_webhook.event |= $VAL' 'Just the push event'