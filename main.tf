provider "aws" {
	region = "ap-northeast-1"
}

resource "aws_instance" "my_instance" {
	ami = "ami-0278fe6949f6b1a06"
	instance_type = "t2.micro"
	
	tags = {
		"Name" = "terraform-example"
	}
}