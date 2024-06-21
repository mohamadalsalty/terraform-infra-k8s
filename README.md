## Requirements

No requirements.

## Providers

No providers.

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_gcs"></a> [gcs](#module\_gcs) | ./gcs | n/a |
| <a name="module_gke"></a> [gke](#module\_gke) | ./gke | n/a |
| <a name="module_network"></a> [network](#module\_network) | ./network | n/a |

## Resources

No resources.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_bucket_name"></a> [bucket\_name](#input\_bucket\_name) | The name of the bucket | `string` | n/a | yes |
| <a name="input_k8s_cluster_name"></a> [k8s\_cluster\_name](#input\_k8s\_cluster\_name) | The gke cluster name | `string` | n/a | yes |
| <a name="input_project_name"></a> [project\_name](#input\_project\_name) | The project name | `string` | n/a | yes |
| <a name="input_region"></a> [region](#input\_region) | The region | `string` | n/a | yes |
| <a name="input_subnet_node_name"></a> [subnet\_node\_name](#input\_subnet\_node\_name) | The node subnet name | `string` | n/a | yes |
| <a name="input_subnet_pods_name"></a> [subnet\_pods\_name](#input\_subnet\_pods\_name) | The pods subnet name | `string` | n/a | yes |
| <a name="input_subnet_services_name"></a> [subnet\_services\_name](#input\_subnet\_services\_name) | The services subnet name | `string` | n/a | yes |
| <a name="input_vpc_name"></a> [vpc\_name](#input\_vpc\_name) | The VPC name | `string` | n/a | yes |

## Outputs

No outputs.
