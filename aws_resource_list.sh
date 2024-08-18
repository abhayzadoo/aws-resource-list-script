#!/bin/bash

# This script is use to list down all the active resources in your AWS Account.

#Author : Abhay Zadoo
#Version : v0.0.1

# Following are the supported services by the script

# - EC2
# - S3
# - RDS
# - DynamoDB
# - Lambda
# - VPC
# - IAM

# To Execute : ./aws_resource_list.sh <resion> <service_name>
# Example : ./aws_resource_list.sh us-east-1 S3

# First we check the user has run the script with required number of args

if [ $# -ne 2 ]; then
    echo "Please provide <region-name> <service name>"
    exit 1
fi

# Check the cloud (AWS) cli is installed
if ! command -v aws &>/dev/null; then
    echo "AWS CLI is not installed."
fi

# Check the cli is configured
if [ ! -d ~/.aws ]; then
    echo "AWS CLI is not configured"
    exit 1
fi

# Now we will check the service and execute the script

aws_region=$(echo "$1" | tr '[:upper:]' '[:lower:]')
aws_service=$(echo "$2" | tr '[:upper:]' '[:lower:]')
#tr '[:upper:]' '[:lower:]': The tr command translates all uppercase characters to lowercase.

case $aws_service in
ec2)
    echo "Checking Resources in $aws_service service"
    aws ec2 describe-instances --region "$aws_region"
    ;;
s3)
    echo "Checking Resources in $aws_service service"
    aws s3api list-bucket --region "$aws_region"
    ;;
rds)
    echo "Checking Resources in $aws_service service"
    aws red describe-db-instances --region "$aws_region"
    ;;
dynamodb)
    echo "Checking Resources in $aws_service service"
    aws dynamodb list-tables --region "$aws_region"
    ;;
lambda)
    echo "Checking Resources in $aws_service service"
    aws lambda list-functions --region "$aws_region"
    ;;
vpc)
    echo "Checking Resources in $aws_service service"
    aws ec2 describe-vpcs --region "$aws_region"
    ;;
iam)
    echo "Checking Resources in $aws_service service"
    aws iam list-users --region "$aws_region"
    ;;
*)
    echo "Invalid service name or Script is not written for $2 service"
    exit 1
    ;;
esac
