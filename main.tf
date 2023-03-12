locals {
  hash                      = var.source_hash ? var.source_hash : random_uuid.hash[0].result
  zip_filename              = var.package_type == "zip" ? "${local.hash}.zip" : "${local.hash}"
  excluded_hash_files_paths = distinct(flatten([for path in var.excluded_paths : fileset(var.source_dir, path)]))
  all_hash_files_paths      = distinct(flatten([for path in var.hash_sources : fileset(var.source_dir, path)]))
  hash_files_paths          = flatten(setsubtract(toset(local.all_hash_files_paths), toset(local.excluded_hash_files_paths)))
}

resource "random_uuid" "hash" {
  count = var.source_hash == null ? 0 : 1
  keepers = {
    for filename in local.hash_files_paths : filename => filemd5("${var.source_dir}/${filename}")
  }
}

data "archive_file" "package" {
  type        = var.package_type
  source_dir  = var.source_dir
  output_path = "${var.output_dir}/${local.zip_filename}"
  excludes    = var.excluded_paths
}

resource "aws_s3_object" "lambda_code_object" {
  bucket      = var.deployment_bucket_id
  key         = var.deployment_bucket_prefix != "" ? "${var.deployment_bucket_prefix}/${local.zip_filename}" : local.zip_filename
  source      = data.archive_file.package.output_path
  source_hash = data.archive_file.package.output_base64sha256

  depends_on = [data.archive_file.package]
}
