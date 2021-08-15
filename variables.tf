variable "region" {
  description = "Define what region the instance will be deployed"
  default     = "us-east-1"
}

variable "name" {
  description = "Name of the Application"
  default     = "hammer-ec2"
}

variable "env" {
  description = "Environment of the Application"
  default     = "prod"
}

variable "ami" {
  description = "AWS AMI to be used "
  default     = "ami-0c2b8ca1dad447f8a"
}

variable "instance_type" {
  description = "AWS Instance type defines the hardware configuration of the machine"
  default     = "t2.micro"
}

variable "nlb_name" {
  description = "AWS network load balancer name"
  default     = "hammer-nlb"
}

variable "key_pair" {
  description = "AWS network load balancer name"
  default     = "hammer-key-pair"
}

variable "cidr_block" {
  description = "AWS network load balancer name"
  default     = "172.32.0.0/16"
}

variable "tg_control" {
  description = "AWS network load balancer name"
  default     = "true"
}

variable "terraform" {
  description = "AWS network load balancer name"
  default     = "terraform"
}

variable "ip_home" {
  description = "AWS network load balancer name"
  default     = "177.25.83.107/32"
}

variable "zone_us-east-1a" {
  description = "AWS network load balancer name"
  default     = "us-east-1a"
}

