#Creation public and private Security Groups. Public allows all incoming and outgoing traffic. Private allows HTTP and SSH traffic only 
#from public subnet IP addresses, but allows all outgoing traffic.
resource "aws_security_group" "public_sg" {
    name        = "public sg"
    description = "Allow all traffic in and out for public subnet"

    ingress {
        from_port        = 0
        to_port          = 0
        protocol         = "-1"
        cidr_blocks      = ["0.0.0.0/0"]
        ipv6_cidr_blocks = ["::/0"]
    }

    egress {
        from_port        = 0
        to_port          = 0
        protocol         = "-1"
        cidr_blocks      = ["0.0.0.0/0"]
        ipv6_cidr_blocks = ["::/0"]
    }

    tags = {
        Name  = "Public Security Group"
    }
}

resource "aws_security_group" "private_sg" {
    name        = "private sg"
    description = "Allows incoming http and ssh traffic from IP addresses of public subnet, and all outbound traffic"

    ingress {
        from_port       = 80
        to_port         = 80
        protocol        = "tcp"
        cidr_blocks     = ["10.0.0.0/24"]
    }

    ingress {
        from_port       = 22
        to_port         = 22
        protocol        = "tcp"
        cidr_blocks     = ["10.0.0.0/24"]
    }

    egress {
        from_port        = 0
        to_port          = 0
        protocol         = "-1"
        cidr_blocks      = ["0.0.0.0/0"]
    }
    
    tags = {
        Name  = "Private Security Group"
    }
}

