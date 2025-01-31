# Configure AWS CLI on Your Local Machine

A step-by-step guide to install, configure, and verify the AWS CLI for interacting with AWS services from your local machine.

---

## Table of Contents
- [Prerequisites](#prerequisites)
- [Install AWS CLI](#install-aws-cli)
  - [macOS](#macos)
  - [Linux](#linux)
  - [Windows](#windows)
- [How to Get AWS Access Key and Secret Access Key](#how-to-get-aws-access-key-and-secret-access-key)
- [Configure AWS CLI](#configure-aws-cli)
- [Verify Configuration](#verify-configuration)
- [Basic Usage Examples](#basic-usage-examples)
- [Security Best Practices](#security-best-practices)
- [Contact](#contact)

---

## Prerequisites

1. **AWS Account**: Sign up at [AWS Free Tier](https://aws.amazon.com/free/) if you don’t have one.
2. **IAM User**: Create an IAM user with programmatic access and required permissions (e.g., `AdministratorAccess`).
3. **Access Keys**: Note the **Access Key ID** and **Secret Access Key** from the IAM user’s security credentials.

---

## Install AWS CLI 

### macOS
1. **Install via Homebrew**:
   ```bash
   brew install awscli
   
2. **Verify Installation**:
   ```bash
   aws --version
   # Example output: aws-cli/2.13.0 Python/3.11.4 Darwin/22.5.0 source/arm64
   
### Linux

1. Open a terminal.  
2. Run the following command to download the AWS CLI:  

   ```bash
   curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
3. Unzip and install
   ```bash
   unzip awscliv2.zip
4. Install AWS CLI
   ```bash
   sudo ./aws/install

6. Verify Installation
   ```bash
   aws --version
   # Example output: aws-cli/2.13.0 Python/3.11.4 Darwin/22.5.0 source/arm64
   
### Windows

### Step 1: Download the Installer
1. Visit the [AWS CLI Website]([https://aws.amazon.com/cli/](https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html)).
2. Download the **Windows MSI Installer**.

### Step 2: Run the Installer
1. Double-click the downloaded `.msi` file.
2. Follow the on-screen prompts to complete the installation.

### Step 3: Verify Installation
1. Open **Command Prompt**.
2. Run the following command to check the installed version:
   ```cmd
   aws --version
   # Example output: aws-cli/2.13.0 Python/3.11.4 Windows/10 exe/AMD64

---

## How to Get AWS Access Key and Secret Access Key

Follow these steps to create and retrieve your AWS Access Key and Secret Access Key.

---

Step 1: Sign in to the AWS Management Console
1. Go to the [AWS Management Console](https://aws.amazon.com/console/).
2. Sign in with your AWS account credentials.

Step 2: Open the IAM Console
1. In the AWS Management Console, search for **IAM** (Identity and Access Management) in the search bar.
2. Click on **IAM** to open the IAM console.

Step 3: Create an IAM User (if you don’t have one)
1. In the IAM console, navigate to **Users** in the left-hand menu.
2. Click **Add users**.
3. Enter a **User name** (e.g., `my-iam-user`).
4. Under **Select AWS access type**, check **Programmatic access**.
5. Click **Next: Permissions**.

Step 4: Attach Permissions to the User
1. Choose how to assign permissions:
   - **Add user to group**: Attach the user to an existing group with permissions.
   - **Copy permissions from existing user**: Copy permissions from another user.
   - **Attach policies directly**: Attach policies directly to the user (e.g., `AdministratorAccess` for full access).
2. Click **Next: Tags** (optional).
3. Click **Next: Review**.

Step 5: Review and Create the User
1. Review the user details and permissions.
2. Click **Create user**.

Step 6: Retrieve Access Key and Secret Access Key
1. After creating the user, you’ll see a confirmation screen.
2. Click **Download .csv** to save the credentials to your computer.
   - The `.csv` file contains:
     - **Access Key ID**: `AKIAXXXXXXXXXXXXXXXX`
     - **Secret Access Key**: `xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx`
3. **Important**: Store the `.csv` file securely. You won’t be able to retrieve the Secret Access Key again.

---

## Configure AWS CLI

1. Run the configuration wizard:
   ```bash
   aws configure
2. Enter the following details when prompted:
   ```bash
   AWS Access Key ID [None]: AKIAXXXXXXXXXXXXXXXX  # Replace with your Access Key
   AWS Secret Access Key [None]: xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx  # Replace with your Secret Key
   Default region name [None]: for example : us-east-1  # Preferred AWS region
   Default output format [None]: json  # Output format (json/text/table)
---
   
## Verify Configuration

### Step 1: Check Your AWS Identity
1. Run the following command to verify your AWS identity:
   ```bash
   aws sts get-caller-identity
   
   {
    "UserId": "AIDAXXXXXXXXXXXXXXXX",
    "Account": "123456789012",
    "Arn": "arn:aws:iam::123456789012:user/your-iam-username"
   }

2. Test S3 Access : Run the following command to list all S3 buckets in your account:
    ```bash
    aws s3 ls
    
    2023-10-01 12:34:56 my-first-bucket
    2023-10-02 14:20:10 my-second-bucket
    
---

## Basic Usage Examples
# 1. S3 Operations


1. Get all the S3 Bucket list
    ```bash
    aws s3 ls
    
    2023-10-01 12:34:56 my-first-bucket
    2023-10-02 14:20:10 my-second-bucket

# 2. EC2 Operations
 
1. To list all EC2 instances, use the following command:

    ```bash
    aws ec2 describe-instances

    
2. To start an EC2 instance, use the following command:

    ```bash
    aws ec2 start-instances --instance-ids i-1234567890abcdef0 // Replace your instance id

3. To stop an EC2 instance, use the following command:

    ```bash
    aws ec2 stop-instances --instance-ids i-1234567890abcdef0 // Replace your instance id

# 3. IAM Operations

1. To list all IAM users, use the following command:
    ```bash
    aws iam list-users
    
# 4. AWS CLI Command Reference

Go to the [AWS CLI DOCUMENTATION](https://awscli.amazonaws.com/v2/documentation/api/latest/index.html).
  

---

## Security Best Practices

### 1. Never Hardcode Credentials
- Avoid storing AWS keys in code or plaintext files.
- Use environment variables or AWS Secrets Manager for secure storage.

### 2. Use IAM Roles
- Prefer IAM roles over long-term credentials for EC2 instances, Lambda functions, and other AWS services.
- Roles provide temporary credentials that are automatically rotated.

### 3. Rotate Keys Regularly
- Rotate Access Keys every 90 days via the [AWS IAM Console](https://console.aws.amazon.com/iam/).
- Delete unused or compromised keys immediately.

### 4. Enable Multi-Factor Authentication (MFA)
- Enable MFA for your AWS root account and IAM users to add an extra layer of security.

### 5. Apply the Principle of Least Privilege
- Grant only the permissions necessary for a user or role to perform their tasks.
- Regularly review and update IAM policies.

### 6. Monitor Activity with AWS CloudTrail
- Enable AWS CloudTrail to log all API calls and monitor activity in your AWS account.
- Set up alerts for suspicious activity.

### 7. Use Encryption
- Encrypt sensitive data at rest (e.g., S3, RDS) and in transit (e.g., SSL/TLS).
- Use AWS Key Management Service (KMS) to manage encryption keys.

### 8. Regularly Audit Permissions
- Use IAM Access Analyzer to identify unintended resource access.
- Review and remove unnecessary permissions.

For more information, refer to the [AWS Security Best Practices Guide](https://docs.aws.amazon.com/security/).

---

## Contact
For questions or feedback:
📧 Email: patelj2400@gmail.com  
🐙 GitHub: patelj2400

