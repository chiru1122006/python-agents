# Azure Deployment Guide - Python Agents

## 📋 Prerequisites
- Azure Account
- GitHub Repository connected to Azure App Service
- Python 3.11
- MySQL Database (Azure Database for MySQL or external)

## 🚀 Quick Deployment Steps

### 1. Push Code to GitHub

```bash
cd c:\xampp\htdocs\ai-main\python-agents
git add .
git commit -m "Prepare for Azure deployment"
git push origin main
```

### 2. Configure Azure App Service

Go to your Azure Portal (https://agentic-careerai.azurewebsites.net):

#### A. **Application Settings** (Environment Variables)
Add these in Configuration → Application Settings:

```
DB_HOST=your_mysql_host
DB_USER=your_mysql_username
DB_PASSWORD=your_mysql_password
DB_NAME=career_agent_db
LLM_API_KEY=your_openrouter_api_key
LLM_BASE_URL=https://openrouter.ai/api/v1
LLM_MODEL=nvidia/nemotron-3-nano-30b-a3b:free
EMBEDDING_MODEL=all-MiniLM-L6-v2
SERVICE_PORT=8000
DEBUG=False
SCM_DO_BUILD_DURING_DEPLOYMENT=true
WEBSITES_PORT=8000
```

#### B. **Startup Command**
In Configuration → General Settings → Startup Command:
```
gunicorn --bind=0.0.0.0:8000 --timeout 600 --workers 2 app:app
```

#### C. **Stack Settings**
- Runtime Stack: Python 3.11
- Platform: Linux

### 3. Database Setup

#### Option A: Azure Database for MySQL
1. Create Azure Database for MySQL Flexible Server
2. Configure firewall rules to allow Azure services
3. Run migrations:
   - Upload `database/schema.sql` and migrations
   - Connect via MySQL Workbench or Azure CLI

#### Option B: External MySQL (e.g., your current DB)
1. Make sure firewall allows connections from Azure IP
2. Use external DB host in environment variables

### 4. GitHub Deployment

In Azure Portal → Deployment Center:
- Source: GitHub
- Organization: Your GitHub username
- Repository: Your repo name
- Branch: main

Azure will automatically:
1. Pull code from GitHub
2. Install dependencies from `requirements.txt`
3. Start the app with the startup command

### 5. Test Deployment

Visit: `https://agentic-careerai.azurewebsites.net/health`

Expected response:
```json
{
  "status": "healthy",
  "service": "Career Agent Service",
  "version": "1.0.0"
}
```

## 🔧 Troubleshooting

### View Logs
1. Azure Portal → Your App Service
2. Monitoring → Log stream
3. Or use Azure CLI:
   ```bash
   az webapp log tail --name agentic-careerai --resource-group your-resource-group
   ```

### Common Issues

**Issue: App not starting**
- Check Application Settings are correctly set
- Verify startup command in Configuration
- Check Log Stream for errors

**Issue: Database connection failed**
- Verify DB_HOST, DB_USER, DB_PASSWORD
- Check firewall rules allow Azure IP
- Test connection using Azure Cloud Shell

**Issue: LLM API errors**
- Verify LLM_API_KEY is correct
- Check OpenRouter API status
- Review logs for specific error messages

**Issue: Module not found**
- Ensure all dependencies are in `requirements.txt`
- Check build logs in Deployment Center

## 📝 File Structure for Azure

```
python-agents/
├── app.py                 # Main Flask application
├── config.py             # Configuration (reads from env vars)
├── requirements.txt      # Python dependencies
├── runtime.txt          # Python version (3.11)
├── startup.txt          # Gunicorn startup command
├── .deployment          # Azure deployment config
├── .gitignore           # Files to ignore in git
├── .env.example         # Example environment variables
├── agents/              # Agent modules
├── services/            # Service modules
├── templates/           # HTML templates
└── README_AZURE.md      # This file
```

## 🔄 Making Updates

After code changes:

```bash
git add .
git commit -m "Your update message"
git push origin main
```

Azure will automatically redeploy (takes 2-5 minutes).

## 🌐 API Endpoints

Base URL: `https://agentic-careerai.azurewebsites.net`

- Health Check: `GET /health`
- Agent Run: `POST /api/agent/run`
- Full Analysis: `POST /api/agent/analyze`
- Resume Generate: `POST /api/resume/generate`
- Chat: `POST /api/agent/chat`

Full API documentation available in `app.py`.

## 📞 Support

For issues:
1. Check Azure Log Stream
2. Review deployment logs in Deployment Center
3. Test locally first: `gunicorn app:app`
