# Metrics server setup

This module installs what's required for Talos to provide a metrics server.

## Contents

<blockquote><!-- contents:start -->

- [Requirements](#requirements)
- [Providers](#providers)
- [Resources](#resources)
  - _kubectl_manifest_.[kubelet_serving_cert_approver](#kubectl_manifestkubelet_serving_cert_approver)
  - _kubectl_manifest_.[metrics_server](#kubectl_manifestmetrics_server)
- [Variables](#variables)
</blockquote><!-- contents:end -->

## Requirements
![opentofu](https://img.shields.io/badge/OpenTofu->=1.10.5-d3287d?logo=opentofu)

## Providers
  
![http](https://img.shields.io/badge/http--c1166b)
![kubectl](https://img.shields.io/badge/kubectl--eb4095)

## Resources
  
<blockquote><!-- resource:"kubectl_manifest.kubelet_serving_cert_approver":start -->

### _kubectl_manifest_.`kubelet_serving_cert_approver`
      
  <table>
    <tr>
      <td>Provider</td>
      <td><code>kubectl (alekc/kubectl)</code></td>
    </tr>
    <tr>
      <td>In file</td>
      <td><a href="./main.tf#L10"><code>main.tf#L10</code></a></td>
    </tr>
  </table>
</blockquote><!-- resource:"kubectl_manifest.kubelet_serving_cert_approver":end -->
<blockquote><!-- resource:"kubectl_manifest.metrics_server":start -->

### _kubectl_manifest_.`metrics_server`
      
  <table>
    <tr>
      <td>Provider</td>
      <td><code>kubectl (alekc/kubectl)</code></td>
    </tr>
    <tr>
      <td>In file</td>
      <td><a href="./main.tf#L19"><code>main.tf#L19</code></a></td>
    </tr>
  </table>
</blockquote><!-- resource:"kubectl_manifest.metrics_server":end -->