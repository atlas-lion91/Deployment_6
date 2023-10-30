# Deployment Guide: Retail Banking Application on AWS with Terraform and Jenkins

October 28, 2023 

*Authored by: Khalil Elkharbibi*

## Introduction
> This guide demonstrates how to deploy a Flask web application across two AWS regions (us-east-1, and us-west-2) using Infrastructure as Code (IaC) and Continuous Integration/Continuous Deployment (CI/CD) practices. Each region will include a Virtual Private Cloud (VPC), housing two public subnets, each running an EC2 instance to host the web application. The application instances will connect to a shared MySQL database managed by AWS RDS. This guide also covers setting up a Jenkins CI/CD pipeline to automate the deployment process.

### AWS Components:
> - 2 VPCs (one in each region)
> - 2 public subnets per VPC
> - EC2 instances to host the Flask app
> - An Application Load Balancer in each VPC
> - A shared MySQL database via AWS RDS

### CI/CD Components:
> - Jenkins host and agent servers for automated deployments

## Prerequisites
> - AWS CLI installed and configured
> - Terraform installed
> - Jenkins installed


## System Diagram

## Terraform Setup
> 1. **Initialize Your Terraform Project**: Run `terraform init` in your project directory.
> 2. **Configure AWS Credentials**: 
>   - Ensure your AWS CLI is configured with the required credentials.
>   - Alternatively, you can set the AWS credentials in your terminal session where Terraform will run:
     ```sh
     export AWS_ACCESS_KEY_ID="your_access_key"
     export AWS_SECRET_ACCESS_KEY="your_secret_key"
     ```

> 3. **Validate and Plan Your Infrastructure**: 
>  - Check your Terraform files' syntax with `terraform validate`.
>  - Preview the resources to be created with `terraform plan`.

> 4. **Apply Your Configuration**: Deploy your infrastructure using `terraform apply`.

> 5. **Clean Up**: When needed, remove your resources with `terraform destroy`.

> 6. **Manage Variables**: Use a `variables.tf` file to define and manage your Terraform variables.

## Jenkins Infrastructure Setup
> 1. Use Terraform to deploy Jenkins host and agent servers within an existing VPC and subnet.
> 2. Configure Jenkins using the provided setup scripts.
> 3. Access Jenkins at `http://{jenkins-public-ip}:8080` and follow the setup wizard.


## Git and GitHub Integration

> Git is a distributed version control system that helps you track changes in your code throughout various stages of development. GitHub, on the other hand, is a web-based platform that uses Git for version control and provides a space for collaborative work on projects. For this retail banking application deployment, we extensively use Git for version control and GitHub for hosting our code repository and facilitating Continuous Integration (CI) and Continuous Deployment (CD) with Jenkins.

#### Setting Up the Repository

> 1. **Initialize a Git Repository**: If you haven’t already initialized a Git repository in your project directory, you can do so by running:
   ```bash
   git init
   ```

> 2. **Connect Your Local Repository to GitHub**: 
>   - Create a new repository on your GitHub account.
>   - Copy the repository’s URL.
>   - Run the following commands in your project directory:
  ```bash
       git clone https://github.com/atlas-lion91/Deployment_6.git
      cd Deployment_6/
      git init
      git branch second
      git switch second
      # Create a new directory jenkinsTerraform
      git add jenkinsTerraform
      # Generate necessary Terraform and script files
      terraform init
      terraform validate
      terraform plan
      terraform apply

  ```

> 3. **Push Your Code to GitHub**: 
>   - Add all the changes you’ve made to the staging area:
 ```bash
      git add main.tf terraform.tfvars variables.tf installfile1.sh installfile.sh
      git commit -m
     #Setup Jenkins Agent Infrastructure
      git push --set-upstream origin second
      git switch main
      git merge second
      git push --all
 ```

#### Continuous Integration and Deployment with Jenkins

> Utilizing GitHub with Jenkins for CI/CD automates the process of testing and deploying your application. Set up automated builds and deployments triggered by changes in your GitHub repository.

> Ensure that your `Jenkinsfile` in your repository is correctly configured to handle the deployment process, and that any necessary build and deployment scripts are included in your repository and referenced correctly in the `Jenkinsfile`.


## Jenkins Pipeline Configuration
> 1. Create a multibranch pipeline for your Flask application.
> 2. Configure the pipeline to connect to your GitHub repository.
> 3. Ensure that pushes to the main branch trigger builds.

## Jenkins Agent Configuration
> 1. Add your Jenkins agent through the Jenkins dashboard.
> 2. Provide the necessary credentials and configuration details.

## AWS RDS MySQL Database Setup
> 1. Navigate to the AWS RDS console and create a new MySQL database.
> 2. Ensure the database is publicly accessible and configure the security group to allow traffic on port 3306.
> 3. Note down the database endpoint for use in your application code.

## Application Code Setup
> 1. Update the database connection strings in your Flask application's code.
> 2. Commit and push the changes to trigger the Jenkins pipeline.

## AWS Infrastructure Details
> - Each VPC contains an internet gateway, two public subnets, and EC2 instances hosting the Flask application.
> - An Application Load Balancer is set up to distribute traffic between the EC2 instances.
---

## Issues 
> 1. **Resource Shortage in AWS**: Encountered insufficient CPU and internet gateway resources. The solution was to terminate unused resources and re-run Terraform.
> 2. **Database Endpoint Confusion**: Required trial and error to identify whether to use the DB instance identifier or initial database name.
> 3. **RDS Port Configuration**: Initially, port 3306 was not configured, leading to a failed test stage.
> 4. **Two-region Infrastructure in Terraform**: Resolved by giving an alias to the second AWS provider and specifying the provider for each related resource block.
> 5. **ALB VPC Selection**: Initially selected the wrong VPC when configuring the ALB, necessitating a recreation of the load balancer.

---

## Optimization

> - Enhance Automation with Terraform Modules: Streamline the AWS Cloud Infrastructure setup.
> - Implement Auto Scaling Groups with ALB: Ensure dynamic scaling based on traffic load.
> - Utilize Docker for Application Deployment: Enhance the consistency and efficiency of deployments.

---

