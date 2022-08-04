#!/bin/bash

PYTHON_FUNCTION=$CB_STATE_DIR/tasks/generate.py

CREATE_BRANCH_TOKEN="$(python $PYTHON_FUNCTION)"
state_set '.lab.webhook_tokens.create_branch_webhook |= $VAL' "$CREATE_BRANCH_TOKEN"

DELETE_BRANCH_TOKEN="$(python $PYTHON_FUNCTION)"
state_set '.lab.webhook_tokens.delete_branch_webhook |= $VAL' "$DELETE_BRANCH_TOKEN"

PUSH_BRANCH_TOKEN="$(python $PYTHON_FUNCTION)"
state_set '.lab.webhook_tokens.push_branch_webhook |= $VAL' "$PUSH_BRANCH_TOKEN"