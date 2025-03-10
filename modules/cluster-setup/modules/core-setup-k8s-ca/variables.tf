variable "proxmox" {
  description = "Proxmox SSH connection details"
  type = object({
    host     = string
    ssh_user = string
    ssh_key  = string
  })
}

variable "proxmox_root_ca" {
  description = "Proxmox root CA certificate and key to use for the intermediate k8s certificate"
  type = object({
    pve_root_cert = string
    pve_root_key  = string
  })
  default = {
    pve_root_cert = "/etc/pve/pve-root-ca.pem"
    pve_root_key  = "/etc/pve/priv/pve-root-ca.key"
  }
  nullable = false
}

variable "k8s_ca" {
  description = "Intermediate Kubernetes CA used as ClusterIssuer"
  type = object({
    subject = object({
      common_name         = string
      organization        = string
      organizational_unit = string
      country             = string
      locality            = string
      province            = string
    })
    private_key = object({
      algorithm = string
      rsa_bits  = number
    })
    validity_period_hours = number
  })
  default = {
    subject = {
      common_name         = "Proxmox VE Kubernetes Intermediate CA"
      organization        = "PVE Cluster Manager CA"
      organizational_unit = "Kubernetes"
      country             = "DE"
      locality            = "Home Lab"
      province            = "Private Network"
    }
    private_key = {
      algorithm = "RSA"
      rsa_bits  = 4096
    }
    validity_period_hours = 78840 # 9 years
  }
  nullable = false
}

variable "secret_name" {
  description = "Name of the secret and - by extension - the sealed secret"
  type        = string
  default     = "k8s-ca-secret"
  nullable    = false
}

variable "secret_namespace" {
  description = "Namespace to deploy the secret and - by extension - the sealed secret to"
  type        = string
  nullable    = false
}