#!/bin/bash


BACK_UP_FILE=~/.bashrc-cbworkshop-backup

if [ -f "$BACK_UP_FILE"]; then
    mv "$BACK_UP_FILE" ~/.bashrc
else 
    echo "Error: .bashrc backup file not found. Please manually remove the lab-related commands inside ~/.bashrc"
fi