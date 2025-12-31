# 🎯 QUICK REFERENCE: Deploy .env to Azure

## 🚫 **DON'T Upload .env File!**

The `.env` file is already in `.gitignore` - it will NOT be pushed to GitHub (this is good!).

---

## ✅ **DO: Configure in Azure Portal**

### 📍 **WHERE TO GO:**
```
https://portal.azure.com
→ agentic-careerai
→ Configuration
→ Application settings
```

---

## 📋 **WHAT TO ADD:**

Click "**+ New application setting**" for each:

### **Database Settings:**
```
Name: DB_HOST
Value: [YOUR_MYSQL_HOST]  ⚠️ NOT localhost! Use actual host

Name: DB_USER
Value: root

Name: DB_PASSWORD
Value: [YOUR_PASSWORD]  (leave blank if no password)

Name: DB_NAME
Value: career_agent_db
```

### **LLM API Settings:**
```
Name: LLM_API_KEY
Value: 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

Name: LLM_BASE_URL
Value: https://openrouter.ai/api/v1

Name: LLM_MODEL
Value: nvidia/nemotron-3-nano-30b-a3b:free
```

### **Other Settings:**
```
Name: EMBEDDING_MODEL
Value: all-MiniLM-L6-v2

Name: WEBSITES_PORT
Value: 8000

Name: SCM_DO_BUILD_DURING_DEPLOYMENT
Value: true
```

---

## 💾 **SAVE:**
1. Click "**Save**" at top
2. Click "**Continue**" to restart
3. Wait 30-60 seconds

---

## ✅ **TEST:**
Visit: `https://agentic-careerai.azurewebsites.net/health`

Expected: `{"status": "healthy"}`

---

## 🆘 **NEED HELP?**

Run this script to see your values:
```powershell
cd c:\xampp\htdocs\ai-main\python-agents
.\configure_azure_env.ps1
```

Or read: `ENV_DEPLOYMENT_GUIDE.md` for full details

---

## ⚠️ **CRITICAL:**
- ❌ **Never** commit `.env` to Git
- ✅ `.gitignore` already blocks it
- ✅ Use Azure Portal for secrets
- ⚠️ Change `DB_HOST` from `localhost` to actual host!

---

**That's it! Your secrets stay secure, Azure gets the config.** 🔐
