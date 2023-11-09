provider "aws" {

}

#security group
resource "aws_security_group" "access" {
        name = "access"
        description = "allow ssh and http"

        ingress {
                from_port = 80
                to_port = 80
                protocol = "tcp"
                cidr_blocks = ["0.0.0.0/0"]
        }

        ingress {
                from_port = 22
                to_port = 22
                protocol = "tcp"
                cidr_blocks = ["0.0.0.0/0"]
        }

        egress {
                from_port = 0
                to_port = 0
                protocol = "-1"
                cidr_blocks = ["0.0.0.0/0"]
        }


}

resource "aws_instance" "web-server" {
  ami           = "ami-05a5f6298acdb05b6"
  availability_zone = "us-east-1a"
  instance_type = "t2.micro"
  security_groups = ["${aws_security_group.access.name}"]
  key_name = aws_key_pair.deploy.key_name
  tags = {
    Name  = "hello-World"
    Stage = "testing"
    Location = "INDIA"
  }

}


resource "aws_key_pair" "deploy" {
  key_name   = "deploy-key"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQCvuOBkj1CjHPuwNhI/GaD3EGctp0c+ilEF3dP0eBL3XCyjWOaDvXq5eyI2GSm4DxH4bC5Aas3x2564XCD9CTGR4QdGBoJa0oCNhPNxrRwC8pKM4AKmQHcIGSpgaEobKz5+NmHFRBuOMhmzvOS6+vxB0hG+9+avT6+WreTWOk6fO5LfT8tZOtanH+KkJvpHOwJbPqS+p012er2qiQzovAZgNLRqWFuFiL1cuU156EQUNJDVpnv6cNjY4ydUK1dOBs4lrxiaHLuf1sFhqZf5Sv2bYRwN1DR+Dih+0O1D5k3kgE6hEDxW+cXPG7StqHFsqFVBE2qceZfT2N4hFKQQE3r0wUbBWzp+x7IiB5mgidLpF253JaqqpgjsAPb8z9XY2MMGn+a2Jd3aPn9KFxng6KLRy1K3Y38pTVZpBQIv618a6S+UpJFK7esAfMfXJpjGjoNbDn+sklZgveyOyNrne2zIRlBCQj+HbRPa21GHZLBL+yZgK81bnpb4jNddh8f97+0= root@terraform"
}
