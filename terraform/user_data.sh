#!/bin/bash
# install docker and docker-compose, run image from ECR
apt-get update
apt-get install -y docker.io python3-pip
pip3 install awscli
systemctl enable --now docker

# login to ECR automatically using IAM instance role (aws cli v2 not required if role)
REGISTRY=$(aws ecr describe-registry --query "registryId" --output text)
# Pull image (adjust repo and tag)
aws ecr get-login-password --region us-east-1 | docker login --username AWS --password-stdin 637423375034.dkr.ecr.us-east-1.amazonaws.com
docker pull 637423375034.dkr.ecr.us-east-1.amazonaws.com/devops-practice:latest || true
docker run -d --name cs423-web -p 80:80 637423375034.dkr.ecr.us-east-1.amazonaws.com/devops-practice:latest

