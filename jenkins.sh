#!/bin/bash

echo "install aws cli"
sudo dnf install unzip -y
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip awscliv2.zip
sudo ./aws/install

echo "Install Terraform"
sudo yum install -y yum-utils
sudo yum-config-manager --add-repo https://rpm.releases.hashicorp.com/RHEL/hashicorp.repo
sudo yum -y install terraform

echo "Install Jenkins"
# Combined into one line to fix the wget download issue
sudo wget -O /etc/yum.repos.d/jenkins.repo https://pkg.jenkins.io/rpm-stable/jenkins.repo

# Import the required GPG key so the package manager trusts the repository
sudo rpm --import https://pkg.jenkins.io/rpm-stable/jenkins.io-2023.key

sudo yum upgrade -y

# Add required dependencies for the jenkins package
sudo yum install fontconfig java-21-openjdk -y
sudo yum install jenkins -y

# Reload systemd, start Jenkins, and configure it to boot automatically
sudo systemctl daemon-reload
sudo systemctl enable jenkins
sudo systemctl start jenkins

echo "Jenkins installation complete! Checking status..."
sudo systemctl status jenkins --no-pager

