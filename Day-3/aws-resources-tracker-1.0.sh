#!/bin/bash

#########################
# Author        : Jay
# Date          : 11 Dec 2024
#
# Version       : v1.0
#
# This script reports AWS resource usage.
#########################

# Log file
LOG_FILE="aws-resources-tracker-1.0.txt"
echo "==================================================">> "$LOG_FILE"
# Functions for improved readability
log() {
  echo "$(date '+%Y-%m-%d %H:%M:%S') - $1" >> "$LOG_FILE"
}

# Verify AWS CLI is installed
if ! command -v aws &>/dev/null; then
  echo "AWS CLI is not installed. Exiting."
  exit 1
fi

# Start logging
log "Script execution started."

# AWS S3
log "S3 Buckets:"
if ! aws s3 ls --output table>> "$LOG_FILE" 2>> "$LOG_FILE"; then
  log "Error: Failed to list S3 buckets."
fi

# AWS EC2
log "EC2 Instances:"
if ! aws ec2 describe-instances --query 'Reservations[].Instances[].InstanceId' --output table >> "$LOG_FILE" 2>> "$LOG_FILE"; then
  log "Error: Failed to describe EC2 instances."
fi

# AWS Lambda
log "Lambda Functions:"
if ! aws lambda list-functions --output table >> "$LOG_FILE" 2>> "$LOG_FILE"; then
  log "Error: Failed to list Lambda functions."
fi

# AWS IAM Users
log "IAM Users:"
if ! aws iam list-users --query 'Users[].UserName' --output table >> "$LOG_FILE" 2>> "$LOG_FILE"; then
  log "Error: Failed to list IAM users."
fi

# End logging
log "Script execution completed."

