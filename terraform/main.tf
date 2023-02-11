



provider "aws" {
  region = "us-east-2"
}

resource "aws_vpc" "myapp-vpc-1" {
  cidr_block = var.vpc_cidr_block
  tags = {
    Name = "${var.env_prefix}-vpc"
   }
}

resource "aws_subnet" "myapp-subnet-1" {
  vpc_id     = aws_vpc.myapp-vpc-1.id
  cidr_block = var.subnet_cidr_block 
  availability_zone = var.avail_zone
  tags = {
    Name = "${var.env_prefix}-subnet-1"
  }
}

resource "aws_route_table" "myapp_route-table" {
  vpc_id = aws_vpc.myapp-vpc-1.id


  route {
   cidr_block = "0.0.0.0/0"
   gateway_id = aws_internet_gateway.myapp-igw.id
  }
  tags = {
      Name = "${var.env_prefix}-route-1"
  }
}


resource "aws_internet_gateway" "myapp-igw" {

  vpc_id =  aws_vpc.myapp-vpc-1.id

    tags = {
      Name = "${var.env_prefix}-igw-1"
  }
}

resource "aws_route_table_association" "a-route-subnet" {
     subnet_id = aws_subnet.myapp-subnet-1.id
     route_table_id = aws_route_table.myapp_route-table.id

}

resource "aws_security_group" "myapp-sg" {
  name        = "myapp-sg"
  description = "Allow  inbound traffic"
  vpc_id      = aws_vpc.myapp-vpc-1.id

  ingress {
    description      = "TLS from VPC"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = [var.my_ip]
    
  }

   ingress {
    description      = "TLSS from VPC"
    from_port        = 8080
    to_port          = 8080
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    prefix_list_ids = []    
  }

  tags = {
    Name = "${var.env_prefix}-sg"
  }
}

/*data "aws_ami" "latest-amazon-linux-image" {
   most_recent = true 
   owners = ["amazon"]
   

}  */

resource "aws_instance" "myapp-server" {
    ami = "ami-05bfbece1ed5beb54" /*data.aws_ami.latest-amazon-linux-image.id */
    instance_type = var.instance_type
    subnet_id = aws_subnet.myapp-subnet-1.id
    vpc_security_group_ids  = [aws_security_group.myapp-sg.id] 
    availability_zone = var.avail_zone
    associate_public_ip_address = true
    key_name = myapp_key


    user_data = file("script.sh")
 
        tags = {
           Name = "${var.env_prefix}-server"
  }

  connection {
      type = "ssh"
      host = self.public_ip #remote server address
      user = "ec2-user"
      private_key = file(var.private_key)

  }

  provisioner "remote-exec" {
        inline = [
          "export ENV=dev",
          "mkdir newdir"
        ]
  }

}




output "ec2_public_ip" {

  value = aws_instance.myapp-server.public_ip
}


