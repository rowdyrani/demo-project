






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