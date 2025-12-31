# 🚨 AZURE DEPLOYMENT - QUICK FIX CHECKLIST

## ✅ What I See From Your Logs:

Your deployment is **BUILDING** - this is good! Azure is:
- ✅ Installing Python 3.11.14
- ✅ Creating virtual environment
- ⏳ About to run `pip install` from requirements.txt

## 📋 WAIT FOR BUILD TO COMPLETE

The logs you showed stopped at "Running pip install...". The build needs to complete first.

**Wait 2-5 minutes** for the deployment to finish.

---

## ⚡ AFTER BUILD COMPLETES - DO THESE 5 THINGS:

### ✅ 1. CHECK IF BUILD SUCCEEDED

**Go to:** Deployment Center → Check if deployment shows "Success (Active)"

- ✅ **If Success** → Continue to step 2
- ❌ **If Failed** → Check deployment logs for error

---

### ✅ 2. VERIFY ENVIRONMENT VARIABLES ARE SET

**Go to:** Configuration → Application Settings

**You MUST have these 11 settings:**

```
☑️ DB_HOST = [your-mysql-host] (NOT localhost!)
☑️ DB_USER = root
☑️ DB_PASSWORD = [your-password]
☑️ DB_NAME = career_agent_db
☑️ LLM_API_KEY = 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
☑️ LLM_BASE_URL = https://openrouter.ai/api/v1
☑️ LLM_MODEL = nvidia/nemotron-3-nano-30b-a3b:free
☑️ EMBEDDING_MODEL = all-MiniLM-L6-v2
☑️ WEBSITES_PORT = 8000
☑️ SCM_DO_BUILD_DURING_DEPLOYMENT = true
```

**If missing:** Add them, click "Save", click "Continue" to restart

---

### ✅ 3. SET STARTUP COMMAND

**Go to:** Configuration → General Settings → Startup Command

**Set this:**
```
gunicorn --bind=0.0.0.0:8000 --timeout 600 --workers 2 app:app
```

**Click:** Save → Continue (to restart)

---

### ✅ 4. VERIFY PYTHON STACK

**Go to:** Configuration → General Settings

**Check:**
- Stack: **Python**
- Major version: **Python 3.11**
- Platform: **Linux**

---

### ✅ 5. RESTART AND CHECK LOGS

**Go to:** Overview → Click "Restart"

**Then:** Monitoring → Log stream

**Look for:**
```
✅ Starting Career Agent Service on port 8000
✅ [gunicorn] Booting worker
```

**If you see errors:** Note them down for debugging

---

## 🧪 TEST YOUR APP

After completing all 5 steps above:

**Visit:** https://agentic-careerai.azurewebsites.net/health

**Expected:**
```json
{
  "status": "healthy",
  "service": "Career Agent Service",
  "version": "1.0.0"
}
```

---

## 🔴 IF YOU STILL SEE "APPLICATION ERROR"

### Most Common Causes:

1. **Missing Environment Variables**
   - Solution: Add all 11 variables in step 2

2. **No Startup Command**
   - Solution: Set command in step 3

3. **Database Connection Failed**
   - Solution: Change DB_HOST from "localhost" to actual host

4. **Port Mismatch**
   - Solution: Make sure WEBSITES_PORT=8000

5. **Build Failed**
   - Solution: Check Deployment Center logs for pip errors

---

## 📊 CHECK CURRENT STATUS

Run this command to check logs:

**In Azure Portal:**
```
Monitoring → Log stream
```

**Look for these patterns:**

✅ **SUCCESS:**
```
Starting Career Agent Service on port 8000
Booting worker with pid
```

❌ **ERROR - Missing Module:**
```
ModuleNotFoundError: No module named 'flask'
→ Fix: Check requirements.txt was deployed
```

❌ **ERROR - Database:**
```
Can't connect to MySQL server
→ Fix: Update DB_HOST in Application Settings
```

❌ **ERROR - Port:**
```
Address already in use
→ Fix: Set WEBSITES_PORT=8000
```

---

## 🆘 QUICK DEBUG COMMANDS

### See all your settings:
```
Configuration → Application Settings → View all
```

### Check deployment history:
```
Deployment Center → Logs
```

### View real-time logs:
```
Monitoring → Log stream
```

### Restart app:
```
Overview → Restart button
```

---

## 📞 NEED HELP?

1. **First:** Complete all 5 steps above
2. **Then:** Check Log stream for specific error
3. **If stuck:** Share the error from Log stream

---

## 🎯 MOST LIKELY FIX

Based on common issues, do this:

1. **Add all environment variables** (step 2)
2. **Set startup command** (step 3)
3. **Change DB_HOST** from localhost to actual host
4. **Save and Restart**
5. **Wait 1 minute**
6. **Test /health endpoint**

---

**Your deployment is building now. Wait for it to finish, then follow these 5 steps!** 🚀
