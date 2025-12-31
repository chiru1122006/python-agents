# 🔐 How to Deploy Environment Variables to Azure

## ⚠️ **NEVER Upload .env File to GitHub or Azure**

Your `.env` file contains sensitive data like API keys and passwords. Instead, use **Azure Application Settings**.

---

## 📋 **Your Current .env Variables**

Based on your `.env` file, you need to configure these in Azure:

```
DB_HOST=localhost                               ← ⚠️ CHANGE THIS!
DB_USER=root
DB_PASSWORD=                                    ← ⚠️ SET IF NEEDED
DB_NAME=career_agent_db
LLM_API_KEY=sk-or-v1-5be3f96e...               ← ⚠️ SENSITIVE!
LLM_BASE_URL=https://openrouter.ai/api/v1
LLM_MODEL=nvidia/nemotron-3-nano-30b-a3b:free
EMBEDDING_MODEL=all-MiniLM-L6-v2
```

---

## 🚀 **Method 1: Azure Portal (Recommended - Easy)**

### Step-by-Step Instructions:

1. **Go to Azure Portal**
   - Visit: https://portal.azure.com
   - Sign in with your Azure account

2. **Find Your App Service**
   - Search for "agentic-careerai"
   - Click on your App Service

3. **Open Configuration**
   - Left menu → **Settings** → **Configuration**
   - Click **Application settings** tab

4. **Add Each Variable**
   
   Click "**+ New application setting**" for each:

   | Name | Value | Notes |
   |------|-------|-------|
   | `DB_HOST` | Your MySQL host | ⚠️ NOT localhost! Use actual host |
   | `DB_USER` | `root` | Or your MySQL username |
   | `DB_PASSWORD` | Your password | Leave blank if no password |
   | `DB_NAME` | `career_agent_db` | Your database name |
   | `LLM_API_KEY` | `sk-or-v1-5be3f96e...` | Your full OpenRouter key |
   | `LLM_BASE_URL` | `https://openrouter.ai/api/v1` | API endpoint |
   | `LLM_MODEL` | `nvidia/nemotron-3-nano-30b-a3b:free` | Model name |
   | `EMBEDDING_MODEL` | `all-MiniLM-L6-v2` | Embedding model |
   | `WEBSITES_PORT` | `8000` | ✨ Azure-specific |
   | `SCM_DO_BUILD_DURING_DEPLOYMENT` | `true` | ✨ Azure-specific |

5. **Save Settings**
   - Click **Save** at the top
   - Click **Continue** to restart app
   - Wait 30-60 seconds for restart

6. **Verify**
   - Go to **Monitoring** → **Log stream**
   - Look for successful startup messages

---

## 🖥️ **Method 2: PowerShell Helper Script**

I've created a script to help you:

```powershell
cd c:\xampp\htdocs\ai-main\python-agents
.\configure_azure_env.ps1
```

This script will:
- ✅ Read your `.env` file
- ✅ Show you exactly what to add in Azure Portal
- ✅ Mask sensitive values for security
- ✅ Provide Azure CLI commands (if you want)

---

## ⚡ **Method 3: Azure CLI (Advanced)**

If you have Azure CLI installed:

### Install Azure CLI (if needed):
```powershell
winget install Microsoft.AzureCLI
```

### Login:
```powershell
az login
```

### Set Variables:
```powershell
$resourceGroup = "your-resource-group-name"
$appName = "agentic-careerai"

# Database settings
az webapp config appsettings set --resource-group $resourceGroup --name $appName --settings DB_HOST="your-mysql-host"
az webapp config appsettings set --resource-group $resourceGroup --name $appName --settings DB_USER="root"
az webapp config appsettings set --resource-group $resourceGroup --name $appName --settings DB_PASSWORD="your-password"
az webapp config appsettings set --resource-group $resourceGroup --name $appName --settings DB_NAME="career_agent_db"

# LLM settings
az webapp config appsettings set --resource-group $resourceGroup --name $appName --settings LLM_API_KEY="sk-or-v1-5be3f96e..."
az webapp config appsettings set --resource-group $resourceGroup --name $appName --settings LLM_BASE_URL="https://openrouter.ai/api/v1"
az webapp config appsettings set --resource-group $resourceGroup --name $appName --settings LLM_MODEL="nvidia/nemotron-3-nano-30b-a3b:free"

# Embedding
az webapp config appsettings set --resource-group $resourceGroup --name $appName --settings EMBEDDING_MODEL="all-MiniLM-L6-v2"

# Azure-specific
az webapp config appsettings set --resource-group $resourceGroup --name $appName --settings WEBSITES_PORT="8000"
az webapp config appsettings set --resource-group $resourceGroup --name $appName --settings SCM_DO_BUILD_DURING_DEPLOYMENT="true"
```

### Or set all at once:
```powershell
az webapp config appsettings set --resource-group $resourceGroup --name $appName --settings `
  DB_HOST="your-mysql-host" `
  DB_USER="root" `
  DB_PASSWORD="your-password" `
  DB_NAME="career_agent_db" `
  LLM_API_KEY="sk-or-v1-5be3f96e..." `
  LLM_BASE_URL="https://openrouter.ai/api/v1" `
  LLM_MODEL="nvidia/nemotron-3-nano-30b-a3b:free" `
  EMBEDDING_MODEL="all-MiniLM-L6-v2" `
  WEBSITES_PORT="8000" `
  SCM_DO_BUILD_DURING_DEPLOYMENT="true"
```

---

## ⚠️ **IMPORTANT: Database Host**

Your current `.env` has `DB_HOST=localhost`, which **WON'T WORK** on Azure.

### Option A: Azure Database for MySQL
```
DB_HOST=your-server.mysql.database.azure.com
DB_USER=your-admin@your-server
DB_PASSWORD=your-password
```

### Option B: External MySQL Server
```
DB_HOST=your-domain.com
DB_USER=your-username
DB_PASSWORD=your-password
```

### Option C: Connection String (if using)
```
DB_HOST=mysql://user:password@host:3306/database
```

---

## 🔍 **Verify Environment Variables in Azure**

### Via Portal:
1. Configuration → Application settings
2. You should see all your variables listed
3. Values are hidden (click "Show value" to verify)

### Via Azure CLI:
```powershell
az webapp config appsettings list --resource-group $resourceGroup --name $appName
```

---

## 🧪 **Test After Configuration**

### 1. Check Health Endpoint:
```
https://agentic-careerai.azurewebsites.net/health
```

### 2. Check Logs:
Azure Portal → Monitoring → Log stream

Look for:
```
Starting Career Agent Service on port 8000
```

### 3. Run Test Script:
```powershell
python test_azure_deployment.py
```

---

## 🔒 **Security Best Practices**

### ✅ DO:
- ✅ Use Azure Application Settings for secrets
- ✅ Keep `.env` in `.gitignore`
- ✅ Use Azure Key Vault for extra security (optional)
- ✅ Rotate API keys regularly
- ✅ Use different credentials for dev/prod

### ❌ DON'T:
- ❌ Commit `.env` to Git
- ❌ Share `.env` file publicly
- ❌ Hardcode secrets in code
- ❌ Use same passwords everywhere
- ❌ Store secrets in plain text files on server

---

## 🔄 **Updating Environment Variables**

### If you need to change a value later:

1. **Portal**: Configuration → Application settings → Edit
2. **CLI**: Run the `az webapp config appsettings set` command again
3. **Always**: Click "Save" and restart the app

The app automatically reads the new values on restart.

---

## 📝 **Environment Variables Checklist**

Use this checklist when configuring:

```
Configuration Added?
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
[ ] DB_HOST           (⚠️ NOT localhost!)
[ ] DB_USER
[ ] DB_PASSWORD       (if required)
[ ] DB_NAME
[ ] LLM_API_KEY       (from OpenRouter)
[ ] LLM_BASE_URL
[ ] LLM_MODEL
[ ] EMBEDDING_MODEL
[ ] WEBSITES_PORT=8000
[ ] SCM_DO_BUILD_DURING_DEPLOYMENT=true
[ ] Clicked "Save"
[ ] App restarted
[ ] Tested health endpoint
[ ] Checked logs for errors
```

---

## 🆘 **Troubleshooting**

### Issue: "Environment variable not found"
**Solution**: Check spelling, make sure you clicked "Save"

### Issue: Database connection failed
**Solution**: Verify DB_HOST is correct, not localhost

### Issue: LLM API errors
**Solution**: Verify LLM_API_KEY is complete and valid

### Issue: App not starting
**Solution**: Check Log stream for specific error messages

---

## 📞 **Need Help?**

1. Run: `.\configure_azure_env.ps1` to see your current values
2. Check: Azure Portal → Log stream for errors
3. Verify: All checkboxes above are checked
4. Review: STEP_BY_STEP_GUIDE.md for detailed instructions

---

**Remember**: Never commit `.env` to Git! Always use Azure Application Settings! 🔐
