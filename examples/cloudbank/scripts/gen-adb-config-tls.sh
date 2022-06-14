#!/bin/bash

# initialization
STATE_LOCATION=$CB_STATE_DIR/state.json


# requires Autonomous Database OCID
echo "Retreiving Autonomous Database OCID"
if [ "$(jq -e .lab.ocid.adb $STATE_LOCATION )" ]; then

  OCID=$(kubectl get AutonomousDatabase/cloudbankdb -o jsonpath='{.spec.details.autonomousDatabaseOCID}')

  if [ -z $OCID ]; then
    echo "Error: AutonomousDatabase OCID could not be retrieved."
    echo ""
    exit 1;
  fi

  echo $(jq --arg VAL $OCID '.lab.ocid.adb |= $VAL' $STATE_LOCATION) > $STATE_LOCATION
  echo "adb_ocid set."
fi
echo ""


# Set ADB OCID variable
ADB_OCID=$(state_get .lab.ocid.adb)


# generate YAML
echo -n "Generating YAML file..."
YAML_FILE=$CB_KUBERNETES_GEN_FILES_DIR/adb-config-tls.yaml
cp $CB_KUBERNETES_TEMPLATES_DIR/adb-config-tls-template.yaml $YAML_FILE
echo "DONE"


# Replacing Compartment OCID
echo -n "Updating generated YAML file..."
sed -e  "s|%ADB_OCID%|$ADB_OCID|g" $YAML_FILE > /tmp/adb-create.yaml
mv -- /tmp/adb-create.yaml $YAML_FILE
echo "DONE"


# Output copy
echo ""
echo "To apply:"
echo "kubectl apply -f $YAML_FILE"
echo ""