## AWS Package module

This module creates an S3 object based on local source provided in the configuration.

You can specify the list of files on which to look for changes or exclude from build.

Currently only zip output is supported.  

Keep in mind that you need to have permissions to create a zip package in provided output directory.


### Provisioned Resources

 - S3 Object

### Input Variables

`deployment_bucket_id` - ID of S3 bucket in which to store the object.

`deployment_bucket_prefix` - Custom S3 bucket prefix, used for Key creation (Optional)

`output_dir` - local output dir. Zip file will be created there.

`source_dir` - path to source directory.

`hash_sources` - list of paths with hash sources patterns (See examples below)

`excluded_paths` - list of paths that should be excluded (As patterns, see examples below.)


### Outputs

`key` - S3 object key.

`output_base64sha256` - zip archive hash. Can be used to detect changes in a source directory.

`zip_id` - name of zip file. (Calculated hash of sources)


### Examples

```terraform
module "ms-package" {
  source = "github.com/Mich0232/aws-package.git"

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
