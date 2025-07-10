# Zitadel

This module installs Zitadel onto a given cluster.

> [!NOTE]
> The cluster is required to be configured in a way, that allows all resources to deploy correctly.

## Contents

<blockquote><!-- contents:start -->

- [Requirements](#requirements)
- [Providers](#providers)
- [Execution story](#execution-story)
- [Modules](#modules) _(nested and adjacent)_
  - [zitadel](#zitadel)
- [Variables](#variables)
  - [versions_yaml](#versions_yaml-optional) (*Optional*)
</blockquote><!-- contents:end -->

## Execution story

Order in which Terraform will create resources (and likely destroy them in reverse order):
```
EXECUTION_STORY_PLACE_HOLDER
```

## Modules
  
<blockquote><!-- module:"zitadel":start -->

### `zitadel`

Installs [`zitadel`](https://zitadel.com/), which is used for Authentication and Authorization of users and services.
  <table>
    <tr>
      <td>Module location</td>
      <td><code>../common/modules/helm-terraform-installer</code></td>
    </tr>
    <tr>
      <td>In file</td>
      <td><a href="./main.tf#L15"><code>main.tf#L15</code></a></td>
    </tr>
    <tr>
      <td colspan="2"><a href="../common/modules/helm-terraform-installer/README.md">README.md</a> <em>(experimental)</em></td>
    </tr>
  </table>
</blockquote><!-- module:"zitadel":end -->

## Variables
  
<blockquote><!-- variable:"versions_yaml":start -->

### `versions_yaml` (*Optional*)

Path to the `versions.yaml` file, that contains all relevant versions

<details style="border-top-color: inherit; border-top-width: 0.1em; border-top-style: solid; padding-top: 0.5em; padding-bottom: 0.5em;">
  <summary>Show more...</summary>

  **Type**:
  ```hcl
  string
  ```
  **Default**:
  ```json
  "../../versions.yaml"
  ```
  In file: <a href="./variables.tf#L1"><code>variables.tf#L1</code></a>

</details>
</blockquote><!-- variable:"versions_yaml":end -->