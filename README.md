# GCP Alerts

## What does this do?

This creates log based alerts in GCP. You can create a log based filter to alert when a certain log condition is met and have it communicate to a PagerDuty alert channel.

## How to provision this module?

To create the module it is required to set values for the following variables:
    * alerts
    * project
    * enabled
    * pd\_service\_key

### Example of How to Set up the Module
```hcl
module "alerts" {
  source = "github.com/dapperlabs-platform/terraform-gcp-alerts?ref=[VERSION]"

  alerts         = local.alerts           // This is a local variable that defines the alerts
  project        = var.project            // The name of the GCP project where these alerts will be provisioned
  enabled        = false                  // This is recommended when initializing an alert as it will not trigger a real PagerDuty event.
  pd_service_key = var.pd_service_key     // The Integration Key for the PagerDuty service you wish to alert
}
```

### Example of Alert definition
```hcl
locals {
  alerts = {
    // Someone tries to destroy a key
    "Key Deleted" = {
      "filter" = "protoPayload.authorizationInfo.permission=\"cloudkms.cryptoKeyVersions.destroy\""
      "label_extractors" = {
        "Email"       = "protoPayload.authenticationInfo.principalEmail"
        "Key_Version" = "protoPayload.resourceName"
      }
    }
  }
}
```

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_google"></a> [google](#requirement\_google) | ~> 4.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_google"></a> [google](#provider\_google) | ~> 4.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [google_monitoring_alert_policy.alert_policy](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/monitoring_alert_policy) | resource |
| [google_monitoring_notification_channel.pagerduty](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/monitoring_notification_channel) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_alerts"></a> [alerts](#input\_alerts) | A map object representing all the alerts you wish to create. | <pre>map(object({<br>    filter           = string<br>    label_extractors = map(string)<br>  }))</pre> | n/a | yes |
| <a name="input_combiner"></a> [combiner](#input\_combiner) | How to combine the results of multiple conditions to determine if an incident should be opened. Possible values are AND, OR, and AND\_WITH\_MATCHING\_RESOURCE | `string` | `"OR"` | no |
| <a name="input_enabled"></a> [enabled](#input\_enabled) | If set to true, the alert is enabled. If set to false, it is disabled | `bool` | n/a | yes |
| <a name="input_pd_service_key"></a> [pd\_service\_key](#input\_pd\_service\_key) | The Integration Key for the PagerDuty service you wish to alert. | `string` | n/a | yes |
| <a name="input_project"></a> [project](#input\_project) | The GCP project where you want the resources to be built in | `string` | n/a | yes |

## Outputs

No outputs.
