data "terraform_remote_state" "lambda" {
  backend = "s3"
  config = {
    bucket  = "{{ bucket }}"
    key     = "{{ lookups['lambda_statefile'] }}"
    profile = "{{ profile }}"
    region  = "{{ region }}"
  }
}