#!/bin/bash

# Generate Tokens
PYTHON_FUNCTION=$CB_STATE_DIR/tasks/generate.py

# location of terraform
TF_LOCATION=$CB_STATE_DIR/terraform

CREATE_BRANCH_TOKEN="$(python $PYTHON_FUNCTION)"
state_set '.lab.tokens.create_branch_webhook.id |= $VAL' 'cbworkshop-create-branch-token'
state_set '.lab.tokens.create_branch_webhook.secret |= $VAL' "$CREATE_BRANCH_TOKEN"

DELETE_BRANCH_TOKEN="$(python $PYTHON_FUNCTION)"
state_set '.lab.tokens.delete_branch_webhook.id |= $VAL' 'cbworkshop-delete-branch-token'
state_set '.lab.tokens.delete_branch_webhook.secret |= $VAL' "$DELETE_BRANCH_TOKEN"

PUSH_BRANCH_TOKEN="$(python $PYTHON_FUNCTION)"
state_set '.lab.tokens.push_branch_webhook.id |= $VAL' 'cbworkshop-push-token'
state_set '.lab.tokens.push_branch_webhook.secret |= $VAL' "$PUSH_BRANCH_TOKEN"

