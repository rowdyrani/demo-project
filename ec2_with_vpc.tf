provider "aws" {
  region = "ap-south-1"
  profile = "anu"
}

resource "aws_instance" "ec2" {
    ami = var.ami
    instance_type = var.instance_type
    key_name = var.key-name
   // security_groups = ["demo-sg"]
   vpc_security_group_ids = ["${aws_security_group.demo-sg.id}"]
   subnet_id = "${aws_subnet.demo-public_subent_01.id}"
}

resource "aws_security_group" "demo-sg" {
    name = "demo-sg"
    vpc_id = "${aws_vpc.demo-vpc.id}"
    ingress {
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]

    }
    ingress {
        from_port = 80
        to_port = 80
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]

    }
    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }

    tags = {
        Name = "ssh-sg"

    }

}

//creating a VPC
resource "aws_vpc" "demo-vpc" {
    cidr_block = "10.3.0.0/16"
    tags = {
      Name = "demo-vpc"
    }
  
}

// Creatomg a Subnet 
resource "aws_subnet" "demo-public_subent_01" {
    vpc_id = "${aws_vpc.demo-vpc.id}"
    cidr_block = "10.3.1.0/24"
    map_public_ip_on_launch = "true"
    availability_zone = "ap-south-1"
    tags = {
      Name = "demo-public_subent_01"
    }
  
}

//Creating a Internet Gateway 
resource "aws_internet_gateway" "demo-igw" {
    vpc_id = "${aws_vpc.demo-vpc.id}"
    tags = {
      Name = "demo-igw"
    }
}

// Create a route table 
resource "aws_route_table" "demo-public-rt" {
    vpc_id = "${aws_vpc.demo-vpc.id}"
    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = "${aws_internet_gateway.demo-igw.id}"
    }
    tags = {
      Name = "demo-public-rt"
    }
}

// Associate subnet with routetable 

resource "aws_route_table_association" "demo-rta-public-subent-1" {
    subnet_id = "${aws_subnet.demo-public_subent_01.id}"
    route_table_id = "${aws_route_table.demo-public-rt.id}"
  
}