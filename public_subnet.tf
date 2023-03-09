

// Creatomg a Subnet 
resource "aws_subnet" "demo-public_subent_01" {
    vpc_id = "${aws_vpc.demo-vpc.id}"
    cidr_block = var.subnet_cidr
    map_public_ip_on_launch = "true"
    availability_zone = "ap-south-1a"
    tags = {
      Name = "demo-public_subent_01"
    }
  
}