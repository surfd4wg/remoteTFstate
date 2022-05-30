variable AWS_REGION {
  description = "the region you want to stand this up in"
  default = ""
}

variable AWS_AZ {
  description = "the availability zone you want this in"
  default = ""
}

variable INSTANCE_TYPE {
  description = "the instance type you want"
  default = ""
}

variable "access_key" {
  description = "Access Key to AWS account"
  default     = "-replace access key-"
}

variable "secret_key" {
  description = "Secret Key to AWS account"
  default     = "----------replace secret key------------"
}

variable "client" {
  type        = string
  description = "Client name, used as a prefix for resource names"
}