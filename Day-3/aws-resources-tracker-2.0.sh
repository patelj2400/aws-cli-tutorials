#!/bin/bash
#
#########################
# Author        : Jay
# Date          : 11 Dec 2024
#
# Version       : 2.0
#
# This script will report the AWS resources usage
#########################s


export PATH="/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin"
export AWS_PROFILE="default"
export AWS_REGION="us-east-1"

SCRIPT_DIR=$(dirname "$(realpath "$0")")

#LOG_FILE="/home/jaypatel/Desktop/practice/awstracker.txt"
LOG_FILE="${SCRIPT_DIR}/aws-resources-tracker-2.0.txt"

EXEC_ID=$(uuidgen)

#date   >> "$LOG_FILE"

#set -x #Debug
#set -e #Exit the script when it fail
#set -o pipefail #prvent the script executing after an error occurs

# Start Logging
echo "============ Execution ID: $EXEC_ID ============" >> "$LOG_FILE"
echo "Script execution started at $(date)" >> "$LOG_FILE"

# AWS S3
echo "S3 Buckets:" >> $LOG_FILE
/usr/local/bin/aws s3 ls >> $LOG_FILE 2>&1

# AWS EC2
echo "EC2 Instances:" >> $LOG_FILE
/usr/local/bin/aws ec2 describe-instances --query 'Reservations[].Instances[].InstanceId' --output text >> $LOG_FILE 2>&1

# AWS Lambda
echo "Lambda Functions:" >> $LOG_FILE
/usr/local/bin/aws lambda list-functions --output text >> $LOG_FILE 2>&1

# AWS IAM Users
echo "IAM Users:" >> $LOG_FILE
/usr/local/bin/aws iam list-users --query 'Users[].UserName' --output text >> $LOG_FILE 2>&1

# End Logging
echo "Script execution completed at $(date)" >> $LOG_FILE

echo "============================================================================" >> $LOG_FILE


# AWS S3
#echo "S3 Buckets:"
#aws s3 ls >> awstracker.txt

# AWS EC2
#echo "EC2 Instances:"
#aws ec2 describe-instances | grep -i instanceid >> awstracker.txt

# AWS LAMBDA
#echo "Lambda Functions:"
#aws lambda list-functions --output text >> awstracker.txt

# AWS IAM USERS
#echo "IAM Users:"
#aws iam list-users | grep UserName >> awstracker.txt
