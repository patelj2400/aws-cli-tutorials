# Deploy Node.js JSON CRUD Application on AWS EC2

This guide explains how to deploy a Node.js JSON CRUD application on an **AWS EC2 instance** using Ubuntu.
---
# Table of Contents  

1. [Testing the Project Locally](#testing-the-project-locally)  
2. [Deploy on EC2 Instance](#deploy-on-ec2-instance)  

---

# **Prerequisites**

- AWS account
- SSH key pair for EC2
- Basic knowledge of Linux and Node.js

---
## 1. Testing the Project Locally  


1. Check Git, Node, Nmp installed in your system.

- Git Command
    ```sh
    git --version
    ```
    Output
    ```sh
    git version 2.39.5 (Apple Git-154)
    ```
- Node Command
    ```sh
    node --version
    ```
    Output
    ```sh
    v18.16.0
    ```
- NPM Command
    ```sh
    npm --version
    ```
    Output
    ```sh
    v18.16.0
    ```

    **Note: If git, node, npm not found in your system, Install it.**

2. Clone repo locally in your system.
    ```sh
    https://github.com/patelj2400/Basic-CRUD-Node.js.git

3. Install Dependenices
    ```sh
    npm install

4. Check .env file 

5. Run application locally

    ```sh
    node index.js

---
## 2. Deploy on EC2 Instance  


## **Step 1: Launch an EC2 Instance**
1. **Log in to AWS Console** → Go to **EC2 Dashboard**.
2. Click **"Launch Instance"** and configure:
   - **Amazon Machine Image (AMI)**: Select **Ubuntu 22.04 LTS**.
   - **Instance Type**: Choose **t2.micro** (Free Tier eligible).
   - **Key Pair**: Select an existing one or create a new key pair (**Save the .pem file!**).
   - **Security Group**: Allow:
     - **SSH (Port 22)**
3. Click **"Launch"**.

---

## **Step 2: Connect to EC2 Instance**
1. Open a terminal and run:
   ```sh
   ssh -i your-key.pem ubuntu@your-ec2-public-ip
   ```
2. Update the system:
   ```sh
   sudo apt update && sudo apt upgrade -y
   ```

---

## **Step 3: Install Node.js & NPM and Git**
1. Install **Node.js** and **npm** and **Git**:
   ```sh
   sudo apt install git-all
    ```
   ```sh
   sudo apt install nodejs
   ```
    ```sh
   sudo apt install npm
   ```
2. Verify installation:
   ```sh
   git -v
    ```
   ```sh
   node -v
    ```
   ```sh
   git -v
    ```   


---

## **Step 4: Clone the Project & Set Up Environment**
1. Navigate to the home directory:
   ```sh
   cd ~
   ```
2. Clone the project:
   ```sh
   git clone https://github.com/patelj2400/Basic-CRUD-Node.js.git
   ```
   ```sh
   cd Basic-CRUD-Node.js
   ```
3. Install dependencies:
   ```sh
   npm install
   ```
4. Check a `.env` file:
   ```sh
   cat .env
   ```
   Check file:
   ```env
   PORT=3000
   DATA_FILE=data.json
   BASE_URL=http://localhost:3000
   ```
   Save and exit (**CTRL+X → Y → ENTER**).

---

## **Step 5: Start the Server**
1. Start the application:
   ```sh
   node index.js
   ```
2. Check EC2 instance IP in your brower:
   ```sh
   http://your-ec2-public-ip:3000
   ```
---

## **Step 6: Open Security Group Ports**

EC2 instances block incoming traffic unless explicitly allowed.  
Make sure your Security Group allows inbound traffic on the port your app is running on (3000 by default).

### Steps to Allow Port 3000:
1. Go to **AWS EC2 Dashboard** → **Instances** → Click on your instance.
2. Scroll to **Security Groups** → Click on the associated security group.
3. Click **Inbound rules** → **Edit inbound rules**.
4. Click **Add rule**, then set:
   - **Type:** Custom TCP  
   - **Port range:** 3000  
   - **Source:** `0.0.0.0/0` (or your specific IP for security)  
5. Click **Save changes**.

Now, your EC2 instance should accept traffic on port **3000**.


---

## **Step 7: Access the Application**
- Open a browser and visit:
  ```
  http://your-ec2-public-ip:3000
  ```
- API can be accessed at:
  ```
  http://your-ec2-public-ip/items
  ```

---

🚀 **Your Node.js CRUD app is now live on AWS EC2!**
