# AWS Resources Tracker Script

This shell script automates the tracking of AWS resources such as EC2 instances, S3 buckets, Lambda functions, and IAM users. It generates a daily report and can be scheduled using a Cron job.

## Prerequisites

- **AWS CLI**: Installed and configured with the necessary permissions.
- **JQ**: Installed for parsing JSON output.
- **Bash Shell**: The script is written for Bash.

# Environment Variables

    export PATH="/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin"
    export AWS_PROFILE="default"
    export AWS_REGION="us-east-1"
  
# Script Directory and Log File

    SCRIPT_DIR=$(dirname "$(realpath "$0")")
    LOG_FILE="${SCRIPT_DIR}/aws-resources-tracker-2.0.txt"
    EXEC_ID=$(uuidgen)

## Script

    #!/bin/bash

    # AWS Resources Tracker Script
    # This script generates a daily report of AWS resources including EC2 instances, S3 buckets, Lambda functions, and IAM users.

# Environment Variables

    export PATH="/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin"
    export AWS_PROFILE="default"
    export AWS_REGION="us-east-1"
  
# Script Directory and Log File

    SCRIPT_DIR=$(dirname "$(realpath "$0")")
    LOG_FILE="${SCRIPT_DIR}/aws-resources-tracker-2.0.txt"
    EXEC_ID=$(uuidgen)

# Output file
    REPORT_FILE="aws_resources_report_$(date +%Y-%m-%d).txt"

# Function to log messages
    log_message() {
        echo "$(date '+%Y-%m-%d %H:%M:%S') - $1" | tee -a $REPORT_FILE
    }

# Check if AWS CLI is installed
    if ! command -v aws &> /dev/null; then
        log_message "AWS CLI is not installed. Please install it and configure it with the necessary permissions."
        exit 1
    fi

# Check if jq is installed
    if ! command -v jq &> /dev/null; then
        log_message "jq is not installed. Please install it to parse JSON output."
        exit 1
    fi

# Log start of script
    log_message "Starting AWS Resources Tracker Script..."

# Get EC2 instances
    log_message "Fetching EC2 instances..."
    EC2_INSTANCES=$(aws ec2 describe-instances --query "Reservations[*].Instances[*].[InstanceId, InstanceType, State.Name, LaunchTime]" --output json)
    echo "EC2 Instances:" | tee -a $REPORT_FILE
    echo "$EC2_INSTANCES" | jq '.' | tee -a $REPORT_FILE

# Get S3 buckets
    log_message "Fetching S3 buckets..."
    S3_BUCKETS=$(aws s3api list-buckets --query "Buckets[*].[Name, CreationDate]" --output json)
    echo "S3 Buckets:" | tee -a $REPORT_FILE
    echo "$S3_BUCKETS" | jq '.' | tee -a $REPORT_FILE

# Get Lambda functions
    log_message "Fetching Lambda functions..."
    LAMBDA_FUNCTIONS=$(aws lambda list-functions --query "Functions[*].[FunctionName, Runtime, LastModified]" --output json)
    echo "Lambda Functions:" | tee -a $REPORT_FILE
    echo "$LAMBDA_FUNCTIONS" | jq '.' | tee -a $REPORT_FILE

# Get IAM users
    log_message "Fetching IAM users..."
    IAM_USERS=$(aws iam list-users --query "Users[*].[UserName, CreateDate]" --output json)
    echo "IAM Users:" | tee -a $REPORT_FILE
    echo "$IAM_USERS" | jq '.' | tee -a $REPORT_FILE

# Log end of script
    log_message "AWS Resources Tracker Script completed. Report saved to $REPORT_FILE."