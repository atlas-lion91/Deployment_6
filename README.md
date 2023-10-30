# Deployment Guide: Retail Banking Application on AWS with Terraform and Jenkins

October 28, 2023 

*Authored by: Khalil Elkharbibi*

## Introduction
This guide demonstrates how to deploy a Flask web application across two AWS regions (us-east-1, and us-west-2) using Infrastructure as Code (IaC) and Continuous Integration/Continuous Deployment (CI/CD) practices. Each region will include a Virtual Private Cloud (VPC), housing two public subnets, each running an EC2 instance to host the web application. The application instances will connect to a shared MySQL database managed by AWS RDS. This guide also covers setting up a Jenkins CI/CD pipeline to automate the deployment process.

### AWS Components:
- 2 VPCs (one in each region)
- 2 public subnets per VPC
- EC2 instances to host the Flask app
- An Application Load Balancer in each VPC
- A shared MySQL database via AWS RDS

### CI/CD Components:
- Jenkins host and agent servers for automated deployments

## Prerequisites
- AWS CLI installed and configured
- Terraform installed
- Jenkins installed


## System Diagram

## 1. Terraform Setup
1. **Initialize Your Terraform Project**: Run `terraform init` in your project directory.
2. **Configure AWS Credentials**: 
   - Ensure your AWS CLI is configured with the required credentials.
   - Alternatively, you can set the AWS credentials in your terminal session where Terraform will run:
     ```sh
     export AWS_ACCESS_KEY_ID="your_access_key"
     export AWS_SECRET_ACCESS_KEY="your_secret_key"
     ```

3. **Validate and Plan Your Infrastructure**: 
   - Check your Terraform files' syntax with `terraform validate`.
   - Preview the resources to be created with `terraform plan`.

4. **Apply Your Configuration**: Deploy your infrastructure using `terraform apply`.

5. **Clean Up**: When needed, remove your resources with `terraform destroy`.

6. **Manage Variables**: Use a `variables.tf` file to define and manage your Terraform variables.

## 2. Jenkins Infrastructure Setup
1. Use Terraform to deploy Jenkins host and agent servers within an existing VPC and subnet.
2. Configure Jenkins using the provided setup scripts.
3. Access Jenkins at `http://{jenkins-public-ip}:8080` and follow the setup wizard.

## 3. Jenkins Pipeline Configuration
1. Create a multibranch pipeline for your Flask application.
2. Configure the pipeline to connect to your GitHub repository.
3. Ensure that pushes to the main branch trigger builds.

## 4. Jenkins Agent Configuration
1. Add your Jenkins agent through the Jenkins dashboard.
2. Provide the necessary credentials and configuration details.

## 5. AWS RDS MySQL Database Setup
1. Navigate to the AWS RDS console and create a new MySQL database.
2. Ensure the database is publicly accessible and configure the security group to allow traffic on port 3306.
3. Note down the database endpoint for use in your application code.

## 6. Application Code Setup
1. Update the database connection strings in your Flask application's code.
2. Commit and push the changes to trigger the Jenkins pipeline.

## 7. AWS Infrastructure Details
- Each VPC contains an internet gateway, two public subnets, and EC2 instances hosting the Flask application.
- An Application Load Balancer is set up to distribute traffic between the EC2 instances.
---

## Issues 
> 1. **Resource Shortage in AWS**: Encountered insufficient CPU and internet gateway resources. The solution was to terminate unused resources and re-run Terraform.
> 2. **Database Endpoint Confusion**: Required trial and error to identify whether to use the DB instance identifier or initial database name.
> 3. **RDS Port Configuration**: Initially, port 3306 was not configured, leading to a failed test stage.
> 4. **Two-region Infrastructure in Terraform**: Resolved by giving an alias to the second AWS provider and specifying the provider for each related resource block.
> 5. **ALB VPC Selection**: Initially selected the wrong VPC when configuring the ALB, necessitating a recreation of the load balancer.

---

## Optimization

- Enhance Automation with Terraform Modules: Streamline the AWS Cloud Infrastructure setup.
- Implement Auto Scaling Groups with ALB: Ensure dynamic scaling based on traffic load.
- Utilize Docker for Application Deployment: Enhance the consistency and efficiency of deployments.

---

