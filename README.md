# Terraform AWS Package module

This module creates an S3 object based on local source provided in the configuration. You can specify the list of files on which to look for changes or exclude from build. Currently only zip output is supported. Keep in mind that you need to have permissions to create a zip package in provided output directory.

## Example

```terraform
module "package" {
  source = "github.com/Mich0232/terraform-aws-package.git"

  deployment_bucket_id     = aws_s3_bucket.deployment_bucket.id
  deployment_bucket_prefix = "myApp"
  source_dir               = "../src"
  output_dir               = "../outputs"

  hash_sources = [
    "*.json",
    "templates/*.html",
    "**/*.py",
  ]

  excluded_paths = [
    "node_modules",
    "**/__pycache__",
    "venv/"
  ]
}
```

## Provisioned Resources
- S3 Object

## Input Variables

| Name | Description |
| --- | --- |
| `deployment_bucket_id` | ID of S3 bucket in which to store the object. |
| `deployment_bucket_prefix` | Custom S3 bucket prefix, used for Key creation (Optional) |
| `output_dir` | Local output dir. Zip file will be created there. |
| `source_dir` | Path to source directory. |
| `hash_sources` | List of paths with hash sources patterns. |
| `source_hash` | Hash value of source files. |
| `excluded_paths` | List of paths that should be excluded (As patterns). |

## Outputs

| Name | Description |
| --- | --- |
| `s3_key` | S3 object key. |
| `output_base64sha256` | Zip archive hash. Can be used to detect changes in a source directory. |
| `source_hash` | Calculated hash of sources. |
| `hash_files_paths` | List of files used as a hash source (valid only if `source_hash` was not provided in the input) |