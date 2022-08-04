#!/bin/bash
CURRENT_TIME=$( date '+%F_%H:%M:%S' )

# Mark Start of Script
state_set '.state.dbsetup|= $VAL' STARTED
echo -n "Initializing Autonomous Database (ADB)..."

# Download ADB Wallet
location="$CB_STATE_DIR/generated/wallet.zip"
CONNSERVICE=cloudbankdb_tp
$CB_STATE_DIR/tasks/download-adb-wallet.sh

# Retrieve Password
password=$(state_get .lab.fixed_demo_user_credential)
if [ -z "$password" ]; then
  echo "Error: Database user credentials were not found and the database cannot be initialized."
  state_set '.state.dbsetup|= $VAL' ERROR
  exit 1;
fi
echo ''

# Navigate to SQL directory and Run Initialization
touch $CB_STATE_DIR/logs/$CURRENT_TIME-sql-setup.log
(cd $CB_ROOT_DIR/sql || exit ;  ./configure-adb.sh $location $password $CONNSERVICE > $CB_STATE_DIR/logs/$CURRENT_TIME-sql-setup.log)
echo "DONE"

# mark completed
state_set '.state.dbsetup|= $VAL' DONE