variable "region" {
  description = "region of our ressources"
  type = string
  default = "us-east-1"
}

variable "provider-profile" {
  description = "profile of our provider"
  type = string
  default = "default"
}

variable "vpc_cidr_block" {
  type = string
  default = "192.168.0.0/16"
}

variable "vpc_name" {
  type = string
  default = "application-lb"
}

variable "private_subnet_cidr_block" {
  type = string
  default = "192.168.3.0/24"
}

variable "subnet_AZ_1" {
  type = string
  default = "us-east-1a"
}


variable "public_subnet_cidr_block_1" {
  type = string
  default = "192.168.1.0/24"
}

variable "public_subnet_cidr_block_2" {
  type = string
  default = "192.168.2.0/24"
}

variable "subnet_AZ_2" {
  type = string
  default = "us-east-1b"
}

variable "rtpublic_cidr_block" {
  type = string
  default = "0.0.0.0/0"
}

variable "rtprivate_cidr_block" {
  type = string
  default = "0.0.0.0/0"
}

variable "alb_sg_ingress_cird_block" {
  type = string
  default = "0.0.0.0/0"
}

variable "alb_sg_egress_cird_block" {
  type = string
  default = "0.0.0.0/0"
}

variable "alb_sg_name" {
  type = string
  default = "alb-security-group"
}

variable "ec2_sg_name" {
  type = string
  default = "webserver-sg"
}

variable "ec2_sg_ingress_cird_block" {
  type = string
  default = "0.0.0.0/0"
}

variable "ec2_sg_egress_cird_block" {
  type = string
  default = "0.0.0.0/0"
}

variable "instance-ami" {
  type = string
  default = "ami-0195204d5dce06d99"
}

variable "instance_type" {
  type = string
  default = "t2.micro"
}