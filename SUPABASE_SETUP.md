# Supabase Database Setup for Vercel

## Current Database URL

Your current DATABASE_URL in Vercel:
```
postgresql://postgres:Zaizai111720@db.xmaelpfzipdfegkgahto.supabase.co:5432/postgres
```

## Important: Add SSL Parameter

Supabase requires SSL connections for security. You need to update your DATABASE_URL in Vercel to include SSL parameters.

### Updated DATABASE_URL (Recommended)

Update your `DATABASE_URL` in Vercel to:

```
postgresql://postgres:Zaizai111720@db.xmaelpfzipdfegkgahto.supabase.co:5432/postgres?sslmode=require
```

### How to Update in Vercel

1. **Go to Vercel Dashboard**
   - Navigate to: https://vercel.com/shopifydevguy1-ops/shopify-section-app-final/settings/environment-variables

2. **Find DATABASE_URL**
   - Look for the `DATABASE_URL` variable
   - Click on it to edit

3. **Update the Value**
   - Change from:
     ```
     postgresql://postgres:Zaizai111720@db.xmaelpfzipdfegkgahto.supabase.co:5432/postgres
     ```
   - To:
     ```
     postgresql://postgres:Zaizai111720@db.xmaelpfzipdfegkgahto.supabase.co:5432/postgres?sslmode=require
     ```

4. **Save and Redeploy**
   - Click "Save" after updating
   - Go to Deployments tab
   - Click "Redeploy" on the latest deployment
   - Or push a new commit to trigger automatic deployment

## Alternative SSL Modes

If `sslmode=require` doesn't work, try:

- **Prefer SSL** (will use SSL if available):
  ```
  postgresql://postgres:Zaizai111720@db.xmaelpfzipdfegkgahto.supabase.co:5432/postgres?sslmode=prefer
  ```

- **No SSL** (not recommended for production, but useful for testing):
  ```
  postgresql://postgres:Zaizai111720@db.xmaelpfzipdfegkgahto.supabase.co:5432/postgres?sslmode=disable
  ```

## Verify Connection

After updating, check your Vercel deployment logs:

1. Go to Vercel Dashboard → Your Project → Logs
2. Look for database connection errors
3. If you see SSL-related errors, try a different `sslmode` value

## Supabase Connection Pooling (Optional)

For better performance with Supabase, you can use connection pooling:

1. **Get Pooled Connection String from Supabase**
   - Go to Supabase Dashboard → Settings → Database
   - Look for "Connection Pooling" section
   - Use the "Transaction" mode connection string
   - It will look like: `postgresql://postgres.xxx:5432/postgres`

2. **Update DATABASE_URL** with the pooled connection string + SSL:
   ```
   postgresql://postgres.xxx:5432/postgres?sslmode=require
   ```

## Troubleshooting

### Connection Refused
- Verify the hostname is correct: `db.xmaelpfzipdfegkgahto.supabase.co`
- Check if Supabase project is active (not paused)
- Verify password is correct

### SSL Errors
- Ensure `?sslmode=require` is added to the connection string
- Try `sslmode=prefer` if `require` doesn't work
- Check Supabase dashboard for any SSL requirements

### Authentication Failed
- Verify username is `postgres` (default Supabase user)
- Verify password is correct: `Zaizai111720`
- Check if database name is `postgres` (default Supabase database)

## Next Steps

1. ✅ Update DATABASE_URL in Vercel with SSL parameter
2. ✅ Redeploy your application
3. ✅ Check Vercel logs for connection success
4. ✅ Test your application functionality
5. ✅ Run Prisma migrations if needed: `npx prisma migrate deploy`

## Running Migrations

After setting up the database connection, you may need to run Prisma migrations:

```bash
# In Vercel, you can run this via Vercel CLI or add it to your build script
npx prisma migrate deploy
```

Or add to your `package.json` build script:
```json
{
  "scripts": {
    "build": "prisma generate && prisma migrate deploy && next build"
  }
}
```

