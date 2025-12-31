# Emergency Fix: Clean Repository Structure
# This moves Python files to root and removes non-Python code from git

Write-Host "`n===== FIXING REPOSITORY STRUCTURE =====" -ForegroundColor Cyan

# 1. Reset current messy state
Write-Host "`n1. Resetting git to last commit..." -ForegroundColor Yellow
cd C:\xampp\htdocs\ai-main
git reset --hard HEAD
git clean -fd

# 2. Create clean Python-only repo in new location
Write-Host "`n2. Creating clean repo structure..." -ForegroundColor Yellow
$cleanPath = "C:\xampp\htdocs\ai-clean"
if (Test-Path $cleanPath) { Remove-Item $cleanPath -Recurse -Force }
New-Item -ItemType Directory -Path $cleanPath | Out-Null

# 3. Copy ONLY Python files to root of clean repo
Write-Host "`n3. Copying Python files to root..." -ForegroundColor Yellow
Copy-Item "C:\xampp\htdocs\ai-main\python-agents\*" -Destination $cleanPath -Recurse -Force -Exclude ".git",".github","__pycache__","*.pyc",".venv","venv"

# 4. Copy GitHub workflow
Write-Host "`n4. Setting up GitHub Actions..." -ForegroundColor Yellow
New-Item -ItemType Directory -Path "$cleanPath\.github\workflows" -Force | Out-Null
Copy-Item "C:\xampp\htdocs\ai-main\.github\workflows\deploy-python-agents.yml" -Destination "$cleanPath\.github\workflows\" -Force

# 5. Initialize git in clean location
Write-Host "`n5. Initializing clean git repository..." -ForegroundColor Yellow
cd $cleanPath
git init
git checkout -b main

# 6. Add and commit everything
Write-Host "`n6. Committing Python files at root level..." -ForegroundColor Yellow
git add .
git commit -m "Clean structure: Python files at root for Azure deployment"

# 7. Force push to GitHub (this replaces messy history)
Write-Host "`n7. Pushing to GitHub..." -ForegroundColor Yellow
Write-Host "WARNING: This will REPLACE your GitHub repo content!" -ForegroundColor Red
$confirm = Read-Host "Type 'YES' to continue"

if ($confirm -eq "YES") {
    git remote add origin https://github.com/chiru1122006/python-agents-copilot.git
    git push -f origin main
    
    Write-Host "`n✅ SUCCESS! Repository is now clean!" -ForegroundColor Green
    Write-Host "`nStructure:" -ForegroundColor Cyan
    git ls-files | Select-Object -First 30
    
    Write-Host "`n📍 Clean repo location: $cleanPath" -ForegroundColor Yellow
    Write-Host "📍 Original (messy) location: C:\xampp\htdocs\ai-main" -ForegroundColor Yellow
} else {
    Write-Host "`n❌ Cancelled. No changes pushed." -ForegroundColor Red
}
