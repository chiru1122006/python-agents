# Azure Diagnostics - Check App Logs
# This script helps you diagnose the Application Error

Write-Host "╔════════════════════════════════════════════════════════╗" -ForegroundColor Red
Write-Host "║          AZURE APPLICATION ERROR DIAGNOSTICS           ║" -ForegroundColor Red
Write-Host "╚════════════════════════════════════════════════════════╝" -ForegroundColor Red
Write-Host ""

Write-Host "🔍 STEP 1: CHECK AZURE LOGS" -ForegroundColor Yellow
Write-Host "═══════════════════════════════════════════════════════" -ForegroundColor Gray
Write-Host ""
Write-Host "To see what's causing the error, you need to check logs:" -ForegroundColor White
Write-Host ""
Write-Host "1. Go to Azure Portal: https://portal.azure.com" -ForegroundColor Cyan
Write-Host "2. Find: agentic-careerai" -ForegroundColor Cyan
Write-Host "3. Go to: Monitoring → Log stream" -ForegroundColor Cyan
Write-Host "4. Look for ERROR messages" -ForegroundColor Cyan
Write-Host ""
Write-Host "Common errors to look for:" -ForegroundColor Yellow
Write-Host "  • 'No module named...' → Missing dependency" -ForegroundColor White
Write-Host "  • 'Connection refused' → Database issue" -ForegroundColor White
Write-Host "  • 'Unable to bind to port' → Port configuration" -ForegroundColor White
Write-Host "  • 'ModuleNotFoundError' → Python package issue" -ForegroundColor White
Write-Host ""

Write-Host "╔════════════════════════════════════════════════════════╗" -ForegroundColor Yellow
Write-Host "║              COMMON CAUSES & SOLUTIONS                 ║" -ForegroundColor Yellow
Write-Host "╚════════════════════════════════════════════════════════╝" -ForegroundColor Yellow
Write-Host ""

Write-Host "❌ CAUSE 1: Missing Environment Variables" -ForegroundColor Red
Write-Host "═══════════════════════════════════════════════════════" -ForegroundColor Gray
Write-Host "SOLUTION: Add all variables in Configuration → Application Settings" -ForegroundColor Green
Write-Host "Required:" -ForegroundColor White
Write-Host "  • DB_HOST, DB_USER, DB_PASSWORD, DB_NAME" -ForegroundColor Cyan
Write-Host "  • LLM_API_KEY, LLM_BASE_URL, LLM_MODEL" -ForegroundColor Cyan
Write-Host "  • WEBSITES_PORT=8000" -ForegroundColor Cyan
Write-Host "  • SCM_DO_BUILD_DURING_DEPLOYMENT=true" -ForegroundColor Cyan
Write-Host ""

Write-Host "❌ CAUSE 2: Startup Command Not Set" -ForegroundColor Red
Write-Host "═══════════════════════════════════════════════════════" -ForegroundColor Gray
Write-Host "SOLUTION: Set in Configuration → General Settings" -ForegroundColor Green
Write-Host "Startup Command:" -ForegroundColor White
Write-Host "  gunicorn --bind=0.0.0.0:8000 --timeout 600 --workers 2 app:app" -ForegroundColor Cyan
Write-Host ""

Write-Host "❌ CAUSE 3: Python Version Mismatch" -ForegroundColor Red
Write-Host "═══════════════════════════════════════════════════════" -ForegroundColor Gray
Write-Host "SOLUTION: Check runtime.txt and Azure settings" -ForegroundColor Green
Write-Host "  • runtime.txt should have: python-3.11" -ForegroundColor Cyan
Write-Host "  • Azure Stack: Python 3.11" -ForegroundColor Cyan
Write-Host ""

Write-Host "❌ CAUSE 4: Build Failed" -ForegroundColor Red
Write-Host "═══════════════════════════════════════════════════════" -ForegroundColor Gray
Write-Host "SOLUTION: Check Deployment Center → Logs" -ForegroundColor Green
Write-Host "  • Look for pip install errors" -ForegroundColor Cyan
Write-Host "  • Check requirements.txt syntax" -ForegroundColor Cyan
Write-Host ""

Write-Host "❌ CAUSE 5: Database Connection Failed" -ForegroundColor Red
Write-Host "═══════════════════════════════════════════════════════" -ForegroundColor Gray
Write-Host "SOLUTION: Fix DB_HOST (can't be localhost)" -ForegroundColor Green
Write-Host "  • Use actual MySQL hostname" -ForegroundColor Cyan
Write-Host "  • Check firewall allows Azure IPs" -ForegroundColor Cyan
Write-Host ""

Write-Host "╔════════════════════════════════════════════════════════╗" -ForegroundColor Cyan
Write-Host "║              QUICK FIX CHECKLIST                       ║" -ForegroundColor Cyan
Write-Host "╚════════════════════════════════════════════════════════╝" -ForegroundColor Cyan
Write-Host ""

$checklist = @(
    "[ ] All environment variables added in Application Settings",
    "[ ] WEBSITES_PORT set to 8000",
    "[ ] SCM_DO_BUILD_DURING_DEPLOYMENT set to true",
    "[ ] Startup command configured",
    "[ ] DB_HOST is NOT localhost",
    "[ ] Clicked 'Save' after configuration changes",
    "[ ] App restarted after saving",
    "[ ] Checked Deployment Center logs",
    "[ ] Checked Log stream for errors",
    "[ ] runtime.txt exists with python-3.11"
)

foreach ($item in $checklist) {
    Write-Host $item -ForegroundColor White
}

Write-Host ""
Write-Host "╔════════════════════════════════════════════════════════╗" -ForegroundColor Green
Write-Host "║              STEP-BY-STEP FIX PROCESS                  ║" -ForegroundColor Green
Write-Host "╚════════════════════════════════════════════════════════╝" -ForegroundColor Green
Write-Host ""

Write-Host "1️⃣  VERIFY CONFIGURATION" -ForegroundColor Yellow
Write-Host "   → Portal → agentic-careerai → Configuration" -ForegroundColor White
Write-Host "   → Check all Application Settings are present" -ForegroundColor White
Write-Host ""

Write-Host "2️⃣  SET STARTUP COMMAND" -ForegroundColor Yellow
Write-Host "   → Configuration → General Settings" -ForegroundColor White
Write-Host "   → Startup Command:" -ForegroundColor White
Write-Host "     gunicorn --bind=0.0.0.0:8000 --timeout 600 --workers 2 app:app" -ForegroundColor Cyan
Write-Host ""

Write-Host "3️⃣  CHECK DEPLOYMENT STATUS" -ForegroundColor Yellow
Write-Host "   → Deployment Center → Logs" -ForegroundColor White
Write-Host "   → Make sure last deployment succeeded" -ForegroundColor White
Write-Host ""

Write-Host "4️⃣  RESTART APP" -ForegroundColor Yellow
Write-Host "   → Overview → Restart button" -ForegroundColor White
Write-Host "   → Wait 1-2 minutes" -ForegroundColor White
Write-Host ""

Write-Host "5️⃣  CHECK LOGS" -ForegroundColor Yellow
Write-Host "   → Monitoring → Log stream" -ForegroundColor White
Write-Host "   → Look for startup messages or errors" -ForegroundColor White
Write-Host ""

Write-Host "╔════════════════════════════════════════════════════════╗" -ForegroundColor Magenta
Write-Host "║           NEED TO REDEPLOY FROM SCRATCH?               ║" -ForegroundColor Magenta
Write-Host "╚════════════════════════════════════════════════════════╝" -ForegroundColor Magenta
Write-Host ""

$redeploy = Read-Host "Do you want to see redeployment commands? (y/n)"

if ($redeploy -eq "y" -or $redeploy -eq "Y") {
    Write-Host ""
    Write-Host "REDEPLOY COMMANDS:" -ForegroundColor Cyan
    Write-Host "═══════════════════════════════════════════════════════" -ForegroundColor Gray
    Write-Host ""
    Write-Host "# Make sure all files are committed" -ForegroundColor Green
    Write-Host "git status" -ForegroundColor White
    Write-Host "git add ." -ForegroundColor White
    Write-Host "git commit -m `"Fix Azure deployment`"" -ForegroundColor White
    Write-Host "git push origin main" -ForegroundColor White
    Write-Host ""
    Write-Host "Then in Azure:" -ForegroundColor Green
    Write-Host "  → Deployment Center → Sync (to pull latest code)" -ForegroundColor White
    Write-Host "  → Or wait for auto-deployment" -ForegroundColor White
}

Write-Host ""
Write-Host "════════════════════════════════════════════════════════" -ForegroundColor Green
Write-Host "Next: Check Azure Portal logs and follow the steps above!" -ForegroundColor Green
Write-Host "════════════════════════════════════════════════════════" -ForegroundColor Green
Write-Host ""
