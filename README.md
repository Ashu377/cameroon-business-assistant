# BUEA CHOP OWNER

A bilingual English/French, mobile-first business manager for Cameroon. It uses FCFA (XAF) and works as an installable Progressive Web App.

## Working features

- Record sales with multiple products, stock validation, partial payments, and customer balances
- Automatically deduct stock on sale; restore stock if a sale is deleted
- Product catalogue with cost/selling prices, SKU, categories, low-stock alerts, and restocking
- Customer records and prefilled WhatsApp balance reminders (the owner reviews and sends)
- Printable receipts, seven-day sales view, inventory summaries, CSV export, JSON backup/restore
- Local-first mode plus optional Supabase email/password account and cloud workspace sync
- Row Level Security (RLS) restricts each cloud workspace to its signed-in owner

## Supabase setup

1. In this project, open the Supabase **SQL Editor** and run `supabase-schema.sql` once. It creates the `user_workspaces` table and owner-only RLS policies.
2. In Supabase **Authentication → URL Configuration**, set the Site URL to `https://ashu377.github.io/cameroon-business-assistant/` and add that same address to the allowed redirect URLs.
3. Publish the repository using the workflow below. Open **Account & sync** in BUEA CHOP OWNER, create/sign into an app account, then choose whether to upload local records or use an existing cloud copy.

`supabase-config.js` contains only the public publishable key, which is designed for frontend use. Do not add a Supabase `service_role` or secret key to the website or repository. RLS must remain enabled. The dashboard account and BUEA CHOP OWNER app account are separate sign-ins.

The current sync stores one JSON workspace per account. It is suitable for early testing with one person using one device at a time; simultaneous edits on multiple devices can overwrite each other. Keep JSON backups and do not treat this first cloud-sync milestone as audited accounting software.

## Publish with GitHub Pages

The repository includes a GitHub Actions workflow. GitHub Pages is configured to deploy it. Check the **Actions** tab for the deploy result; the live site is `https://ashu377.github.io/cameroon-business-assistant/`.

## Data and privacy

Signed-out records stay in that browser. When signed in, the workspace is sent to Supabase so it can sync. Passwords are managed by Supabase Auth and are never stored in the BUEA CHOP OWNER workspace. WhatsApp reminders open a prefilled message for the owner to review and send; the app does not send WhatsApp messages automatically. Never store payment PINs or bank passwords.

## Development

No build step or third-party JavaScript package is required. The browser loads Supabase JS v2 from jsDelivr; the ordinary local app remains available if the cloud library is unavailable. The service worker requires HTTPS or localhost.
