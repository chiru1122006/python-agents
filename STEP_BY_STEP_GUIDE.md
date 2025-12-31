# 🎯 Complete Azure Hosting Guide - Step by Step

## What We Just Did

I've modified your Python agents code to work perfectly with Azure App Service. Here's what changed:

### ✅ Files Created/Modified:

1. **`app.py`** - Updated to read PORT from Azure environment
2. **`startup.txt`** - Gunicorn startup command for Azure
3. **`.deployment`** - Tells Azure to build during deployment
4. **`runtime.txt`** - Specifies Python 3.11
5. **`.gitignore`** - Prevents sensitive files from being pushed
6. **`.env.example`** - Documents required environment variables
7. **`README_AZURE.md`** - Full deployment documentation
8. **`AZURE_CHECKLIST.md`** - Step-by-step checklist
9. **`deploy.ps1`** - Quick deployment script

---

## 🚀 DEPLOYMENT STEPS - FOLLOW THESE EXACTLY

### STEP 1: Push Code to GitHub (5 minutes)

Open PowerShell in the `python-agents` folder:

```powershell
cd c:\xampp\htdocs\ai-main\python-agents

# If not already initialized
git init
git remote add origin https://github.com/YOUR-USERNAME/YOUR-REPO-NAME.git

# Add and commit
git add .
git commit -m "Prepare for Azure deployment"

# Push to GitHub
git push -u origin main
```

**OR** use the quick script:
```powershell
.\deploy.ps1
```

---

### STEP 2: Configure Azure Environment Variables (10 minutes)

1. **Go to Azure Portal**: https://portal.azure.com
2. **Find Your App**: Search for "agentic-careerai"
3. **Go to Configuration** → Application Settings
4. **Click "New application setting"** for each:

| Name | Value | Notes |
|------|-------|-------|
| `DB_HOST` | Your MySQL host | Could be localhost or remote |
| `DB_USER` | Your MySQL username | e.g., root |
| `DB_PASSWORD` | Your MySQL password | Keep secure! |
| `DB_NAME` | `career_agent_db` | Your database name |
| `LLM_API_KEY` | Your OpenRouter API key | Get from openrouter.ai |
| `LLM_BASE_URL` | `https://openrouter.ai/api/v1` | Leave as is |
| `LLM_MODEL` | `nvidia/nemotron-3-nano-30b-a3b:free` | Free model |
| `EMBEDDING_MODEL` | `all-MiniLM-L6-v2` | Leave as is |
| `WEBSITES_PORT` | `8000` | Azure uses this |
| `SCM_DO_BUILD_DURING_DEPLOYMENT` | `true` | Enables build |

5. **Click "Save"** at the top
6. **Click "Continue"** when prompted to restart

---

### STEP 3: Set Startup Command (2 minutes)

Still in **Configuration**:

1. Go to **General Settings** tab
2. Find **Startup Command**
3. Enter:
   ```
   gunicorn --bind=0.0.0.0:8000 --timeout 600 --workers 2 app:app
   ```
4. **Save**

---

### STEP 4: Configure GitHub Deployment (5 minutes)

1. In your Azure App, go to **Deployment Center**
2. Select **Source**: GitHub
3. Sign in to GitHub if prompted
4. Select:
   - **Organization**: Your GitHub username
   - **Repository**: Your repo name
   - **Branch**: main
5. **Save**

Azure will now:
- Pull code from GitHub
- Install dependencies
- Start your app

---

### STEP 5: Setup Database Access (10 minutes)

#### Option A: Use Azure Database for MySQL

1. Create **Azure Database for MySQL Flexible Server**
2. Set firewall rules to allow Azure services
3. Import your database schema
4. Update `DB_HOST` in App Settings

#### Option B: Use External Database

1. Make sure your MySQL server allows connections from Azure
2. Add Azure IP to firewall whitelist
3. Use external host in `DB_HOST` setting

#### Import Database:

```sql
-- Connect to your MySQL and run:
SOURCE c:/xampp/htdocs/ai-main/database/schema.sql;
SOURCE c:/xampp/htdocs/ai-main/database/migration_v2.sql;
-- ... run all migration files
```

---

### STEP 6: Test Deployment (5 minutes)

1. **Wait for deployment** (check Deployment Center logs)
2. **Open URL**: https://agentic-careerai.azurewebsites.net/health
3. **Expected Response**:
   ```json
   {
     "status": "healthy",
     "service": "Career Agent Service",
     "version": "1.0.0"
   }
   ```

4. **Check Logs**:
   - Go to **Monitoring** → **Log stream**
   - Look for: "Starting Career Agent Service on port 8000"

---

## 🔧 Common Issues & Solutions

### ❌ "Application Error" on website

**Solution:**
1. Check **Log Stream** for specific error
2. Verify all environment variables are set
3. Make sure startup command is correct
4. Check if dependencies installed correctly

### ❌ Database connection failed

**Solution:**
1. Test connection: 
   ```sql
   mysql -h YOUR_HOST -u YOUR_USER -p
   ```
2. Check firewall allows Azure IPs
3. Verify DB credentials in App Settings
4. Make sure database name is correct

### ❌ Module not found errors

**Solution:**
1. Check `requirements.txt` has all dependencies
2. In Deployment Center, click "Redeploy"
3. Watch build logs for failures
4. Ensure `runtime.txt` has `python-3.11`

### ❌ LLM API errors

**Solution:**
1. Verify `LLM_API_KEY` is correct
2. Test API key at openrouter.ai
3. Check API quota/limits
4. Try fallback model in config

---

## 📊 Monitoring Your App

### View Real-time Logs
```
Azure Portal → Your App → Monitoring → Log stream
```

### Check Deployment History
```
Azure Portal → Your App → Deployment Center → Logs
```

### Performance Metrics
```
Azure Portal → Your App → Monitoring → Metrics
```

---

## 🔄 Making Updates

After code changes:

```powershell
cd c:\xampp\htdocs\ai-main\python-agents
git add .
git commit -m "Your update description"
git push origin main
```

Azure automatically redeploys! (2-5 minutes)

---

## 🎯 Testing Your API

### Health Check
```bash
curl https://agentic-careerai.azurewebsites.net/health
```

### Full Analysis
```bash
curl -X POST https://agentic-careerai.azurewebsites.net/api/agent/analyze \
  -H "Content-Type: application/json" \
  -d '{"user_id": 1}'
```

### Chat
```bash
curl -X POST https://agentic-careerai.azurewebsites.net/api/agent/chat \
  -H "Content-Type: application/json" \
  -d '{"user_id": 1, "message": "Hello"}'
```

---

## 🌐 Connect Frontend to Azure

Update your frontend API URL to:
```
https://agentic-careerai.azurewebsites.net
```

---

## 📞 Need Help?

1. **Check Log Stream first** - Most issues show there
2. **Review AZURE_CHECKLIST.md** - Step-by-step verification
3. **See README_AZURE.md** - Detailed documentation
4. **Azure Support** - portal.azure.com

---

## ✅ Success Checklist

- [ ] Code pushed to GitHub
- [ ] All environment variables configured in Azure
- [ ] Startup command set
- [ ] GitHub deployment connected
- [ ] Database accessible from Azure
- [ ] Health endpoint returns 200 OK
- [ ] No errors in Log Stream
- [ ] Test API call succeeds

---

## 🎉 You're Done!

Your Python agents are now hosted on Azure at:
**https://agentic-careerai.azurewebsites.net**

Any push to GitHub main branch will automatically redeploy!

---

## 💡 Pro Tips

1. **Enable Always On** (Configuration → General Settings) - Prevents cold starts
2. **Scale Up** if needed (App Service Plan → Scale up)
3. **Custom Domain** (Custom domains) - Use your own URL
4. **SSL Certificate** - Free with Azure
5. **Application Insights** - Monitor performance and errors

---

**Happy Coding! 🚀**
