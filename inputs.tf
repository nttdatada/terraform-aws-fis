# NTTDATA - DIGITAL ARCHITECTURE - ENGENIEER
# Create: Marcos Cianci - mlopesci@emeal.nttdata.com
# Date: Sex 11 Mar 2022
# PROJECT AWS FIS - FAULT INJECTION SERVICES


variable "aws_region" {

  description = "The aws region to deploy"
  type        = string
  default     = "us-east-1"
}

variable "target_ec2" {

  description = ""
  type        = list(string)
  default     = []
}

variable "alarm" {
    
  description = ""
  type        = string
}

variable "role_arn" {

  description = ""
  type        = string
}
