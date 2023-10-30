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
> - Use Terraform to deploy Jenkins host and agent servers within an existing VPC and subnet.
> - Configure Jenkins using the provided setup scripts.
> - Access Jenkins at `http://{jenkins-public-ip}:8080` and follow the setup wizard.


### Instance 1: Jenkins Manager

> The Jenkins Manager orchestrates the entire CI/CD process, including initiating builds, running tests, and managing the deployment process. It is the central unit that coordinates all the tasks and distributes jobs to agent nodes.

#### Installations:

> - **Jenkins**: The core application that provides the automation server for building, testing, and deploying code. It manages jobs, monitors execution, and ensures the CI/CD process runs smoothly.

> - **software-properties-common**: This is a software utility that provides

### Instance 1: Jenkins Manager

#### Installations:

> - **Jenkins**: 
>  - *What it does*: The core application that provides the automation server for building, testing, and deploying code. 
>  - *Why it’s necessary*: It manages jobs, monitors execution, and ensures the CI/CD process runs smoothly.

> - **software-properties-common**: 
>  - *What it does*: Provides scripts to manage the software repositories from which you can install packages and applications.
>  - *Why it’s necessary*: It’s needed to add Personal Package Archives (PPAs) to the system, which allows you to install packages that are not available in the default repositories.

> - **add-apt-repository -y ppa:deadsnakes/ppa**: 
>  - *What it does*: Adds the DeadSnakes PPA to the system’s software repository list.
>  - *Why it’s necessary*: DeadSnakes PPA provides newer versions of Python that are not available in the default Ubuntu repositories. This ensures you can install the specific version of Python required for your project.

> - **python3.7**:
>  - *What it does*: Installs Python 3.7 on the system.
>  - *Why it’s necessary*: Many projects depend on Python for scripting, automation, and running various tools. Having a specific version ensures consistency across development environments.

> - **python3.7-venv**:
>  - *What it does*: Installs the Python 3.7 virtual environment package.
>  - *Why it’s necessary*: Virtual environments allow you to create isolated Python environments for different projects, preventing dependency conflicts.

> - **build-essential**:
>  - *What it does*: Installs a collection of packages that are essential for compiling software from source.
>  - *Why it’s necessary*: Required for building certain dependencies from source and for running build scripts.

> - **libmysqlclient-dev**:
>  - *What it does*: Provides the files required to compile Python modules that connect to MySQL.
>  - *Why it’s necessary*: If your project interacts with a MySQL database, this library is required to build the MySQL connector.

> - **python3.7-dev**:
>  - *What it does*: Provides the header files needed to build Python extensions.
>  - *Why it’s necessary*: Required for compiling certain Python modules from source.

### Instance 2: Jenkins Agent

> The Jenkins Agent is responsible for executing tasks assigned by the Jenkins Manager. In this context, it runs Terraform scripts, which are used for setting up infrastructure and deploying the application.

#### Installations:

> - **Terraform**: 
>  - *What it does*: An infrastructure as code (IaC) tool that allows you to build, change, and version infrastructure efficiently.
>  - *Why it’s necessary*: Used for automating the setup of infrastructure and deployment of the application. Ensures that the infrastructure is provisioned in a consistent and repeatable manner.

> - **default-jre**: 
>  - *What it does*: Installs the default Java Runtime Environment (JRE) on the system.
>  - *Why it’s necessary*: Jenkins is a Java-based application, and certain plugins or tools used within Jenkins might require Java to be present on the system.

> Together, these installations ensure that both the Jenkins Manager and Agent have the necessary tools and dependencies to manage and execute CI/CD tasks, leading to a more streamlined and reliable development workflow.


## Jenkins Pipeline Configuration
> 1. Create a multibranch pipeline for your Flask application.
> 2. Configure the pipeline to connect to your GitHub repository.
> 3. Ensure that pushes to the main branch trigger builds.

![Jenkins](https://github.com/atlas-lion91/Deployment_6/assets/140761974/6b8444c7-36ac-472d-89b2-d37ad82dc373)

## Jenkins Agent Configuration
> 1. Add your Jenkins agent through the Jenkins dashboard.
> 2. Provide the necessary credentials and configuration details.


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

> Ensure that your `Jenkinsfile` in your repository is correctly configured to handle the deployment process and that any necessary build and deployment scripts are included in your repository and referenced correctly in the `Jenkinsfile`.


## AWS RDS MySQL Database Setup
> 1. Navigate to the AWS RDS console and create a new MySQL database.
> 2. Ensure the database is publicly accessible and configure the security group to allow traffic on port 3306.
> 3. Note down the database endpoint for use in your application code.

## Application Code Setup
> 1. Update the database connection strings in your Flask application's code.
> 2. Commit and push the changes to trigger the Jenkins pipeline.

## Application Load Balancers
> Application Load Balancers (ALBs) distribute incoming application traffic across multiple targets, such as EC2 instances, in multiple Availability Zones. This ensures the application has increased fault tolerance.
> We set up ALB's in each region that our application is configured to deploy.
>
> 1. Region: us-east-1 (North Virginia)
>    - IP Address Type: ipv4
>    - Availability Zones: us-east-1c (use1-az6) & us-east-1b (use1-az4)
>    - Target Groups: arn:aws:elasticloadbalancing:us-east-1:896099932731:targetgroup/tg1-east/f84995c4a13236dd
>    - Target type: Application Load Balancer
>   
> 2. Region: us-west-2 (Oregon)
>     - IP Address Type: ipv4
>     - Availability Zones: us-west-2a (usw2-az1) & us-west-2b (usw2-az2)
>     - Target Groups: arn:aws:elasticloadbalancing:us-west-2:896099932731:loadbalancer/net/ALB-west/246bbf875230c27b
>     - Target type: Application Load Balancer
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

