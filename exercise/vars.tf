variable "region" {
  description = "The AWS region where resources will be created"
  type        = string
  default     = "us-east-1"
}

variable "instance_type" {
  description = "The type of AWS instance to create"
  type        = string
  default     = "t3.micro"
}

variable "availability_zone" {
  description = "The availability zone for the AWS instance"
  type        = string
  default     = "us-east-1a"
}

variable "ami_id" {
  description = "The AMI ID to use for the AWS instance"
  type        = map(any)
  default = {
    us-east-1 = "ami-0a7d80731ae1b2435" # Example AMI ID for Ubuntu 22.04 in us-east-1
    us-west-2 = "ami-0c55b159cbfafe1f0" # Example AMI ID for Ubuntu 22.04 in us-west-2
  }

}
