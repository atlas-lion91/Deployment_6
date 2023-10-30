# Deployment of Banking Application with a Jenkins Agent Infrastructure using Terraform

*Date: October 28, 2023*  
*Authored by: Khalil Elkharbibi*

---

## Purpose
> The goal of this project is to leverage Jenkins agents for initializing our main infrastructure and subsequently deploying a banking application across four instances. The Jenkins agent will utilize Terraform commands (`init`, `plan`, and `apply`) for both infrastructure setup and application deployment.

---

## Step #1: Illustrating the VPC Infrastructure and the CI/CD Pipeline


## Step #2: Jenkins - Automating Build, Test, and Deploy
> Jenkins plays a crucial role in automating the building, testing, and deployment of our banking application. The Jenkins instance and the agent both require specific software installations. 

### Jenkins Agent Infrastructure
> Utilize Terraform to instantiate the Jenkins Agent Infrastructure, ensuring that the Jenkins instance and the Jenkins agent instance have all required installations, including Terraform itself.

### Setting Up Jenkins and Configuring the Node
Instructions:
> 1. **Create a Key Pair**: Essential for secure SSH access.
> 2. **Configure Jenkins**: Set up and configure the Jenkins node.
> 3. **Configure AWS Access and Secret Keys**: Required for the Jenkins node to execute Terraform scripts.
> 4. **Install the 'Pipeline Keep Running Step' Plugin**: Install manually through the Jenkins GUI.

---

## Step #3: GitHub/Git Integration and Setup
### Setting Up the GitHub Repository for Integration with Jenkins
> GitHub is pivotal as it stores the files that Jenkins needs for building, testing, building the infrastructure for our banking application, and finally deploying the application itself. To facilitate access from the Jenkins-installed EC2 instance to the repository, a GitHub token needs to be generated and provided to the EC2 instance.


#### GIT - Jenkins Agent Infrastructure
Commands to run:
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
# Commit the infrastructure code to the repository
git add main.tf terraform.tfvars variables.tf installs1.sh installs2.sh
git commit -m "Setup Jenkins Agent Infrastructure"
git push --set-upstream origin second
git switch main
git merge second
git push --all
```

#### GIT - Update DATABASE_URL
Commands to run:
```bash
git switch second
# Update the database endpoint in app.py, database.py, load_data.py
git commit -a -m "Update Database Endpoint"
git switch main
git merge second
git push --all
```

#### GIT - Banking Application Infrastructure
Commands to run:
```bash
git switch second
# Trigger Jenkins build here
git switch main
# Navigate to "initTerraform" and create Terraform files
terraform init
terraform validate
terraform plan
terraform apply
# Destroy resources after verification
terraform destroy
git add main.tf terraform.tfvars variables.tf deploy.sh
git commit -a -m "Setup Banking Application Infrastructure"
git switch main
git merge second
git push --all
```

---

## Step #4: Configuring Amazon RDS for Database Management
Amazon RDS is utilized to manage our MySQL database across all four instances. It automates backups, syncs data across regions, zones, and instances while ensuring security and reliability.

### Configuring the RDS Database


## Step #5: Utilizing Jenkins Agent for Terraform Script Execution
> The aim is to automate the construction of our banking application’s infrastructure across two regions (US-east-1 and US-west-2). For each region, we need to establish:

> - 1 VPC
> - 2 Availability Zones
> - 2 Public Subnets
> - 2 EC2 Instances
> - 1 Route Table
> - 1 Security Group (configured for ports 22 and 8000)

### Deploying the Application
> We use a `deploy.sh` script for installing dependencies and deploying the banking application. 

#### Jenkins Build
> Create a Jenkins build named "deploy_6" to run the `Jenkinsfilev`. This build encompasses stages such as "Build", "Test", "Clean", "Init", "Plan", and "Apply". The "Apply" stage also includes the application's deployment.

---

## Step #6: Configuring the Application Load Balancer (ALB)
> The ALB ensures an even distribution of incoming web traffic across multiple servers or instances, bolstering the application's availability, responsiveness, and efficiency.

### Setting Up the ALB


---

## Issues Encountered
> 1. **Resource Shortage in AWS**: Encountered insufficient CPU and internet gateway resources. The solution was to terminate unused resources and re-run Terraform.
> 2. **Database Endpoint Confusion**: Required trial and error to identify whether to use the DB instance identifier or initial database name.
> 3. **RDS Port Configuration**: Initially, port 3306 was not configured, leading to a failed test stage.
> 4. **Two-region Infrastructure in Terraform**: Resolved by giving an alias to the second AWS provider and specifying the provider for each related resource block.
> 5. **ALB VPC Selection**: Initially selected the wrong VPC when configuring the ALB, necessitating a recreation of the load balancer.

---

## Optimization Opportunities
> 1. **Enhance Automation with Terraform Modules**: Streamline the AWS Cloud Infrastructure setup.
> 2. **Implement Auto Scaling Groups with ALB**: Ensure dynamic scaling based on traffic load.
> 3. **Utilize Docker for Application Deployment**: Enhance the consistency and efficiency of deployments.

---

