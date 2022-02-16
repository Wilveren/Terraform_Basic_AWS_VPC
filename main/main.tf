#Calls the network module to create VPC, subnets, route tables, and route table associations.
module "network"{
    source    = "../modules/network"
}

#Calls module to create a public and private security group
module "security_groups"{
    source    = "../modules/security_groups"
}