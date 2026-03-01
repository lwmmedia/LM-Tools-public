# =====================================================
# Script PowerShell d'exemple
# Description: Liste les processus et leur utilisation mémoire
# =====================================================

Write-Host "========================================" -ForegroundColor Cyan
Write-Host "   Top 10 Processus par Utilisation Mémoire" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""

Get-Process | 
    Sort-Object -Property WorkingSet -Descending | 
    Select-Object -First 10 Name, 
    @{Name="Memoire (MB)"; Expression={[math]::Round($_.WorkingSet / 1MB, 2)}}, 
    CPU, Id |
    Format-Table -AutoSize

Write-Host ""
Write-Host "Appuyez sur une touche pour continuer..." -ForegroundColor Yellow
$null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
