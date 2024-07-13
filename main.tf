
provider "aws" {
  region = "ap-southeast-1"    

} 
# end to end steps
# write the code
# terraform Init
# terraformPlan
# terraformApply
# terraformdestroy

# VPC
resource "aws_vpc" "main" {
    cidr_block = "192.168.0.0/16"

    tags = {
      Name = "main-tf-vpc"       
    }
  
}
# subnet 1
resource "aws_subnet" "subnet1" {
    vpc_id = aws_vpc.main.id
    cidr_block = "192.168.1.0/24"
    availability_zone = "ap-southeast-1a"

    tags = {
      Name = "Subnet 1"
    }
  
}

# subnet 2
resource "aws_subnet" "subnet2" {
    vpc_id = aws_vpc.main.id
    cidr_block = "192.168.2.0/24"
    availability_zone = "ap-southeast-1b"

    tags = {
      Name = "subnet 2"  
    }
  
}
# Internet Gateway
resource "aws_internet_gateway" "igw" {
    vpc_id = aws_vpc.main.id

    tags = {
      Name = "main-vpc-igw"
    }
  
}
# Route Table
resource "aws_route_table" "route_table" {
    vpc_id = aws_vpc.main.id

    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.igw.id
    }
        tags = {
          Name = "main-route-table"
          
          }
          
}
  

# Route Table Association subnet 1
resource "aws_route_table_association" "subnet1" {
   subnet_id = aws_subnet.subnet1.id
   route_table_id = aws_route_table.route_table.id

  
}

# Route Table Association subnet 2
resource "aws_route_table_association" "subnet2" {
   subnet_id = aws_subnet.subnet2.id
   route_table_id = aws_route_table.route_table.id 
  
}