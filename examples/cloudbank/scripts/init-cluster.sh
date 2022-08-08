#!/bin/bash
# Sets the following cluster-related objects and settings
# - namespace

# mark start
state_set '.state.clustersetup.STARTED|= $VAL' "$( date '+%F_%H:%M:%S' )"

# Apply Namespace
NS=$(state_get .namespace)
kubectl apply -f $CB_KUBERNETES_TEMPLATES_DIR/namespace.yaml
kubectl config set-context --current --namespace=$NS
kubectl config view --minify | grep namespace:

# Apply service account
kubectl apply -f $CB_KUBERNETES_TEMPLATES_DIR/service-account.yaml


## Application Specific Secrets
# Create Load Balancer Certification
$CB_STATE_DIR/gen-lb-cert.sh

# Create secret for frontend-password
kubectl create secret generic cloudbank-password --from-literal=password=$(state_get .lab.pwd.login)

# Create secret for Schema password
kubectl create secret generic admin-password --from-literal=admin-password=$(state_get .lab.fixed_demo_user_credential)

state_set '.state.clustersetup.DONE|= $VAL' "$( date '+%F_%H:%M:%S' )"