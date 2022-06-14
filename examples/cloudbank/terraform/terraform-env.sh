#!/bin/bash
# Terraform variables
export TF_VAR_region="$(state_get .lab.region)"
export TF_VAR_compartment_ocid="$(state_get lab.ocid.compartment)"
export TF_VAR_tenancy_ocid="$(state_get lab.ocid.tenancy)"