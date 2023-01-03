# variable "domain_hosted_zone" {
#   default = "alexdevs.link"
# }
variable "Domain_name" {
  default = "alexdevs.link"
}
variable "target_dns_name" {
  type        = string
  default = "2020430182.us-east-1.elb.amazonaws.com"
  description = "DNS name of ELB"
}
variable "target_zone_id" {
  type        = string
  default = "0880e05c-8a25-4816-bddb-da236478dad9"
  description = "ID of ELB"
}
variable "evaluate_target_health" {
  type        = bool
  default     = false
  description = "Set to true if you want Route 53 to determine whether to respond to DNS queries"
}