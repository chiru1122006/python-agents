# Quick Deploy Script for Azure
# Run this in PowerShell from python-agents directory

Write-Host "🚀 Azure Deployment Script" -ForegroundColor Green
Write-Host "================================" -ForegroundColor Green
Write-Host ""

# Check if git is initialized
if (-Not (Test-Path ".git")) {
    Write-Host "❌ Git not initialized. Initializing..." -ForegroundColor Yellow
    git init
    git add .
    git commit -m "Initial commit for Azure deployment"
} else {
    Write-Host "✅ Git repository detected" -ForegroundColor Green
}

# Check current status
Write-Host ""
Write-Host "📋 Current Git Status:" -ForegroundColor Cyan
git status

Write-Host ""
$continue = Read-Host "Continue with commit and push? (y/n)"

if ($continue -eq "y" -or $continue -eq "Y") {
    # Add all files
    Write-Host ""
    Write-Host "📦 Adding files to git..." -ForegroundColor Cyan
    git add .
    
    # Commit
    $commitMsg = Read-Host "Enter commit message (or press Enter for default)"
    if ([string]::IsNullOrWhiteSpace($commitMsg)) {
        $commitMsg = "Update for Azure deployment"
    }
    
    git commit -m "$commitMsg"
    
    # Push
    Write-Host ""
    Write-Host "🚀 Pushing to GitHub..." -ForegroundColor Cyan
    Write-Host "Make sure you've set up remote: git remote add origin <your-repo-url>" -ForegroundColor Yellow
    
    $branch = Read-Host "Enter branch name (default: main)"
    if ([string]::IsNullOrWhiteSpace($branch)) {
        $branch = "main"
    }
    
    git push origin $branch
    
    Write-Host ""
    Write-Host "✅ Code pushed to GitHub!" -ForegroundColor Green
    Write-Host ""
    Write-Host "📝 Next Steps:" -ForegroundColor Yellow
    Write-Host "1. Go to Azure Portal" -ForegroundColor White
    Write-Host "2. Navigate to your App Service (agentic-careerai)" -ForegroundColor White
    Write-Host "3. Azure will automatically deploy from GitHub" -ForegroundColor White
    Write-Host "4. Check Deployment Center for build status" -ForegroundColor White
    Write-Host "5. Monitor logs in Log Stream" -ForegroundColor White
    Write-Host ""
    Write-Host "Test URL: https://agentic-careerai.azurewebsites.net/health" -ForegroundColor Cyan
} else {
    Write-Host "❌ Deployment cancelled" -ForegroundColor Red
}

Write-Host ""
Write-Host "📚 For detailed instructions, see:" -ForegroundColor Cyan
Write-Host "   - README_AZURE.md" -ForegroundColor White
Write-Host "   - AZURE_CHECKLIST.md" -ForegroundColor White
