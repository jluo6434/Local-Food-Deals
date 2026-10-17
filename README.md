# Local Food Deals — Supabase Cloud Edition

## Cost
Supabase has a Free plan suitable for initial prototyping, subject to project limits, inactivity pauses, and pricing changes. No charge is required if you remain within its free allocation. Google Maps/Places are billed separately by Google.

## Setup
1. Create a free Supabase project at https://supabase.com/dashboard.
2. Open **SQL Editor**, paste and run `supabase_setup.sql`.
3. Under **Project Settings > API** (or Connect), copy the Project URL and **publishable/anon** key.
4. Edit `supabase_config.js` with these values. Never use a service-role or secret key in browser files.
5. Under **Authentication > Providers**, enable Email sign-in. Configure Site URL and allowed redirect URLs for your hosted site or `http://localhost:8000/merchant_dashboard.html`. Email delivery limits may apply.
6. Host all files together on the same HTTPS site. For local testing, in this folder run `python3 -m http.server 8000` and visit `http://localhost:8000/merchant_dashboard.html`. Email magic links may not work reliably on `file://` pages.
7. Sign in on Merchant Studio, create/edit a restaurant and save. Open `food_map_customer.html` in another browser/device to see the published listing. Updates arrive through Realtime or on returning to the tab.

## What syncs
Merchant restaurant profile, opening hours, phone, location, menu, leftover deal configuration and prices. The customer map displays merchant-provided details. No independent verification.

## Not live yet
Bookings, orders, payment, QR redemption, masked calls, inventory deduction, Google ratings, and merchant approval are still prototypes/local-only. Do not use them for actual transactions. The current public-read policy intentionally exposes the entire profile/settings/menu JSON including phone; do not enter private business or personal information. Each owner can write only their own restaurant records (enforced by RLS). For production, separate public/private fields and implement verified ownership, secure order tables and transactional stock updates.

## Important
This package uses a browser CDN for Supabase JS and needs an internet connection. Google Maps API keys are configured separately. Existing Google Maps/Leaflet fallback functionality remains subject to provider terms and keys.
