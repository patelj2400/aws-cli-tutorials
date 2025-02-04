#!/bin/bash
#
#########################
# Author        : Jay
# Date          : 11 Dec 2024
#
# Version       : 3.0
#
# This script will report the AWS resources usage
#########################s

set -x

# Print header for the report
echo "=============================="
echo "AWS Resource Usage Report"
echo "=============================="
echo "Date: $(date)"
echo "=============================="

# Track S3 Buckets
echo "Print list of S3 buckets:"
aws s3 ls
echo "------------------------------"

# Track EC2 Instances
echo "Print list of EC2 instances:"
aws ec2 describe-instances | jq -r '.Reservations[].Instances[].InstanceId'
echo "------------------------------"

# Track Lambda Functions
echo "Print list of Lambda functions:"
aws lambda list-functions | jq -r '.Functions[].FunctionName'
echo "------------------------------"

# Track IAM Users
echo "Print list of IAM users:"
aws iam list-users | jq -r '.Users[].UserName'
echo "------------------------------"

# Disable debug mode
set +x

# Save output to a file
#output_file="aws_resource_report_$(date +%F).txt"
output_file="aws_resource_report_$(date +%F_%H-%M-%S).txt"
{
    echo "=============================="
    echo "AWS Resource Usage Report"
    echo "=============================="
    echo "Date: $(date)"
    echo "=============================="
    echo "S3 Buckets:"
    aws s3 ls
    echo "------------------------------"
    echo "EC2 Instances:"
    aws ec2 describe-instances | jq -r '.Reservations[].Instances[].InstanceId'
    echo "------------------------------"
    echo "Lambda Functions:"
    aws lambda list-functions | jq -r '.Functions[].FunctionName'
    echo "------------------------------"
    echo "IAM Users:"
    aws iam list-users | jq -r '.Users[].UserName'
    echo "------------------------------"
} > "$output_file"

echo "Report saved to $output_file"