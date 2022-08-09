#!/bin/bash
$TENANCY_OCID=$1
NS=$(oci os ns get -c $TENANCY_OCID | jq -r .data)
echo $NS