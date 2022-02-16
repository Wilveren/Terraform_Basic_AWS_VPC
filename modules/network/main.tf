#Creating VPC, public subnet, and private subnet
resource "aws_vpc" "my_vpc" {
    cidr_block = "10.0.0.0/16"

    tags = {
        Name   = "My VPC"
    }
}

resource "aws_subnet" "public" {
    vpc_id  = aws_vpc.my_vpc.id
    cidr_block = "10.0.0.0/24"

    tags = {
        Name = "My Public Subnet"
    }
}

resource "aws_subnet" "private" {
    vpc_id  = aws_vpc.my_vpc.id
    cidr_block = "10.0.1.0/24"

    tags = {
        Name = "My Private Subnet"
    }
}


#Creating internet gateway for public subnet, and NAT gateway for allowing private subnet to reach out to the internet
resource "aws_internet_gateway" "my_igw" {
    vpc_id  = aws_vpc.my_vpc.id

    tags = {
        Name = "My Internet Gateway"
    }
}

resource "aws_eip" "nat" {
    vpc     = true
}

resource "aws_nat_gateway" "my_ngw" {
    allocation_id   = aws_eip.nat.id
    subnet_id       = aws_subnet.public.id

    tags = {
        Name = "My NAT Gateway"
    }
}


#Creatiing routing tables for direction traffic in both public and private subents, and associating them with the appropriate subnets
resource "aws_route_table" "public" {
    vpc_id  = aws_vpc.my_vpc.id

    route {
        cidr_block  = "0.0.0.0/0"
        gateway_id  = aws_internet_gateway.my_igw.id
    }

    tags = {
        Name = "Public RT"
    }
}

resource "aws_route_table" "private" {
    vpc_id  = aws_vpc.my_vpc.id

    route {
        cidr_block  = "0.0.0.0/0"
        nat_gateway_id = aws_nat_gateway.my_ngw.id
    }

    tags = {
        Name = "Private RT"
    }
}

resource "aws_route_table_association" "public_subnet_association"{
    subnet_id       = aws_subnet.public.id
    route_table_id  = aws_route_table.public.id
}

resource "aws_route_table_association" "private_subnet_association" {
    subnet_id       = aws_subnet.private.id
    route_table_id  = aws_route_table.private.id
  
}


#Creating Access Control Lists for Subnets
resource "aws_network_acl" "private" {
    vpc_id      = aws_vpc.my_vpc.id
    subnet_ids  = [aws_subnet.private.id]

    egress {
        protocol    = -1
        rule_no     = 100
        action      = "allow"
        cidr_block  = "0.0.0.0/0"
        from_port   = 0
        to_port     = 0
    }

    ingress {
        protocol    = "tcp"
        rule_no     = 100
        action      = "allow"
        cidr_block  = "10.0.0.0/24"
        from_port   = 80
        to_port     = 80
    }

        ingress {
        protocol    = "tcp"
        rule_no     = 200
        action      = "allow"
        cidr_block  = "10.0.0.0/24"
        from_port   = 22
        to_port     = 22
    }

    tags = {
        Name = "Private Subnet ACL"
    }
}