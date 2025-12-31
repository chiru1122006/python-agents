# Deployment Guide - Career Copilot Application

## Current Setup
- **Frontend**: Deployed on Vercel at `https://frontend-career-copilot.vercel.app`
- **Backend**: Deployed on Hostinger at `https://new.svcr.dev`

---

## 🚨 Issue: 404 Error on Login

### Root Cause
The frontend was trying to connect to `/api` (relative path) instead of the full backend URL `https://new.svcr.dev/api`.

### Solution Applied
1. Created `.env.production` file with correct API URLs
2. Updated CORS configuration in PHP backend
3. Need to redeploy frontend with environment variables

---

## 📋 Step-by-Step Fix

### 1. Update Vercel Environment Variables

Go to your Vercel dashboard:
1. Navigate to your project: `frontend-career-copilot`
2. Go to **Settings** → **Environment Variables**
3. Add the following variables:

```
Variable Name: VITE_API_URL
Value: https://new.svcr.dev/api
Environment: Production

Variable Name: VITE_PYTHON_API_URL
Value: https://new.svcr.dev
Environment: Production
```

### 2. Re-upload PHP Backend to Hostinger

The `config/database.php` file has been updated to allow your Vercel domain. Make sure to upload the updated file to Hostinger.

**Files to upload:**
- `php-backend/config/database.php` (✅ Updated with CORS)
- All other PHP backend files

**Important Hostinger Setup:**
1. Ensure the PHP files are in the `public_html` or appropriate directory
2. The entry point should be `index.php`
3. Make sure `.htaccess` is configured for proper routing (see below)

### 3. Create .htaccess for PHP Backend

Create this file in your PHP backend root on Hostinger:

```apache
RewriteEngine On
RewriteBase /

# Handle API routes
RewriteCond %{REQUEST_FILENAME} !-f
RewriteCond %{REQUEST_FILENAME} !-d
RewriteRule ^api/(.*)$ index.php [QSA,L]

# Handle all other routes
RewriteCond %{REQUEST_FILENAME} !-f
RewriteCond %{REQUEST_FILENAME} !-d
RewriteRule ^(.*)$ index.php [QSA,L]

# Enable CORS
Header always set Access-Control-Allow-Origin "*"
Header always set Access-Control-Allow-Methods "GET, POST, PUT, DELETE, OPTIONS"
Header always set Access-Control-Allow-Headers "Content-Type, Authorization"
Header always set Access-Control-Max-Age "86400"
```

### 4. Redeploy Frontend on Vercel

After adding the environment variables:

**Option A: Automatic Redeploy**
1. Go to Vercel dashboard → Deployments
2. Click on the latest deployment
3. Click "Redeploy" button

**Option B: Push to Git (if connected)**
1. Commit the `.env.production` file (optional)
2. Push to your repository
3. Vercel will auto-deploy

**Option C: Manual Deploy**
```bash
cd frontend
npm run build
vercel --prod
```

---

## 🔧 Backend Configuration on Hostinger

### Directory Structure on Hostinger
```
public_html/
├── api/
│   └── .htaccess (redirect to index.php)
├── index.php (main entry point)
├── config/
│   └── database.php
├── controllers/
├── core/
├── services/
└── .htaccess (routing rules)
```

### Database Configuration

Make sure your database is set up on Hostinger with environment variables or update `config/database.php`:

```php
return [
    'host' => 'your-hostinger-db-host',
    'database' => 'your-database-name',
    'username' => 'your-database-user',
    'password' => 'your-database-password',
    'charset' => 'utf8mb4',
    
    // Important: Update this if you deploy Python agents separately
    'agent_service_url' => 'http://localhost:5000', // or your Python service URL
    
    'jwt_secret' => 'your-secure-jwt-secret-key',
    'jwt_expiry' => 86400 * 7,
    
    'allowed_origins' => [
        'https://frontend-career-copilot.vercel.app',
        'https://new.svcr.dev'
    ]
];
```

---

## 🐍 Python Agents Setup (Optional)

If you're using the Python agents for AI features:

### Option 1: Deploy on same Hostinger server
1. Use SSH to access your server
2. Install Python 3.8+
3. Set up virtual environment
4. Install requirements: `pip install -r requirements.txt`
5. Run with: `python app.py`
6. Use a process manager like `supervisor` or `systemd`

### Option 2: Deploy on separate service (Railway, Render, etc.)
1. Deploy Python agents to a Python hosting service
2. Update `VITE_PYTHON_API_URL` to point to that service
3. Update `agent_service_url` in PHP backend config

---

## ✅ Testing After Deployment

### 1. Test Backend API
```bash
# Health check
curl https://new.svcr.dev/api/health

# Should return:
# {"status":"healthy","service":"Career Agent API",...}
```

### 2. Test Frontend Connection
1. Open `https://frontend-career-copilot.vercel.app`
2. Open browser DevTools (F12) → Network tab
3. Try to login
4. Check if requests go to `https://new.svcr.dev/api/auth/login`
5. Should NOT see 404 errors

### 3. Common Issues

**Issue**: Still getting 404
- **Solution**: Clear browser cache, hard refresh (Ctrl+Shift+R)
- Verify environment variables in Vercel dashboard
- Check Vercel build logs

**Issue**: CORS errors
- **Solution**: Verify `config/database.php` has your Vercel URL
- Check `.htaccess` CORS headers
- Ensure PHP backend is properly reloaded

**Issue**: Database connection failed
- **Solution**: Verify database credentials in Hostinger
- Check if database user has proper permissions
- Import the schema from `database/schema.sql`

---

## 📝 Environment Variables Summary

### Frontend (Vercel)
```env
VITE_API_URL=https://new.svcr.dev/api
VITE_PYTHON_API_URL=https://new.svcr.dev
```

### Backend (Hostinger - Optional .env)
```env
DB_HOST=your-db-host
DB_NAME=your-db-name
DB_USER=your-db-user
DB_PASSWORD=your-db-password
JWT_SECRET=your-secret-key
AGENT_SERVICE_URL=http://localhost:5000
```

---

## 🎯 Quick Checklist

- [ ] Environment variables added to Vercel
- [ ] Frontend redeployed on Vercel
- [ ] Updated `config/database.php` uploaded to Hostinger
- [ ] `.htaccess` file created on Hostinger
- [ ] Database imported on Hostinger
- [ ] Test login functionality
- [ ] Check browser console for errors
- [ ] Verify API requests go to correct URL

---

## 🆘 Need Help?

If you're still experiencing issues:

1. **Check Vercel Deployment Logs**
   - Go to Vercel dashboard → Your project → Deployments
   - Click on latest deployment → View Function Logs

2. **Check PHP Error Logs on Hostinger**
   - Access cPanel → Error Log
   - Look for PHP errors or database connection issues

3. **Browser Developer Tools**
   - Open DevTools (F12)
   - Network tab → Check API request URLs
   - Console tab → Check for JavaScript errors

4. **Test API Endpoints Directly**
   ```bash
   curl -X POST https://new.svcr.dev/api/auth/login \
     -H "Content-Type: application/json" \
     -d '{"email":"test@example.com","password":"password"}'
   ```

---

## 📚 Additional Resources

- [Vercel Environment Variables Documentation](https://vercel.com/docs/concepts/projects/environment-variables)
- [Hostinger PHP Deployment Guide](https://www.hostinger.com/tutorials/how-to-deploy-php-application)
- [Vite Environment Variables](https://vitejs.dev/guide/env-and-mode.html)

