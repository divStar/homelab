/**
 * # Metrics server setup
 *
 * This module installs what's required for Talos to provide a metrics server.
 */
data "http" "kubelet_serving_cert_approver" {
  url = "https://raw.githubusercontent.com/alex1989hu/kubelet-serving-cert-approver/main/deploy/standalone-install.yaml"
}

resource "kubectl_manifest" "kubelet_serving_cert_approver" {
  yaml_body = data.http.kubelet_serving_cert_approver.response_body
  
  wait = true
}

data "http" "metrics_server" {
  url = "https://github.com/kubernetes-sigs/metrics-server/releases/latest/download/components.yaml"
}

resource "kubectl_manifest" "metrics_server" {
  depends_on = [kubectl_manifest.kubelet_serving_cert_approver]
  yaml_body = data.http.metrics_server.response_body

  wait = true
}