variable "vpc_details" {
  type = object({
    name = string
    cidr = string
  })
}