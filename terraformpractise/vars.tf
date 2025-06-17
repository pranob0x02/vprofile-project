variable "AWS_REGION" {
  description = "The AWS region to deploy resources in"
  type        = string
  default     = "us-east-1"
}

variable "AWS_VPC_NAME" {
  description = "The name of the VPC"
  type        = string
  default     = "vprofile-vpc"

}

variable "AWS_VPC_CIDR" {
  description = "The CIDR block for the VPC"
  type        = string
  default     = "172.21.0.0/16"
}

variable "AWS_ZONE" {
  description = "The availability zones"
  type        = list(string)
  default     = ["us-east-1a", "us-east-1b", "us-east-1c"]
}

variable "AWS_VPC_PUBLIC_SUBNETS" {
  description = "The public subnets for the VPC"
  type        = list(string)
  default     = ["172.21.1.0/24", "172.21.2.0/24", "172.21.3.0/24"]
}

variable "AWS_VPC_PRIVATE_SUBNETS" {
  description = "The private subnets for the VPC"
  type        = list(string)
  default     = ["172.21.4.0/24", "172.21.5.0/24", "172.21.6.0/24"]
}

variable "PROJECT_NAME" {
  description = "The name of the project"
  type        = string
  default     = "vprofile-project"

}

variable "username" {
  description = "The username for the RDS instance"
  type        = string
  default     = "admin"
}

variable "password" {
  description = "The password for the RDS instance"
  type        = string
  default     = "admin123"
}

variable "db_name" {
  description = "The name of the database"
  type        = string
  default     = "accounts"

}

variable "rmqusername" {
  description = "The username for the RabbitMQ broker"
  type        = string
  default     = "rabbit"

}

variable "rmqpassword" {
  description = "The password for the RabbitMQ broker"
  type        = string
  default     = "Gr33n@pple123456"

}
