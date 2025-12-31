# ✅ Azure Deployment Checklist

## Before Deployment

### ✅ Local Files Ready
- [ ] `app.py` updated with PORT environment variable
- [ ] `requirements.txt` exists with all dependencies
- [ ] `runtime.txt` specifies Python 3.11
- [ ] `startup.txt` has gunicorn command
- [ ] `.deployment` file created
- [ ] `.gitignore` configured
- [ ] `.env.example` documented

### ✅ GitHub Repository
- [ ] Code pushed to GitHub
- [ ] Repository is public or Azure has access
- [ ] Branch is 'main' or 'master'

### ✅ Azure Configuration
- [ ] App Service created (agentic-careerai)
- [ ] Runtime: Python 3.11
- [ ] Platform: Linux
- [ ] GitHub connected in Deployment Center

## Azure Configuration Settings

### 📝 Application Settings (Environment Variables)

Go to: Azure Portal → Your App → Configuration → Application Settings

Add these variables:

```
DB_HOST = [Your MySQL host]
DB_USER = [Your MySQL username]
DB_PASSWORD = [Your MySQL password]
DB_NAME = career_agent_db
LLM_API_KEY = [Your OpenRouter API key]
LLM_BASE_URL = https://openrouter.ai/api/v1
LLM_MODEL = nvidia/nemotron-3-nano-30b-a3b:free
EMBEDDING_MODEL = all-MiniLM-L6-v2
WEBSITES_PORT = 8000
SCM_DO_BUILD_DURING_DEPLOYMENT = true
```

- [ ] All environment variables added
- [ ] Click "Save" after adding
- [ ] Restart app after saving

### ⚙️ General Settings

Go to: Configuration → General Settings

**Startup Command:**
```
gunicorn --bind=0.0.0.0:8000 --timeout 600 --workers 2 app:app
```

- [ ] Startup command set
- [ ] Stack: Python 3.11
- [ ] Click "Save"

### 🗄️ Database Setup

- [ ] MySQL database accessible from Azure
- [ ] Firewall allows Azure IP addresses
- [ ] Database schema migrated
- [ ] Test connection works

### 🔄 Deployment

Go to: Deployment Center

- [ ] Source: GitHub
- [ ] Repository selected
- [ ] Branch: main
- [ ] Build provider: App Service Build Service
- [ ] Save configuration

## After Deployment

### ✅ Testing

1. **Health Check**
   - [ ] Visit: `https://agentic-careerai.azurewebsites.net/health`
   - [ ] Response: `{"status": "healthy"}`

2. **API Test**
   - [ ] Test basic endpoint works
   - [ ] Check logs for errors

3. **Database Connection**
   - [ ] Test endpoint that uses database
   - [ ] Verify data is retrieved correctly

### 🔍 Monitoring

- [ ] Check Log Stream for startup messages
- [ ] Monitor for errors
- [ ] Test all major endpoints

## 🚨 Troubleshooting

### App Not Starting?
1. Check Log Stream (Monitoring → Log stream)
2. Verify startup command is correct
3. Check all environment variables are set
4. Look for Python/module errors in logs

### Database Errors?
1. Test DB connection from Azure Cloud Shell
2. Verify firewall rules
3. Check DB credentials in Application Settings
4. Review connection string format

### Build Failures?
1. Check Deployment Center logs
2. Verify requirements.txt has all dependencies
3. Check for syntax errors in Python files
4. Ensure runtime.txt specifies correct version

## 📊 Quick Commands

### View Logs (Azure CLI)
```bash
az webapp log tail --name agentic-careerai --resource-group [your-resource-group]
```

### Restart App
```bash
az webapp restart --name agentic-careerai --resource-group [your-resource-group]
```

### SSH into Container (Advanced)
```bash
az webapp ssh --name agentic-careerai --resource-group [your-resource-group]
```

## 🎯 Success Criteria

Your deployment is successful when:
- ✅ Health endpoint returns 200 OK
- ✅ No errors in log stream
- ✅ Database connection works
- ✅ API endpoints respond correctly
- ✅ LLM API calls work (if configured)

## 📞 Next Steps After Success

1. Test all major features
2. Update frontend to point to Azure URL
3. Configure custom domain (optional)
4. Set up monitoring and alerts
5. Configure scaling rules
6. Set up CI/CD for automatic deployments
