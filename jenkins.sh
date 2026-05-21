#!/bin/bash

echo "install aws cli"
sudo dnf install unzip -y
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip -o awscliv2.zip
sudo ./aws/install --update

echo "Install Terraform"
sudo yum install -y yum-utils
sudo yum-config-manager --add-repo https://rpm.releases.hashicorp.com/RHEL/hashicorp.repo
sudo yum -y install terraform

echo "Install Jenkins"

sudo dnf install -y wget

sudo wget -O /etc/yum.repos.d/jenkins.repo https://pkg.jenkins.io/rpm-stable/jenkins.repo

# 1. Import the official Jenkins GPG key so your system trusts the repository
sudo rpm --import https://pkg.jenkins.io/rpm-stable/jenkins.io-2023.key

# 2. Download the repo file safely
sudo wget -O /etc/yum.repos.d/jenkins.repo https://pkg.jenkins.io/rpm-stable/jenkins.repo

# 3. FORCE DNF to clear its old cache and read the new Jenkins repo
# sudo dnf clean all 
# sudo dnf makecache

sudo yum upgrade -y

# 4. Install Java dependencies (Jenkins requires Java)
sudo dnf install fontconfig java-21-openjdk -y

# 5. Install, start, and enable Jenkins
sudo dnf install jenkins -y
sudo systemctl daemon-reload
sudo systemctl enable jenkins
sudo systemctl start jenkins

echo "Jenkins installation complete! Checking status..."
sudo systemctl status jenkins --no-pager

