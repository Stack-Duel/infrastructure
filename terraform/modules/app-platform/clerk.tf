locals {
  clerk_redirect_urls = var.enable_clerk ? toset(concat(
    ["https://${azurerm_static_web_app.client.default_host_name}/sso-callback"],
    var.clerk_additional_redirect_urls
  )) : toset([])
}

resource "clerk_redirect_url" "this" {
  for_each = local.clerk_redirect_urls
  url      = each.value
}

resource "clerk_allowlist_identifier" "this" {
  for_each   = var.enable_clerk ? toset(var.clerk_allowlist_identifiers) : toset([])
  identifier = each.value
  notify     = true
}

resource "clerk_jwt_template" "this" {
  count    = var.enable_clerk ? 1 : 0
  name     = var.clerk_jwt_template_name
  claims   = var.clerk_jwt_template_claims
  lifetime = var.clerk_jwt_lifetime
}

# Enables the Svix integration on the Clerk instance. This provider has no
# resource for the actual endpoint (URL + event subscriptions) — after
# apply, add the webhook endpoint once by hand in the Clerk Dashboard's
# Webhooks page, pointed at the URL in the `clerk_webhook_endpoint_url`
# output. Your API must implement that route and verify the Svix signature.
resource "clerk_svix_webhook" "main" {
  count = var.enable_clerk && var.enable_clerk_svix_webhook ? 1 : 0
}
