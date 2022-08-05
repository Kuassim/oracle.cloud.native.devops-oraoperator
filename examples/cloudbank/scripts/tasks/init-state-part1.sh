#!/bin/bash
# This script is called by setup.sh and initializes the state-file's state values
# This script will require the user to enter the following:
# - Region
# - Compartment OCID
# - Tenancy OCID
# - Jenkins Password

# todo - confirm below before continuing

# requires Reqion
read -p "Enter the region to use (e.g. us-phoenix-1): " INP
state_set '.lab.region.identifier |= $VAL' $INP

# requires compartment OCID
read -p "Enter the compartment OCID to provision resources in: " OCID
state_set '.lab.ocid.compartment |= $VAL' $OCID

# requires tenancy OCID
read -p "Enter the tenancy OCID to authenticate provisioning with: " tOCID
state_set '.lab.ocid.tenancy |= $VAL' $tOCID

# requires Jenkins password
read -s -r -p "Enter the Jenkins credentials to use: " JPWD
state_set '.lab.pwd.jenkins |= $VAL' $JPWD
echo "SET"