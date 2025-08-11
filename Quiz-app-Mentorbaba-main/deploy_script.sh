#!/bin/bash

# Quiz App Deployment Script for EC2
echo "Starting Quiz App deployment..."

# Update system
sudo yum update -y

# Install Python 3 and pip
sudo yum install -y python3 python3-pip

# Install MySQL client
sudo yum install -y mysql

# Install system dependencies for MySQL
sudo yum install -y gcc python3-devel mysql-devel

# Create app directory
sudo mkdir -p /opt/quiz-app
cd /opt/quiz-app

# Set permissions
sudo chown ec2-user:ec2-user /opt/quiz-app

# Install Python dependencies
pip3 install --user -r requirements_aws.txt

# Create systemd service file
sudo tee /etc/systemd/system/quiz-app.service > /dev/null <<EOF
[Unit]
Description=Quiz App Flask Application
After=network.target

[Service]
Type=simple
User=ec2-user
WorkingDirectory=/opt/quiz-app
Environment=PATH=/home/ec2-user/.local/bin
Environment=DB_HOST=YOUR_RDS_ENDPOINT
Environment=DB_USER=admin
Environment=DB_PASSWORD=QuizApp123!
Environment=DB_NAME=quizdb
Environment=DB_PORT=3306
Environment=SECRET_KEY=your-secret-key-here
ExecStart=/home/ec2-user/.local/bin/gunicorn --bind 0.0.0.0:5000 app_aws:app
Restart=always

[Install]
WantedBy=multi-user.target
EOF

# Enable and start service
sudo systemctl daemon-reload
sudo systemctl enable quiz-app
sudo systemctl start quiz-app

echo "Quiz App deployed successfully!"
echo "App is running on port 5000"