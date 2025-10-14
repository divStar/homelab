/**
 * # Common Helm installer module
 *
 * Handles installing a Helm Chart using `helm_release`,
 * supports custom resources during pre- and post-install.
 *
 * > [!NOTE]
 * > the CRDs *have to be present* when installing custom resources.
 */
resource "kubectl_manifest" "namespace" {
  yaml_body = templatefile("${path.module}/namespace.yaml.tftpl", {
    namespace               = var.namespace
    is_privileged_namespace = var.is_privileged_namespace
  })

  wait = true
}

resource "kubectl_manifest" "pre_install" {
  depends_on = [kubectl_manifest.namespace]

  # Using `idx`, because it helps ensure the order of the YAML resources
  for_each  = { for idx, resource in var.pre_install_resources : idx => resource }
  yaml_body = each.value.yaml

  wait_for_rollout = true
  wait             = true

  dynamic "wait_for" {
    for_each = each.value.wait_for != null ? [each.value.wait_for] : []

    content {
      # Add field conditions if any
      dynamic "field" {
        for_each = wait_for.value.fields != null ? wait_for.value.fields : []
        content {
          key        = field.value.key
          value      = field.value.value
          value_type = field.value.value_type
        }
      }

      # Add status conditions if any
      dynamic "condition" {
        for_each = wait_for.value.conditions != null ? wait_for.value.conditions : []
        content {
          type   = condition.value.type
          status = condition.value.status
        }
      }
    }
  }
}

resource "helm_release" "this" {
  depends_on = [kubectl_manifest.pre_install]

  name      = var.release_name
  namespace = var.namespace
  # We are creating the namespace manually in order to make it a privileged namespace if necessary
  create_namespace = false

  chart      = var.chart_name
  repository = var.chart_repo
  version    = var.chart_version

  values = compact([var.chart_values])

  atomic          = var.is_atomic
  force_update    = true
  cleanup_on_fail = var.cleanup_on_fail
  recreate_pods   = false
  lint            = true

  timeout       = var.chart_timeout
  wait          = true
  wait_for_jobs = true
}

resource "kubectl_manifest" "post_install" {
  depends_on = [helm_release.this]

  # Using `idx`, because it helps ensure the order of the YAML resources
  for_each  = { for idx, resource in var.post_install_resources : idx => resource }
  yaml_body = each.value.yaml

  wait_for_rollout = true
  wait             = true

  dynamic "wait_for" {
    for_each = each.value.wait_for != null ? [each.value.wait_for] : []

    content {
      # Add field conditions if any
      dynamic "field" {
        for_each = wait_for.value.fields != null ? wait_for.value.fields : []
        content {
          key        = field.value.key
          value      = field.value.value
          value_type = field.value.value_type
        }
      }

      # Add status conditions if any
      dynamic "condition" {
        for_each = wait_for.value.conditions != null ? wait_for.value.conditions : []
        content {
          type   = condition.value.type
          status = condition.value.status
        }
      }
    }
  }
}