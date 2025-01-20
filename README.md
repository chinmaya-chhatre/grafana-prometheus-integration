# Prometheus and Grafana Setup Using Ansible

This repository provides an automated solution to install and configure **Prometheus** and **Grafana** on an Amazon Linux EC2 instance using Ansible. The setup includes shell and Ansible playbook scripts for a seamless configuration process.

---

## Prerequisites

### 1. **EC2 Instance Requirements**
- **Amazon Linux 2/2023** as the operating system.
- **Security Groups**:
  - Port `9090` open for Prometheus.
  - Port `3000` open for Grafana.
  - SSH (Port `22`) open for remote access.

### 2. **IAM Role**
- Attach an IAM role to the EC2 instance with the necessary permissions for the setup. Ensure the role has at least the following policies:
  - `ec2:DescribeInstances` (to fetch metadata like the public IP).

### 3. **Internet Access**
- Ensure the EC2 instance has internet access to download dependencies and packages.

---

## Security Group Configuration

### **Step 1: Create a Security Group**
1. **Login to AWS Console**:
   - Navigate to the [AWS Management Console](https://aws.amazon.com/console/).
   - Go to **EC2** under the "Services" menu.

2. **Create a Security Group**:
   - On the left-hand menu, click **Security Groups** under "Network & Security."
   - Click **Create Security Group**.
   - Provide the following details:
     - **Security group name**: e.g., `Prometheus-Grafana-SG`
     - **Description**: e.g., `Allows access to Prometheus and Grafana`
     - **VPC**: Select the appropriate VPC for your instance.

3. **Add Inbound Rules**:
   - Click **Add Rule** and configure the following:
     - **Type**: `Custom TCP Rule`
       - **Port Range**: `9090`
       - **Source**: `0.0.0.0/0` (or restrict to your IP range for security)
     - **Type**: `Custom TCP Rule`
       - **Port Range**: `3000`
       - **Source**: `0.0.0.0/0` (or restrict to your IP range for security)
     - **Type**: `SSH`
       - **Port Range**: `22`
       - **Source**: `0.0.0.0/0` (or restrict to your IP range for security).

4. **Add Outbound Rules** (optional):
   - Leave the default rule (`All traffic` allowed).

5. **Review and Create**:
   - Click **Create Security Group**.

---

### **Step 2: Attach Security Group to EC2 Instance**
1. **Navigate to EC2 Instances**:
   - In the AWS Console, go to **Instances** under "Instances" in the EC2 Dashboard.

2. **Select Your Instance**:
   - Select the EC2 instance where you are setting up Prometheus and Grafana.

3. **Modify Instance Security Group**:
   - Click **Actions** > **Security** > **Change security groups**.
   - In the **Edit security groups** window:
     - Select the newly created security group (`Prometheus-Grafana-SG`).
     - Click **Save**.

---

## Installation Steps

### Step 1: Clone or Upload Files
- Upload the following files to the home directory of your EC2 instance (`/home/ec2-user`):
  - `setup.sh` (Shell script to automate the process)
  - `install-prometheus.yml` (Ansible playbook for Prometheus)
  - `install-grafana.yml` (Ansible playbook for Grafana)

### Step 2: Run the Setup Script
1. SSH into your EC2 instance.
2. Make the script executable:
   ```bash
   chmod +x setup.sh
3. Execute the script:
   ```bash
   ./setup.sh
   
### Step 3: Verify the Installation
- Once the script completes, the public IP address of your instance will be displayed in the terminal. Use it to access the web interfaces:
  Prometheus: http://<ec2-instance-public-ip>:9090
  Grafana: http://<ec2-instance-public-ip>:3000

  
