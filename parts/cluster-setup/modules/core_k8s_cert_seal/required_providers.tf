terraform {
  required_version = ">= 1.8.0"

  required_providers {
    sealedsecret = {
      source  = "jifwin/sealedsecret"
      version = ">=1.1.16"
    }
  }
}