variable "ami" {
    default = "ami-09ba48996007c8b50" 
}

variable "associate_ip" {
    default = true
  
}
variable "instance_type" {
    default = "t2.micro"
}

variable "key-name" {
    default = "demo-key"
}

variable "vpc_cidr" {
    default = "10.3.0.0/16"
}

variable "subnet_cidr" {
    default = "10.3.1.0/24"
}