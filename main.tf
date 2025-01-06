provider "aws" {
  region = "us-east-1"

}

resource "aws_instance" "myec2" {
  ami                     = "ami-0dcc1e21636832c5d"
  instance_type           = "t2.micro"
  availability_zone = "us-east-1a"
}
