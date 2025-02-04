# AWS Resources Tracker Script

This shell script automates the tracking of AWS resources such as EC2 instances, S3 buckets, Lambda functions, and IAM users. It generates a daily report and can be scheduled using a Cron job.

## Table of Contents
1. [Prerequisites](#prerequisites)
2. [How to setup cron job](#how-to-setup-cron-job)



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


## How to setup cron job

This guide explains how to schedule the **AWS Resources Tracker Script** to run automatically using a Cron job.

---

1. **Script Location**:
   - Ensure the script (`aws_resources_tracker.sh`) is saved in a directory and is executable.
   - Example: `/home/user/scripts/aws_resources_tracker.sh`

2. **Permissions**:
   - Make the script executable:
    
    ```bash
     chmod +x /home/user/scripts/aws_resources_tracker.sh
     

3. **Cron Access**:
   - Ensure you have access to edit the crontab for the user who will run the script.

---

## Steps to Set Up the Cron Job

1. **Open the Crontab Editor:**
   Run the following command to open the crontab file for editing:

    ```bash
    crontab -e

2. **Add the Cron Job:**

    ```bash
    0 2 * * * /home/user/scripts/aws_resources_tracker.sh >> /home/user/scripts/cron.log 2>&1

- Explanation:

    ```bash
    0 2 * * *: Schedule the script to run at 2:00 AM every day.

    /home/user/scripts/aws_resources_tracker.sh: Path to the script.

    >> /home/user/scripts/cron.log 2>&1: Redirects both standard output and errors to a log file (cron.log).

3. **Save and Exit:**

    - Save the crontab file and exit the editor.

    - If using nano, press CTRL + X, then Y, and Enter to save.

## Verify the Cron Job
1. Check Cron Logs:

    - To verify that the Cron job is running, check the logs:

    ```bash
    tail -f /home/user/scripts/cron.log

2. List Cron Jobs:

    - To view all scheduled Cron jobs for the current user:
    ```bash
    crontab -l

## Example Crontab Entry

Here’s an example of what the crontab entry might look like:

    # Edit this file to introduce tasks to be run by cron.
    # Each task is defined in a line with the following format:
    # m h  dom mon dow   command

    # Run AWS Resources Tracker Script daily at 2 AM
    0 2 * * * /home/user/scripts/aws_resources_tracker.sh >> /home/user/scripts/cron.log 2>&1


    ## Notes

### Time Zone

- Cron jobs use the system's time zone. Ensure the system time zone is correctly configured.

### Permissions

- Ensure the script and log file have the correct permissions to be executed and written to by the Cron user.

### Debugging

- If the script doesn’t run as expected, check the `cron.log` file for errors.