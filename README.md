# **Description**

This Terraform template will create a VPC in AWS with the following features:
- A Public and Private Subnet
- An Internet Gateway and NAT Gateway in the Public Subnet
- A Security Group for instances in the Public Subnet which allows all traffic
- A Security Group for instances in the Private Subnet which allows Ingress from IP addresses associated with the Public Subnet, and all egress traffic
- An ACL associated with the Private Subnet which allows incoming traffic from IP addresses associated with the Public Subnet, and all egress traffic
- A Route Table associated with the Public Subnet which will direct Traffic aimed outside the VPC to the Internet Gateway
- A Route Table associated with the Private Subnet which will direct traffic aimed outside of the VPC to the NAT Gateway

An ACL which allows all ingress and outgress traffic will be created and associated with the Public Subnet by default.


# **How To Use**
Change the working directory to '''./main'''


# **Prerequisites**

There are no special requirements or inputs required to deploy this, outside of what is necessary to run Terraform. As long as the Access Key and Secret Access Key in the AWS Credentials file are valid, the template can be deployed in your AWS Account. If necessary, don't forget to run '''aws configure''' into the AWS CLI to create or update this credentials file. 

This template was built and tested using Terraform version 1.0.8