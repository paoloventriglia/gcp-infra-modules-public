# terraform-google-bigquery

This module allows you to create opinionated Google Cloud Platform BigQuery datasets and tables.
This will allow the user to programmatically create an empty table schema inside of a dataset, ready for loading.
Additional user accounts and permissions are necessary to begin querying the newly created table(s).

## Compatibility

This module is meant for use with Terraform 0.12. If you haven't
[upgraded](https://www.terraform.io/upgrade-guides/0-12.html) and need a Terraform 0.11.x-compatible version of this module,
the last released version intended for Terraform 0.11.x is
[1.0.0](https://registry.terraform.io/modules/terraform-google-modules/bigquery/google/1.0.0).

## Upgrading

The current version is 2.X. The following guide is available to assist with upgrades:

- [1.0 -> 2.0](./docs/upgrading_to_bigquery_v2.0.md)
- [0.1 -> 1.0](./docs/upgrading_to_bigquery_v1.0.md)

## Usage

Basic usage of this module is as follows:

```hcl
module "bigquery" {
  source  = "terraform-google-modules/bigquery/google"
  version = "~> 2.0"

  dataset_id        = "foo"
  dataset_name      = "foo"
  description       = "some description"
  project_id        = "<PROJECT ID>"
  location          = "US"
  time_partitioning = "DAY"
  tables = [
    {
      table_id = "foo",
      schema   = "<PATH TO THE SCHEMA JSON FILE>",
      labels = {
        env      = "dev"
        billable = "true"
      },
    },
    {
      table_id = "bar",
      schema   = "<PATH TO THE SCHEMA JSON FILE>",
      labels = {
        env      = "devops"
        billable = "true"
      },
    }
  ]
  dataset_labels = {
    env      = "dev"
    billable = "true"
  }
}
```

Functional examples are included in the
[examples](./examples/) directory.

## Features
This module provisions a dataset and a table with an associated JSON schema.

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| dataset\_id | Unique ID for the dataset being provisioned | string | n/a | yes |
| dataset\_labels | Key value pairs in a map for dataset labels | map(string) | n/a | yes |
| dataset\_name | Friendly name for the dataset being provisioned | string | n/a | yes |
| description | Dataset description | string | n/a | yes |
| expiration | TTL of tables using the dataset in MS | string | `"null"` | no |
| location | The regional location for the dataset only US and EU are allowed in module | string | `"US"` | no |
| project\_id | Project where the dataset and table are created | string | n/a | yes |
| tables | A list of objects which include table_id, schema, and labels. | object | `<list>` | no |
| time\_partitioning | Configures time-based partitioning for this table | string | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| dataset\_id | Unique id for the dataset being provisioned |
| dataset\_labels | Key value pairs in a map for dataset labels |
| dataset\_name | Friendly name for the dataset being provisioned |
| dataset\_project | Project where the dataset and table are created |
| table\_id | Unique id for the table being provisioned |
| table\_labels | Key value pairs in a map for table labels |
| table\_name | Friendly name for the table being provisioned |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

## Requirements

These sections describe requirements for using this module.

### Software

The following dependencies must be available:

- [Terraform][terraform] v0.12
- [Terraform Provider for GCP][terraform-provider-gcp] plugin v2.5

### Service Account

A service account with the following roles must be used to provision
the resources of this module:

- BigQuery Data Owner: `roles/bigquery.dataOwner`

The [Project Factory module][project-factory-module] and the
[IAM module][iam-module] may be used in combination to provision a
service account with the necessary roles applied.

#### Script Helper
A helper script for configuring a Service Account is located at (./helpers/setup-sa.sh).

### APIs

A project with the following APIs enabled must be used to host the
resources of this module:

- BigQuery JSON API: `bigquery-json.googleapis.com`

The [Project Factory module][project-factory-module] can be used to
provision a project with the necessary APIs enabled.

## Contributing

Refer to the [contribution guidelines](./CONTRIBUTING.md) for
information on contributing to this module.

[iam-module]: https://registry.terraform.io/modules/terraform-google-modules/iam/google
[project-factory-module]: https://registry.terraform.io/modules/terraform-google-modules/project-factory/google
[terraform-provider-gcp]: https://www.terraform.io/docs/providers/google/index.html
[terraform]: https://www.terraform.io/downloads.html
