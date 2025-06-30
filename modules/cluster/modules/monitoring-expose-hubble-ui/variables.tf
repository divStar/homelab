variable "ca_issuer" {
  description = "CA certificate issuer (for Certificate resource managed by cert-manager)"
  type        = string
}

variable "service_host" {
  description = "Host to expose the hubble UI on, e.g. hubble.my.domain"
  type        = string
  default     = "hubble.my.world"
  nullable    = false
}