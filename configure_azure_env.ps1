# =====================================================
# Azure Environment Variables Configuration Script
# =====================================================
# This script helps you configure all environment variables
# from your .env file into Azure App Service
#
# USAGE:
#   .\configure_azure_env.ps1
# =====================================================

Write-Host "╔════════════════════════════════════════════════════════╗" -ForegroundColor Cyan
Write-Host "║   Azure Environment Variables Configuration Helper    ║" -ForegroundColor Cyan
Write-Host "╚════════════════════════════════════════════════════════╝" -ForegroundColor Cyan
Write-Host ""

# Read .env file
$envFile = ".\.env"
if (-Not (Test-Path $envFile)) {
    Write-Host "❌ .env file not found!" -ForegroundColor Red
    Write-Host "Please make sure you're in the python-agents directory" -ForegroundColor Yellow
    exit 1
}

Write-Host "📖 Reading your .env file..." -ForegroundColor Green
Write-Host ""

# Parse .env file
$envVars = @{}
Get-Content $envFile | ForEach-Object {
    $line = $_.Trim()
    # Skip comments and empty lines
    if ($line -and -not $line.StartsWith("#")) {
        $parts = $line -split "=", 2
        if ($parts.Count -eq 2) {
            $key = $parts[0].Trim()
            $value = $parts[1].Trim().Trim('"')
            $envVars[$key] = $value
        }
    }
}

Write-Host "╔════════════════════════════════════════════════════════╗" -ForegroundColor Yellow
Write-Host "║         AZURE APPLICATION SETTINGS TO ADD              ║" -ForegroundColor Yellow
Write-Host "╚════════════════════════════════════════════════════════╝" -ForegroundColor Yellow
Write-Host ""
Write-Host "Go to Azure Portal → agentic-careerai → Configuration → Application Settings" -ForegroundColor Cyan
Write-Host ""
Write-Host "Add these settings (copy-paste each line):" -ForegroundColor White
Write-Host "═══════════════════════════════════════════════════════" -ForegroundColor Gray
Write-Host ""

# Display variables (masking sensitive data)
$sensitiveKeys = @("PASSWORD", "API_KEY", "SECRET")

foreach ($key in $envVars.Keys) {
    $value = $envVars[$key]
    
    # Check if it's a sensitive key
    $isSensitive = $false
    foreach ($sensitive in $sensitiveKeys) {
        if ($key -like "*$sensitive*") {
            $isSensitive = $true
            break
        }
    }
    
    # Display
    if ($isSensitive -and $value.Length -gt 0) {
        $maskedValue = $value.Substring(0, [Math]::Min(8, $value.Length)) + "..." + $value.Substring([Math]::Max(0, $value.Length - 4))
        Write-Host "Name:  $key" -ForegroundColor Cyan
        Write-Host "Value: $maskedValue (⚠️ USE YOUR ACTUAL VALUE)" -ForegroundColor Yellow
    } else {
        Write-Host "Name:  $key" -ForegroundColor Cyan
        Write-Host "Value: $value" -ForegroundColor Green
    }
    Write-Host "───────────────────────────────────────────────────────" -ForegroundColor Gray
}

# Additional required Azure settings
Write-Host ""
Write-Host "╔════════════════════════════════════════════════════════╗" -ForegroundColor Magenta
Write-Host "║        ADDITIONAL AZURE-SPECIFIC SETTINGS              ║" -ForegroundColor Magenta
Write-Host "╚════════════════════════════════════════════════════════╝" -ForegroundColor Magenta
Write-Host ""

$azureSettings = @{
    "WEBSITES_PORT" = "8000"
    "SCM_DO_BUILD_DURING_DEPLOYMENT" = "true"
}

foreach ($key in $azureSettings.Keys) {
    Write-Host "Name:  $key" -ForegroundColor Cyan
    Write-Host "Value: $($azureSettings[$key])" -ForegroundColor Green
    Write-Host "───────────────────────────────────────────────────────" -ForegroundColor Gray
}

# Important notes
Write-Host ""
Write-Host "╔════════════════════════════════════════════════════════╗" -ForegroundColor Red
Write-Host "║                    IMPORTANT NOTES                     ║" -ForegroundColor Red
Write-Host "╚════════════════════════════════════════════════════════╝" -ForegroundColor Red
Write-Host ""
Write-Host "⚠️  SECURITY:" -ForegroundColor Red
Write-Host "   - Never commit .env file to GitHub" -ForegroundColor White
Write-Host "   - .gitignore already prevents this" -ForegroundColor White
Write-Host "   - Always use Azure Application Settings for secrets" -ForegroundColor White
Write-Host ""
Write-Host "🔧 DATABASE:" -ForegroundColor Yellow
Write-Host "   - DB_HOST=localhost won't work on Azure" -ForegroundColor White
Write-Host "   - Change to your actual MySQL host:" -ForegroundColor White
Write-Host "     • Azure Database for MySQL hostname" -ForegroundColor White
Write-Host "     • Or external database IP/hostname" -ForegroundColor White
Write-Host ""
Write-Host "✅ AFTER ADDING ALL SETTINGS:" -ForegroundColor Green
Write-Host "   1. Click 'Save' button at the top" -ForegroundColor White
Write-Host "   2. Click 'Continue' to restart the app" -ForegroundColor White
Write-Host "   3. Monitor 'Log stream' for startup" -ForegroundColor White
Write-Host ""

# Option to use Azure CLI
Write-Host "═══════════════════════════════════════════════════════" -ForegroundColor Gray
Write-Host ""
Write-Host "💡 WANT TO USE AZURE CLI INSTEAD?" -ForegroundColor Cyan
Write-Host ""
Write-Host "If you have Azure CLI installed, you can set all variables at once:" -ForegroundColor White
Write-Host ""

$resourceGroup = Read-Host "Enter your Resource Group name (or press Enter to skip)"
if ($resourceGroup) {
    $appName = "agentic-careerai"
    
    Write-Host ""
    Write-Host "Copy and run these commands in PowerShell:" -ForegroundColor Yellow
    Write-Host ""
    
    foreach ($key in $envVars.Keys) {
        $value = $envVars[$key]
        Write-Host "az webapp config appsettings set --resource-group $resourceGroup --name $appName --settings $key=`"$value`"" -ForegroundColor Gray
    }
    
    foreach ($key in $azureSettings.Keys) {
        $value = $azureSettings[$key]
        Write-Host "az webapp config appsettings set --resource-group $resourceGroup --name $appName --settings $key=`"$value`"" -ForegroundColor Gray
    }
    
    Write-Host ""
    Write-Host "⚠️  Remember to update DB_HOST before running!" -ForegroundColor Red
}

Write-Host ""
Write-Host "════════════════════════════════════════════════════════" -ForegroundColor Green
Write-Host "Configuration helper completed!" -ForegroundColor Green
Write-Host "════════════════════════════════════════════════════════" -ForegroundColor Green
Write-Host ""
