# 🎯 AZURE DEPLOYMENT - QUICK START

## ✅ What's Ready

All files have been created and configured for Azure deployment:

1. ✅ `app.py` - Modified to use Azure PORT
2. ✅ `requirements.txt` - All dependencies listed
3. ✅ `runtime.txt` - Python 3.11 specified
4. ✅ `startup.txt` - Gunicorn command
5. ✅ `.deployment` - Azure build config
6. ✅ `.gitignore` - Excludes sensitive files
7. ✅ `.env.example` - Environment variables template

## 🚀 3-Step Quick Deploy

### STEP 1: Push to GitHub (2 minutes)

```powershell
cd c:\xampp\htdocs\ai-main\python-agents

git add .
git commit -m "Deploy to Azure"
git push origin main
```

### STEP 2: Configure Azure (5 minutes)

Go to: https://portal.azure.com → agentic-careerai → Configuration

**Add these Application Settings:**
- `DB_HOST` = your MySQL host
- `DB_USER` = your MySQL username
- `DB_PASSWORD` = your MySQL password
- `DB_NAME` = career_agent_db
- `LLM_API_KEY` = your OpenRouter API key
- `WEBSITES_PORT` = 8000
- `SCM_DO_BUILD_DURING_DEPLOYMENT` = true

**Set Startup Command (General Settings):**
```
gunicorn --bind=0.0.0.0:8000 --timeout 600 --workers 2 app:app
```

**Click SAVE** (app will restart)

### STEP 3: Connect GitHub (3 minutes)

Deployment Center → Source: GitHub → Select your repo → Branch: main → SAVE

Azure will auto-deploy!

## ✅ Test It Works

Visit: https://agentic-careerai.azurewebsites.net/health

Expected: `{"status": "healthy"}`

## 📚 Full Documentation

- **STEP_BY_STEP_GUIDE.md** - Complete instructions with screenshots
- **AZURE_CHECKLIST.md** - Verification checklist
- **README_AZURE.md** - Detailed documentation
- **DEPLOYMENT_FLOWCHART.md** - Visual guide

## 🧪 Test Your Deployment

Run the test script:

```powershell
python test_azure_deployment.py
```

This tests all major endpoints and confirms everything works!

## 🔧 Troubleshooting

**App not starting?**
→ Check Log Stream (Monitoring → Log stream)

**Database errors?**
→ Verify DB credentials in Application Settings

**Module not found?**
→ Check Deployment Center logs for build errors

**API errors?**
→ Verify LLM_API_KEY is set correctly

## 📞 Need Help?

1. Check **Log Stream** first
2. Review **AZURE_CHECKLIST.md**
3. See **STEP_BY_STEP_GUIDE.md**

## 🎉 You're Ready!

Your Python agents are configured for Azure. Just follow the 3 steps above!

---

**Next Steps After Deployment:**
1. Test all endpoints
2. Update frontend to use Azure URL
3. Configure custom domain (optional)
4. Enable Application Insights monitoring
5. Set up auto-scaling if needed

**Your Azure URL:**
https://agentic-careerai.azurewebsites.net

---

Made with ❤️ for Azure deployment
