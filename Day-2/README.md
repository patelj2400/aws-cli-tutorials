# How to Create an EC2 Instance

Amazon Elastic Compute Cloud (EC2) is a web service that provides resizable compute capacity in the cloud. This guide will walk you through different ways to create an EC2 instance.

## Table of Contents
1. [Using AWS Management Console](#using-aws-management-console)
2. [Using AWS CLI](#using-aws-cli)
3. [Using AWS SDK for Python (Boto3)](#using-aws-sdk-for-python-boto3)
   - [Accessing EC2 Using AWS Management Console](#accessing-ec2-using-aws-management-console)  
   - [Accessing EC2 Using AWS CLI](#accessing-ec2-using-aws-cli)  

## Using AWS Management Console

1. **Sign in to the AWS Management Console**  
   Go to the [AWS Management Console](https://aws.amazon.com/console/) and sign in with your credentials.

2. **Navigate to EC2 Dashboard**  
   In the AWS Management Console, navigate to the EC2 Dashboard by searching for "EC2" in the services search bar.

3. **Launch Instance**  
   Click on the "Launch Instance" button.


4. **Give name and tags**  
   Give your instance name and select the tag(Optional)
   Add tags to your instance (e.g., Name: MyInstance).

5. **Choose an Amazon Machine Image (AMI)**  
   Select an AMI(Application Machine Image) from the list. You can choose from Amazon Linux, Ubuntu, Windows, etc.
   For example: Choose Ubuntu Server (24.04) SSD Volumne Type - **Free Tier Eligible**

   Select Architecutre you want (64-bit x86 or 64-bit Arm)

6. **Choose an Instance Type**  
   Select the instance type based on your requirements (e.g., t2.micro, t3.medium).
   For example: Select t2-micro -  **Free Tier Eligible**

7. **Configure Instance Details**  
   Configure the instance details such as the number of instances, network settings, IAM role, etc.
   For example: How many instances you want, network setting is all about how to access it" 

8. **Add Storage**  
   Specify the storage size and type (e.g., General Purpose SSD, Magnetic).
   For example: Which type of storage you want
   
9. **Configure Security Group**  
   Configure the security group to control inbound and outbound traffic.

10. **Select an Existing Key Pair or Create a New Key Pair**  
    Select an existing key pair or create a new one to securely connect to your instance.
    Note: This key pair will help you to access the EC2 instance locally from your machine

11. **Review and Launch**  
    Review your configuration and click "Launch."

## Using AWS CLI

1. Install AWS CLI
   If you haven't installed the AWS CLI, you can install it by following the [official guide](https://docs.aws.amazon.com/cli/latest/userguide/install-cliv2.html).

2. Configure AWS CLI 
   Configure the AWS CLI with your credentials:
   ```bash
   aws configure
3. Enter the following details when prompted
   ```bash
   AWS Access Key ID [None]: AKIAXXXXXXXXXXXXXXXX  # Replace with your Access Key
   AWS Secret Access Key [None]: xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx  # Replace with your Secret Key
   Default region name [None]: for example : us-east-1  # Preferred AWS region
   Default output format [None]: json  # Output format (json/text/table)

4. Run the Command to Create an EC2 Instance
    ```bash
    aws ec2 run-instances \
    --image-id ami-04b4f1a9cf54c11d0 \
    --instance-type t2.micro \
    --key-name demonode \
    --security-group-ids sg-0d314cffc6ba91929 \
    --count 1

Note: you can configure the instances according to your preference.

# Using AWS SDK for Python (Boto3)

## Install Boto3

1. Install Boto3 using `pip`:
    ```bash
    pip install boto3

2. Check Python whether installed in your system

3. Create a Python Script
    ```
    import boto3

    # Initialize the EC2 client
    ec2 = boto3.client('ec2')

    # Launch an EC2 instance
    response = ec2.run_instances(
        ImageId='ami-0abcdef1234567890',        # Replace with your AMI ID
        InstanceType='t2.micro',                # Instance type
        KeyName='MyKeyPair',                    # Key pair for SSH access
        SecurityGroupIds=['sg-0abcdef1234567890'],  # Security group ID
        SubnetId='subnet-0abcdef1234567890',    # Subnet ID
        MinCount=1,                             # Minimum number of instances
        MaxCount=1                              # Maximum number of instances
    )

    # Print the response
    print(response)

4. Run the Script (Execute the script to create the EC2 instance:)
    ```
    python your_script_name.py

5. Run this command to check instance created and running:
    ```
    aws ec2 describe-instances --query "Reservations[*].Instances[*].[InstanceId,State.Name,InstanceType,PublicIpAddress]" --output table


### Accessing EC2 Using AWS Management Console  
To access your EC2 instance using the AWS Management Console:  
1. Sign in to the [AWS Management Console](https://aws.amazon.com/console/).  
2. Navigate to **EC2 Dashboard**.  
3. Select the instance you want to access.  
4. Click **Connect**.  
5. Choose **Session Manager**, **RDP (Windows)**, or **SSH (Linux)** based on your instance type.  
6. Follow the on-screen instructions to connect.

### Accessing EC2 Using AWS CLI  
To access your EC2 instance using AWS CLI:  

## Prerequisites  
- Install and configure the AWS CLI.  
- Ensure your key pair (`.pem` file) is available.  
- Get the **public or private IP** of your instance.  

### Steps to Connect via SSH (Linux/Mac)  
1. Open a terminal.  
2. Run the following command:  
   ```sh
   ssh -i /path/to/your-key.pem ec2-user@your-instance-ip
   
- Replace /path/to/your-key.pem with the actual key pair path.
- Replace your-instance-ip with your instance's IP address.