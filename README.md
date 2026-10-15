# KumbaBiz — Cameroon Business Manager

A mobile-first, English/French business manager for small businesses in Cameroon. It uses FCFA (XAF) and is designed as an installable Progressive Web App.

## What works in this version

- Sales entry with multiple products, stock validation, partial payments, and customer balances
- Automatic stock deduction when sales are recorded; stock is restored if a sale is deleted
- Product catalog with cost/selling prices, SKU, categories, low-stock thresholds, and restocking
- Customer records with WhatsApp reminder links for balances due (the owner reviews and sends the message)
- Printable sales receipts with business details and payment breakdown
- English/French interface, sales and inventory reports, CSV export, JSON backup and restore
- Responsive layout, offline app shell, and local persistence in the browser

## Publish with GitHub Pages

1. In the repository, open **Settings → Pages**.
2. Under **Build and deployment**, choose **Deploy from a branch**.
3. Select the `main` branch and `/ (root)`, then save.
4. Wait for GitHub Pages to finish deploying. The published URL will be shown in Settings → Pages.

The included workflow also deploys the root folder to GitHub Pages when enabled in the repository settings.

## Important data limitation

This is a functional single-device MVP, not a multi-user cloud accounting service. Business records are stored in that browser's local storage. They are not synchronized between devices and are not automatically uploaded or backed up. Users should export backups and protect access to shared devices. Never store payment PINs, card details, or account passwords in the app.

For a commercial multi-device product, add a secure backend with authentication, access controls, database backups, audit logging, and tested privacy protections before storing customer data in the cloud. Real automated WhatsApp messages and mobile-money payment processing require appropriate official provider integrations and customer consent; this app only opens a prefilled reminder for the user to review and send.

## Development

No build step or third-party JavaScript package is required. Open `index.html` through a local static server or publish the repository with GitHub Pages. The service worker requires HTTPS or localhost.
