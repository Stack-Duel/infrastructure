# infrastructure

Stack Duel Infrastructure

## Layout

```
terraform/
  modules/
    app-platform/   Shared module: resource group(s), Container App (Linux
                     container, websockets work natively), Azure SQL
                     Database (serverless, Always Free limit), storage
                     account, static web app client, Log Analytics + App
                     Insights, subscription budget, Clerk auth resources
                     (redirect URLs, allowlist, JWT template, Svix).
  environments/
    scrum/           Non-prod/dev environment. Container App scaled to
                      zero by default, Azure SQL serverless on the Always
                      Free limit.
```

Everything in the `app-platform` module targets Azure's Always Free tier
(Container Apps consumption grant, Azure SQL serverless free limit, Static
Web Apps Free plan, Blob Storage). There is no 12-month-free or trial-credit
resource anywhere in this config, so it runs the same way on a Pay-As-You-Go
subscription.

## Setup

To run this repository you need to first run `az login`.

Create a `secret.tfvars` file in the environment directory you're working in
and fill in secret values (see that environment's `variables.tf` for the
full list). `*.tfvars` is gitignored — never commit one.

### Scrum

```bash
cd terraform/environments/scrum
terraform init
terraform plan -var-file="secret.tfvars"
terraform apply -var-file="secret.tfvars"
```

## Notes

- The container app's `image` is set to a placeholder quickstart image and
  then ignored (`lifecycle.ignore_changes`) — real deploys update the
  running image via CI (`az containerapp update`), not via Terraform.
- SignalR runs self-hosted inside the API container, not via Azure SignalR
  Service — keep `container_max_replicas = 1` until a Redis/SignalR Service
  backplane is added, since a self-hosted hub can't broadcast across
  replicas on its own.
- The SQL database is enrolled in Azure's Always Free limit
  (`useFreeLimit = true`, `freeLimitExhaustionBehavior = "AutoPause"`) via
  an `azapi_update_resource` patch, since the azurerm provider (checked up
  to 4.81.0) doesn't expose those two properties itself. The behavior is
  set to `AutoPause`, not `BillForUsage` — if the monthly free vCore-second
  allowance is exhausted the database pauses instead of silently billing.
  Only one free database is allowed per subscription per region, so don't
  reuse `enable_sql = true` for a second environment in the same region.
- Clerk resources come from the unofficial `buildwithdeck/clerk` provider
  (not published by Clerk itself — audit it before relying on it for prod).
  `clerk_redirect_url` entries point at the **Next.js** static web app
  (`/sso-callback`), since that's where the browser lands after OAuth —
  your .NET API is never involved in that flow. `clerk_svix_webhook` only
  turns on the Svix integration; it can't create the actual endpoint, so
  after `apply`, open the Clerk Dashboard's Webhooks page once and add an
  endpoint using the `clerk_webhook_endpoint_url` output — that one *does*
  point at the .NET container app, and your API needs a route there
  (`POST /webhooks/clerk`) that verifies the Svix signature.
- `clerk_allowlist_identifiers` is empty by default (open sign-ups). Add
  your own email(s) there to lock scrum down to invite-only while testing.
