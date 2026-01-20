variable "project_name" {
    description = "Project name"
    type        = string
}

variable "bucket_name" {
    description = "Globally unique S3 bucket name"
    type        = string
}

variable "region" {
    description = "AWS region"
    type        = string
    default     = "ap-southeast-1"
}

variable "aws_profile" {
    description = "AWS CLI profile to use"
    type        = string
    default     = "my-user"
}
