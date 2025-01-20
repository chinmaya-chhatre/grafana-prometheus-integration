#!/bin/bash

# Step 1: Install Ansible
echo "Installing Ansible..."
sudo yum install -y ansible || { echo "Failed to install Ansible. Exiting."; exit 1; }

# Step 2: Run Prometheus Playbook
echo "Running Prometheus playbook..."
ansible-playbook /home/ec2-user/install-prometheus.yml || { echo "Failed to run Prometheus playbook. Exiting."; exit 1; }

# Step 3: Run Grafana Playbook
echo "Running Grafana playbook..."
ansible-playbook /home/ec2-user/install-grafana.yml || { echo "Failed to run Grafana playbook. Exiting."; exit 1; }

# Step 4: Fetch Public IP Address
echo "Fetching public IP address..."
PUBLIC_IP=$(curl -s http://169.254.169.254/latest/meta-data/public-ipv4)
if [ -z "$PUBLIC_IP" ]; then
  echo "Failed to fetch public IP address. Please access the UIs using the following instructions:"
  echo "Prometheus: http://<your-ip-address>:9090"
  echo "Grafana: http://<your-ip-address>:3000"
else
  echo "Installation complete. Access the UIs using the URLs below:"
  echo "Prometheus: http://$PUBLIC_IP:9090"
  echo "Grafana: http://$PUBLIC_IP:3000"
fi
