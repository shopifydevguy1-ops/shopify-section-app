# Configure Z.com Database for External Access (Vercel)

This guide will help you configure your Z.com PostgreSQL database to allow connections from Vercel.

## Current Database Information

- **Database Name**: `azwywnto_shopify_section_generator`
- **Username**: `azwywnto_kram`
- **Password**: `Zaizai111720`
- **Current Host**: `localhost` (only works locally)
- **Port**: `5432` (default PostgreSQL port)

## Step-by-Step Configuration

### Step 1: Find Your Database Server Hostname

1. **Log in to Z.com cPanel**
   - Go to your Z.com hosting control panel

2. **Navigate to Server Information**
   - Look for **"Server Information"** or **"General Information"** section in cPanel
   - Find the **"Shared IP Address"** or **"Server Hostname"**
   - This is your external database hostname (NOT localhost)
   - Common formats: `server123.z.com` or an IP address like `123.45.67.89`

3. **Alternative: Check PostgreSQL Databases Section**
   - Go to **"Databases"** → **"PostgreSQL Databases"** (if available)
   - Look for connection information that shows an external hostname

4. **If you can't find it:**
   - Contact Z.com support and ask: "What is the external hostname or IP address for my PostgreSQL database server?"

### Step 2: Enable Remote Database Access

1. **Go to Remote Database Access**
   - In cPanel, navigate to **"Databases"** → **"Remote Database Access"** or **"Remote MySQL/PostgreSQL"**

2. **Add Allowed IP Addresses**
   
   **Option A: Allow All IPs (Easier, but less secure)**
   - Add: `0.0.0.0/0` (allows connections from anywhere)
   - ⚠️ **Security Note**: This allows any IP to attempt connection. Your password still protects the database.

   **Option B: Allow Only Vercel IPs (More Secure)**
   - Vercel uses dynamic IPs, so you may need to allow a range
   - You can check Vercel's IP ranges or use `0.0.0.0/0` for simplicity
   - For production, consider using a database proxy or VPN

3. **Save the Configuration**
   - Click "Add" or "Save" to allow the IP addresses
   - Wait a few minutes for changes to propagate

### Step 3: Get External Connection Details

You need to find:
- ✅ **Database Name**: `azwywnto_shopify_section_generator` (you have this)
- ✅ **Username**: `azwywnto_kram` (you have this)
- ✅ **Password**: `Zaizai111720` (you have this)
- ❓ **External Hostname**: Need to find this (from Step 1)
- ✅ **Port**: `5432` (default, usually correct)

### Step 4: Construct External Connection String

Once you have the external hostname, your connection string will be:

```
postgresql://azwywnto_kram:Zaizai111720@EXTERNAL_HOSTNAME:5432/azwywnto_shopify_section_generator
```

Replace `EXTERNAL_HOSTNAME` with the actual hostname or IP from Step 1.

**Example:**
- If hostname is `db123.z.com`:
  ```
  postgresql://azwywnto_kram:Zaizai111720@db123.z.com:5432/azwywnto_shopify_section_generator
  ```

- If IP is `123.45.67.89`:
  ```
  postgresql://azwywnto_kram:Zaizai111720@123.45.67.89:5432/azwywnto_shopify_section_generator
  ```

### Step 5: Test the Connection (Optional but Recommended)

Before updating Vercel, test the connection locally:

```bash
# Install PostgreSQL client if needed
# macOS: brew install postgresql
# Or use a GUI tool like pgAdmin, DBeaver, or TablePlus

# Test connection
psql "postgresql://azwywnto_kram:Zaizai111720@EXTERNAL_HOSTNAME:5432/azwywnto_shopify_section_generator"
```

If the connection works, you'll see a PostgreSQL prompt. Type `\q` to quit.

### Step 6: Update DATABASE_URL in Vercel

Once you have the external connection string:

1. **Update via Vercel CLI:**
   ```bash
   echo "postgresql://azwywnto_kram:Zaizai111720@EXTERNAL_HOSTNAME:5432/azwywnto_shopify_section_generator" | vercel env rm DATABASE_URL production
   echo "postgresql://azwywnto_kram:Zaizai111720@EXTERNAL_HOSTNAME:5432/azwywnto_shopify_section_generator" | vercel env add DATABASE_URL production
   ```

2. **Or update via Vercel Dashboard:**
   - Go to: https://vercel.com/shopifydevguy1-ops/shopify-section-app-final/settings/environment-variables
   - Find `DATABASE_URL`
   - Click "Edit" or remove and re-add with the new external connection string
   - Make sure it's set for **Production** environment

### Step 7: Redeploy Your Vercel Project

After updating the DATABASE_URL:

1. Go to your Vercel project dashboard
2. Click **"Redeploy"** on the latest deployment
3. Or push a new commit to trigger automatic deployment

### Step 8: Verify Connection

After deployment, check your Vercel function logs to ensure the database connection is working:

1. Go to Vercel Dashboard → Your Project → Logs
2. Look for any database connection errors
3. Test your application to ensure it can connect to the database

## Troubleshooting

### Connection Refused Error

**Problem**: `connection refused` or `timeout`

**Solutions**:
1. Verify Remote Database Access is enabled in cPanel
2. Check that the IP `0.0.0.0/0` is added (or Vercel's IPs)
3. Verify the external hostname is correct
4. Check if Z.com requires a specific port (might not be 5432)
5. Contact Z.com support to confirm external access is enabled for your account

### Authentication Failed

**Problem**: `authentication failed` or `password authentication failed`

**Solutions**:
1. Verify the password is correct: `Zaizai111720`
2. Check if the password needs URL-encoding (special characters)
3. Try resetting the database user password in cPanel
4. Ensure the username is correct: `azwywnto_kram`

### Hostname Not Found

**Problem**: `could not resolve hostname`

**Solutions**:
1. Double-check the hostname from Step 1
2. Try using the IP address instead of hostname
3. Verify the hostname is publicly accessible (try pinging it)
4. Contact Z.com support for the correct external hostname

### Port Issues

**Problem**: Connection times out on port 5432

**Solutions**:
1. Verify the port is 5432 (check in cPanel PostgreSQL settings)
2. Some hosts use different ports for external access
3. Contact Z.com support to confirm the external port

## Security Considerations

1. **Strong Password**: Your password `Zaizai111720` should be strong. Consider changing it periodically.

2. **IP Restrictions**: While allowing `0.0.0.0/0` works, consider:
   - Using a database proxy service
   - Setting up a VPN
   - Using Vercel's IP ranges if available

3. **SSL Connection**: Some databases require SSL. If you get SSL errors, add `?sslmode=require` to your connection string:
   ```
   postgresql://azwywnto_kram:Zaizai111720@EXTERNAL_HOSTNAME:5432/azwywnto_shopify_section_generator?sslmode=require
   ```

## Alternative: Contact Z.com Support

If you're having trouble finding the external hostname or enabling remote access:

1. **Contact Z.com Support** via:
   - Support ticket in your cPanel
   - Email support
   - Live chat (if available)

2. **Ask them**:
   - "What is the external hostname or IP address for my PostgreSQL database?"
   - "How do I enable remote database access for PostgreSQL?"
   - "What port should I use for external PostgreSQL connections?"

3. **Provide them**:
   - Your database name: `azwywnto_shopify_section_generator`
   - Your username: `azwywnto_kram`
   - That you need to connect from Vercel (external service)

## Quick Checklist

- [ ] Found external hostname/IP in cPanel
- [ ] Enabled Remote Database Access in cPanel
- [ ] Added allowed IPs (0.0.0.0/0 or specific IPs)
- [ ] Constructed external connection string
- [ ] Tested connection locally (optional)
- [ ] Updated DATABASE_URL in Vercel
- [ ] Redeployed Vercel project
- [ ] Verified connection in Vercel logs
- [ ] Tested application functionality

## Next Steps

After successfully configuring external access:

1. Your Vercel deployment should now be able to connect to your Z.com database
2. All your existing data will be accessible from Vercel
3. You can continue using the same database for both Z.com hosting and Vercel

---

**Need Help?** If you get stuck, contact Z.com support with the information above, or check the Vercel logs for specific error messages.

