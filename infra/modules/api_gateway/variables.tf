variable "rest_api_id" {
  description = "The ID of the REST API"
  type        = string
}
variable "parent_id" {
  description = "The ID of the parent resource"
  type        = string
}
variable "authorizer_id" {
  description = "The ID of the authorizer"
  type        = string
}
variable "tags" {
  description = "A map of tags to assign to the resource."
  type        = map(string)
  default     = {}
}


variable "nlb_dns_name" {
  description = "The DNS name of the Application Load Balancer"
  type        = string
}

variable "nlb_arn" {
  description = "The ARN of the Network Load Balancer"
  type        = string
}
