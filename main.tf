locals {
  zip_filename     = var.package_type == "zip" ? "${random_uuid.code_hash.result}.zip" : "${random_uuid.code_hash.result}"
  hash_files_paths = flatten(setunion([for path in var.hash_sources : fileset(var.source_dir, path)]))
}

resource "random_uuid" "code_hash" {
  keepers = {
    for filename in local.hash_files_paths : filename => filemd5("${var.source_dir}/${filename}")
  }
}

data "archive_file" "code" {
  type        = var.package_type
  source_dir  = var.source_dir
  output_path = var.output_dir
  excludes    = var.excluded_paths
}

resource "aws_s3_object" "lambda_code_object" {
  bucket      = var.deployment_bucket_id
  key         = var.deployment_bucket_prefix != "" ? "${var.deployment_bucket_prefix}/${local.zip_filename}" : local.zip_filename
  source      = var.output_dir
  source_hash = data.archive_file.code.output_base64sha256

  depends_on = [data.archive_file.code]
}
