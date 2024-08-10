# Hello World Web Application with ASP.NET Core
This repository contains a simple "Hello World" web application built with ASP.NET Core. It displays a custom greeting message that includes the current server time. Additionally, it logs each request to a file (log.txt) and standard output, including the timestamp and the requested path.
## Prerequisites
Before you begin, ensure you have the following installed on your machine:
 - Visual Studio .NET (version 5.0.0 or higher)
 - NET SDK (version 6.0 or higher)
## Steps to create the ASP.NET Core application:
Step-1. Open visual studio, create a new project, name it, select the version, select the templates, and finally click create project

Step-2. Create a new class startup.cs and implement it

Step-3. Add middleware for Request Logging in the project

Step-4. Build the project

Step-5. Debug it to run the application.

The application will start and display the "Hello World!" greeting message along with the current server time when accessed through a web browser and log each request to a file named log.txt including the timestamp and the requested path.
# Deploying an ASP.NET Web Application on AWS EC2 Instances
## Prerequisites for AWS
Before you start, ensure you have the following prerequisites:

- AWS Account: Sign up for an AWS account if you don't have one.
- AWS CLI: Install and configure AWS CLI. Follow the installation guide here.
- Terraform: Install Terraform. Follow the installation guide here.
## Brief Introduction about AWS and EC2 Instance
AWS (Amazon Web Services) is a cloud computing platform offering various services like compute power, storage, and databases. EC2 (Elastic Compute Cloud) is a web service that provides resizable compute capacity in the cloud. It allows you to launch and manage virtual servers, called instances, that can run various operating systems.

## Steps to Create an EC2 Instance
1. Sign in to AWS Management Console: Go to the AWS Console and sign in.
2. Navigate to EC2 Dashboard: Select "EC2" from the "Compute" section.
3. Launch Instance:
 - Click "Launch Instance".
 - Choose an AMI (Amazon Machine Image). For Windows, select "Microsoft Windows Server"; for Linux, choose "Amazon Linux".
 - Select an instance type (e.g., t2.micro for free tier eligibility).
 - Configure instance details, add storage, and configure security group (allow HTTP/HTTPS and RDP/SSH).
 - Review and launch the instance.
4. Access the Instance:
 - For Windows: Use RDP (Remote Desktop Protocol).
 - For Linux: Use SSH (Secure Shell).
## Host an ASP.NET Web Application on Windows IIS Server using EC2 Instance
1. Connect to Windows Instance: Use RDP to access your Windows EC2 instance.
2. Install IIS:
 - Open "Server Manager".
 - Go to "Add Roles and Features".
 - Select "Web Server (IIS)" and complete the installation.
3. Deploy ASP.NET Application:
 - Copy your ASP.NET application files to the instance.
 - Open IIS Manager, create a new site, and point to your application directory.
 - Configure bindings for your site (e.g., HTTP, HTTPS).
4. Access Your Application:
 - Open a browser and navigate to your EC2 instance's public IP address.
## Host an ASP.NET Web Application on Linux Server (Amazon Linux) using Apache HTTP Server (httpd)
1. Connect to Linux Instance: Use SSH to access your Linux EC2 instance.
2. Install Apache HTTP Server:

   ```bash
   sudo yum update -y
   sudo yum install -y httpd
   ```
4. Install .NET Runtime:
 - Follow instructions from the Microsoft .NET website.
4. Deploy ASP.NET Application:
 - Copy your ASP.NET application files to the server.
 - Configure Apache to serve your application. Update /etc/httpd/conf/httpd.conf with a virtual host configuration.
 - Restart Apache:

   ```bash
   sudo systemctl restart httpd
   ```
5. Access Your Application:
 - Open a browser and navigate to your EC2 instance's public IP address.
## Deploying an ASP.NET Web Application on Windows IIS Server using Terraform
### Pre-requisites for Using Terraform in VS Code:
Step-1. Install Visual Studio Code

Step-2. Install Terraform Extension

Step-3. Install Terraform

Step-4. Setup your personal AWS Account

Step-5. Generate an AWS Access Key ID and Secret Access Key from the AWS Management Console

### Creating an EC2 Instance Using Terraform:
Step-1. Set Up Terraform Configuration: Create a directory for your Terraform configuration files.

Step-2. Create an ec2 instance by writing terraform terraform 

Step-3. Initialize Terraform
```bash
terraform init
```
Step-4. Review and Apply Changes
```bash
terraform plan
```
Step-5. If everything looks good, apply the changes 
```bash
terraform apply
```
Step-6. To avoid incurring charges, destroy the deployed resources after testing
```bash
terraform destroy
```
### Deploying and Testing ASP.NET Web Application on Windows IIS Server
Step-1. Connect to the EC2 Instance

Step-2. Install IIS

Step-3. Deploy ASP.NET Web Application

Step-4. Test the Web Application

## Deploying an ASP.NET Web Application on Linux Server (Amazon Linux) using Apache HTTP Server with Terraform and Configure It Behind an Elastic Load Balancer
### Steps to Deploy ASP.NET Web Application on Linux Server with Terraform
Step-1. Set Up Terraform Configuration

Step-2. Create an linux_ec2 instance by terraform 

Step-3. Create all necessary vpc, subnets, security groups, route tables, internet gateway by writing terrafornm code

Step-3. Create Elastic Load Balancer by terraform

Step-4. Deploy ASP.NET Web Application

Step-5. Test the Web Application

## Testing
1. Obtain the DNS name of your load balancer from the Terraform output.
2. Open a web browser and navigate to the load balancer's DNS name.
3. Verify that the application loads successfully in the browser.
4. Monitor traffic distribution across instances for load balancing effectiveness.

## CONCLUSION
The deployment of the application on AWS with load balancing has been successfully configured and tested. Accessing the application through the load balancer's DNS name confirms its functionality, while monitoring ensures effective traffic distribution across instances, validating the robustness of the setup.
