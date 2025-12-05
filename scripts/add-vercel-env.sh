#!/bin/bash

# Script to add environment variables to Vercel
# Usage: ./scripts/add-vercel-env.sh

PROJECT_NAME="shopify-section-generator-live"

echo "Adding environment variables to Vercel project: $PROJECT_NAME"
echo "=========================================="

# Database
echo "postgresql://azwywnto_kram:Zaizai111720@localhost:5432/azwywnto_shopify_section_generator" | vercel env add DATABASE_URL production --scope=$PROJECT_NAME
echo "pk_test_cmVsYXhlZC1nb2xkZmlzaC0yNy5jbGVyay5hY2NvdW50cy5kZXYk" | vercel env add NEXT_PUBLIC_CLERK_PUBLISHABLE_KEY production --scope=$PROJECT_NAME
echo "sk_test_8jfNwx6FLQH9bpGEg3sbqNfHvWz9h15mu98FZ47sR2" | vercel env add CLERK_SECRET_KEY production --scope=$PROJECT_NAME
echo "/sign-in" | vercel env add NEXT_PUBLIC_CLERK_SIGN_IN_URL production --scope=$PROJECT_NAME
echo "/sign-in" | vercel env add NEXT_PUBLIC_CLERK_SIGN_UP_URL production --scope=$PROJECT_NAME
echo "/dashboard" | vercel env add NEXT_PUBLIC_CLERK_AFTER_SIGN_IN_URL production --scope=$PROJECT_NAME
echo "/dashboard" | vercel env add NEXT_PUBLIC_CLERK_AFTER_SIGN_UP_URL production --scope=$PROJECT_NAME
echo "AIzaSyDxTRoK2kSc9e6yrJAIi3Cslx9jfcAlfEo" | vercel env add AI_API_KEY production --scope=$PROJECT_NAME
echo "https://generativelanguage.googleapis.com/v1beta/models/gemini-2.0-flash-exp:generateContent" | vercel env add AI_API_URL production --scope=$PROJECT_NAME
echo "gemini-2.0-flash-exp" | vercel env add AI_MODEL production --scope=$PROJECT_NAME
echo "sk_live_YOUR_PAYMONGO_SECRET_KEY_HERE" | vercel env add PAYMONGO_SECRET_KEY production --scope=$PROJECT_NAME
echo "120000" | vercel env add PAYMONGO_PRO_AMOUNT production --scope=$PROJECT_NAME
echo "whsk_gqDLHr89fWqXk1WokSp6bbew" | vercel env add PAYMONGO_WEBHOOK_SECRET production --scope=$PROJECT_NAME
echo "https://shopifysectiongen.com/" | vercel env add NEXT_PUBLIC_APP_URL production --scope=$PROJECT_NAME
echo "3000" | vercel env add PORT production --scope=$PROJECT_NAME
echo "production" | vercel env add NODE_ENV production --scope=$PROJECT_NAME

echo ""
echo "=========================================="
echo "Done! All environment variables added."
echo ""
echo "Note: DATABASE_URL uses localhost which won't work on Vercel."
echo "You'll need to update it with a remote database URL."

