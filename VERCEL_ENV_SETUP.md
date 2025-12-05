# Vercel Environment Variables Setup

## Quick Setup via Dashboard

1. Go to: https://vercel.com/shopifydevguy1-ops/shopify-section-app-final/settings/environment-variables

2. Add each variable below (click "Add" for each one):

### Environment Variables to Add

Copy and paste these one by one:

```
DATABASE_URL
postgresql://azwywnto_kram:Zaizai111720@localhost:5432/azwywnto_shopify_section_generator
⚠️ Note: This uses localhost - you'll need a remote database for Vercel!

NEXT_PUBLIC_CLERK_PUBLISHABLE_KEY
pk_test_cmVsYXhlZC1nb2xkZmlzaC0yNy5jbGVyay5hY2NvdW50cy5kZXYk

CLERK_SECRET_KEY
sk_test_8jfNwx6FLQH9bpGEg3sbqNfHvWz9h15mu98FZ47sR2

NEXT_PUBLIC_CLERK_SIGN_IN_URL
/sign-in

NEXT_PUBLIC_CLERK_SIGN_UP_URL
/sign-in

NEXT_PUBLIC_CLERK_AFTER_SIGN_IN_URL
/dashboard

NEXT_PUBLIC_CLERK_AFTER_SIGN_UP_URL
/dashboard

AI_API_KEY
AIzaSyDxTRoK2kSc9e6yrJAIi3Cslx9jfcAlfEo

AI_API_URL
https://generativelanguage.googleapis.com/v1beta/models/gemini-2.0-flash-exp:generateContent

AI_MODEL
gemini-2.0-flash-exp

PAYMONGO_SECRET_KEY
sk_live_YOUR_PAYMONGO_SECRET_KEY_HERE

PAYMONGO_PRO_AMOUNT
120000

PAYMONGO_WEBHOOK_SECRET
whsk_gqDLHr89fWqXk1WokSp6bbew

NEXT_PUBLIC_APP_URL
https://shopifysectiongen.com/

PORT
3000

NODE_ENV
production
```

### Important Notes:

1. **Select Environment**: Make sure to add each variable for **Production** (and optionally Preview/Development)

2. **DATABASE_URL Issue**: The current DATABASE_URL uses `localhost` which won't work on Vercel. You need to:
   - Use a remote database (Supabase, Vercel Postgres, or your Z.com database with external access)
   - Update the connection string to use the remote host

3. **After Adding Variables**: 
   - Click "Save" after each variable
   - Redeploy your project for changes to take effect

## Alternative: Using Vercel CLI

If you want to use CLI, first link the project properly. The issue is your directory name has spaces. You can:

1. Rename the directory to remove spaces, OR
2. Use the dashboard (recommended)

## Database Options for Vercel:

### Option 1: Supabase (Free Tier)
- Sign up at supabase.com
- Create a PostgreSQL database
- Get connection string
- Update DATABASE_URL in Vercel

### Option 2: Vercel Postgres
- In Vercel dashboard → Storage → Create Database → Postgres
- Vercel will auto-create POSTGRES_URL
- Update your code to use POSTGRES_URL or set DATABASE_URL=POSTGRES_URL

### Option 3: Keep Z.com Database
- Configure Z.com database to allow external connections
- Update DATABASE_URL with the external hostname/IP
- Add firewall rules if needed

