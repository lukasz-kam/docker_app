output "app_domain_name" {
  description = "The domain name that routes to the python app."
  value       = module.cloudfront.cf_record_name
}