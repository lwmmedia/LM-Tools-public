#Requires -RunAsAdministrator
<#
.SYNOPSIS
    Script de maintenance sécurisé pour Windows 10 et Windows 11

.DESCRIPTION
    Ce script effectue des opérations de maintenance système pour optimiser 
    et nettoyer Windows 10 et Windows 11 en toute sécurité.
    
    Fonctionnalités :
    - Nettoyage des fichiers temporaires
    - Nettoyage du disque Windows
    - Vérification des fichiers système (SFC)
    - Réparation de l'image système (DISM)
    - Vérification de Windows Update
    - Génération de logs détaillés

.NOTES
    Auteur: LM-Tools
    Version: 1.0
    Date: 2026-01-08
    Nécessite: PowerShell 5.1+ et droits Administrateur
    Compatible: Windows 10, Windows 11

.EXAMPLE
    .\Windows-Maintenance.ps1
    Exécute le script de maintenance avec toutes les options
#>

# Configuration stricte pour la sécurité
Set-StrictMode -Version Latest
$ErrorActionPreference = "Continue"

# Variables globales
$ScriptVersion = "1.0"
$LogPath = Join-Path $env:USERPROFILE "Desktop\Windows-Maintenance-Log_$(Get-Date -Format 'yyyyMMdd_HHmmss').txt"
$StartTime = Get-Date

#region Fonctions

function Write-Log {
    <#
    .SYNOPSIS
        Écrit un message dans le fichier de log et la console
    #>
    param(
        [Parameter(Mandatory=$true)]
        [string]$Message,
        
        [Parameter(Mandatory=$false)]
        [ValidateSet('INFO', 'WARNING', 'ERROR', 'SUCCESS')]
        [string]$Level = 'INFO'
    )
    
    $timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
    $logMessage = "[$timestamp] [$Level] $Message"
    
    # Couleurs pour la console
    $color = switch ($Level) {
        'INFO'    { 'White' }
        'WARNING' { 'Yellow' }
        'ERROR'   { 'Red' }
        'SUCCESS' { 'Green' }
    }
    
    Write-Host $logMessage -ForegroundColor $color
    Add-Content -Path $LogPath -Value $logMessage -Encoding UTF8
}

function Test-AdminRights {
    <#
    .SYNOPSIS
        Vérifie si le script est exécuté avec les droits administrateur
    #>
    $currentUser = [Security.Principal.WindowsIdentity]::GetCurrent()
    $principal = New-Object Security.Principal.WindowsPrincipal($currentUser)
    return $principal.IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)
}

function Get-SystemInfo {
    <#
    .SYNOPSIS
        Récupère les informations système
    #>
    Write-Log "Collecte des informations système..." -Level INFO
    
    try {
        $os = Get-CimInstance Win32_OperatingSystem
        $computer = Get-CimInstance Win32_ComputerSystem
        
        Write-Log "Système d'exploitation: $($os.Caption) $($os.Version)" -Level INFO
        Write-Log "Architecture: $($os.OSArchitecture)" -Level INFO
        Write-Log "Nom de l'ordinateur: $($computer.Name)" -Level INFO
        Write-Log "Mémoire totale: $([math]::Round($computer.TotalPhysicalMemory/1GB, 2)) GB" -Level INFO
    }
    catch {
        Write-Log "Erreur lors de la collecte des informations système: $($_.Exception.Message)" -Level ERROR
    }
}

function Clear-TemporaryFiles {
    <#
    .SYNOPSIS
        Nettoie les fichiers temporaires en toute sécurité
    #>
    Write-Log "=== Nettoyage des fichiers temporaires ===" -Level INFO
    
    $tempPaths = @(
        $env:TEMP,
        "C:\Windows\Temp",
        "C:\Windows\Prefetch"
    )
    
    $totalFreed = 0
    
    foreach ($path in $tempPaths) {
        if (Test-Path $path) {
            try {
                Write-Log "Nettoyage de: $path" -Level INFO
                
                $beforeSize = (Get-ChildItem -Path $path -Recurse -Force -ErrorAction SilentlyContinue | 
                              Measure-Object -Property Length -Sum -ErrorAction SilentlyContinue).Sum
                
                if ($null -eq $beforeSize) { $beforeSize = 0 }
                
                Get-ChildItem -Path $path -Recurse -Force -ErrorAction SilentlyContinue | 
                    Where-Object { !$_.PSIsContainer } | 
                    Remove-Item -Force -ErrorAction SilentlyContinue
                
                $afterSize = (Get-ChildItem -Path $path -Recurse -Force -ErrorAction SilentlyContinue | 
                             Measure-Object -Property Length -Sum -ErrorAction SilentlyContinue).Sum
                
                if ($null -eq $afterSize) { $afterSize = 0 }
                
                $freed = ($beforeSize - $afterSize) / 1MB
                $totalFreed += $freed
                
                Write-Log "Espace libéré dans $path : $([math]::Round($freed, 2)) MB" -Level SUCCESS
            }
            catch {
                Write-Log "Erreur lors du nettoyage de $path : $($_.Exception.Message)" -Level WARNING
            }
        }
    }
    
    Write-Log "Espace total libéré: $([math]::Round($totalFreed, 2)) MB" -Level SUCCESS
}

function Invoke-DiskCleanup {
    <#
    .SYNOPSIS
        Exécute l'outil de nettoyage de disque Windows
    #>
    Write-Log "=== Lancement du nettoyage de disque Windows ===" -Level INFO
    
    try {
        # Configuration du nettoyage de disque
        $cleanmgrKey = "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\VolumeCaches"
        
        $itemsToClean = @(
            "Temporary Files",
            "Temporary Setup Files",
            "Downloaded Program Files",
            "Old ChkDsk Files",
            "Recycle Bin",
            "Temporary Sync Files",
            "Thumbnail Cache",
            "Windows Error Reporting Files",
            "Windows Defender"
        )
        
        foreach ($item in $itemsToClean) {
            $itemPath = Join-Path $cleanmgrKey $item
            if (Test-Path $itemPath) {
                Set-ItemProperty -Path $itemPath -Name StateFlags0001 -Value 2 -ErrorAction SilentlyContinue
            }
        }
        
        Write-Log "Exécution de cleanmgr (cela peut prendre quelques minutes)..." -Level INFO
        Start-Process -FilePath "cleanmgr.exe" -ArgumentList "/sagerun:1" -Wait -WindowStyle Hidden
        Write-Log "Nettoyage de disque terminé" -Level SUCCESS
    }
    catch {
        Write-Log "Erreur lors du nettoyage de disque: $($_.Exception.Message)" -Level ERROR
    }
}

function Invoke-SystemFileCheck {
    <#
    .SYNOPSIS
        Exécute l'outil de vérification des fichiers système (SFC)
    #>
    Write-Log "=== Vérification des fichiers système (SFC) ===" -Level INFO
    
    try {
        Write-Log "Exécution de SFC /scannow (cela peut prendre 15-30 minutes)..." -Level INFO
        $sfcOutput = & sfc /scannow 2>&1
        
        # Log the SFC output
        $sfcOutput | ForEach-Object { Write-Log $_ -Level INFO }
        
        if ($LASTEXITCODE -eq 0) {
            Write-Log "Vérification SFC terminée avec succès" -Level SUCCESS
        }
        else {
            Write-Log "SFC a détecté des problèmes (vérifiez CBS.log pour plus de détails)" -Level WARNING
        }
    }
    catch {
        Write-Log "Erreur lors de l'exécution de SFC: $($_.Exception.Message)" -Level ERROR
    }
}

function Invoke-DISMRepair {
    <#
    .SYNOPSIS
        Exécute DISM pour vérifier et réparer l'image système
    #>
    Write-Log "=== Vérification et réparation de l'image système (DISM) ===" -Level INFO
    
    try {
        Write-Log "Vérification de l'intégrité de l'image..." -Level INFO
        $dismCheckOutput = & DISM /Online /Cleanup-Image /CheckHealth 2>&1
        $dismCheckOutput | ForEach-Object { Write-Log $_ -Level INFO }
        
        Write-Log "Scan de l'état de l'image..." -Level INFO
        $dismScanOutput = & DISM /Online /Cleanup-Image /ScanHealth 2>&1
        $dismScanOutput | ForEach-Object { Write-Log $_ -Level INFO }
        
        Write-Log "Réparation de l'image (cela peut prendre du temps)..." -Level INFO
        $dismRestoreOutput = & DISM /Online /Cleanup-Image /RestoreHealth 2>&1
        $dismRestoreOutput | ForEach-Object { Write-Log $_ -Level INFO }
        
        if ($LASTEXITCODE -eq 0) {
            Write-Log "Opérations DISM terminées avec succès" -Level SUCCESS
        }
        else {
            Write-Log "DISM a rencontré des problèmes (code: $LASTEXITCODE)" -Level WARNING
        }
    }
    catch {
        Write-Log "Erreur lors de l'exécution de DISM: $($_.Exception.Message)" -Level ERROR
    }
}

function Get-DiskSpace {
    <#
    .SYNOPSIS
        Affiche l'espace disque disponible
    #>
    Write-Log "=== Espace disque ===" -Level INFO
    
    try {
        $drives = Get-PSDrive -PSProvider FileSystem | Where-Object { $_.Used -gt 0 }
        
        foreach ($drive in $drives) {
            $freeSpace = [math]::Round($drive.Free / 1GB, 2)
            $usedSpace = [math]::Round($drive.Used / 1GB, 2)
            $totalSpace = [math]::Round(($drive.Free + $drive.Used) / 1GB, 2)
            $percentFree = [math]::Round(($drive.Free / ($drive.Free + $drive.Used)) * 100, 2)
            
            Write-Log "Disque $($drive.Name): $usedSpace GB utilisés / $totalSpace GB total ($percentFree% libre)" -Level INFO
        }
    }
    catch {
        Write-Log "Erreur lors de la vérification de l'espace disque: $($_.Exception.Message)" -Level ERROR
    }
}

function Test-WindowsUpdate {
    <#
    .SYNOPSIS
        Vérifie le statut de Windows Update
    #>
    Write-Log "=== Vérification de Windows Update ===" -Level INFO
    
    try {
        $updateSession = New-Object -ComObject Microsoft.Update.Session
        $updateSearcher = $updateSession.CreateUpdateSearcher()
        
        Write-Log "Recherche de mises à jour..." -Level INFO
        $searchResult = $updateSearcher.Search("IsInstalled=0")
        
        if ($searchResult.Updates.Count -eq 0) {
            Write-Log "Aucune mise à jour en attente" -Level SUCCESS
        }
        else {
            Write-Log "Nombre de mises à jour disponibles: $($searchResult.Updates.Count)" -Level WARNING
            Write-Log "Veuillez exécuter Windows Update pour installer les mises à jour" -Level WARNING
        }
    }
    catch {
        Write-Log "Erreur lors de la vérification de Windows Update: $($_.Exception.Message)" -Level WARNING
        Write-Log "Vérifiez manuellement Windows Update dans les paramètres" -Level INFO
    }
}

function Show-MaintenanceMenu {
    <#
    .SYNOPSIS
        Affiche le menu principal et retourne le choix de l'utilisateur
    #>
    Write-Host "`n" -NoNewline
    Write-Host "╔════════════════════════════════════════════════════════════╗" -ForegroundColor Cyan
    Write-Host "║   Script de Maintenance Windows 10/11 - Version $ScriptVersion    ║" -ForegroundColor Cyan
    Write-Host "╠════════════════════════════════════════════════════════════╣" -ForegroundColor Cyan
    Write-Host "║                                                            ║" -ForegroundColor Cyan
    Write-Host "║  1. Maintenance complète (recommandé)                      ║" -ForegroundColor White
    Write-Host "║  2. Nettoyage rapide seulement                             ║" -ForegroundColor White
    Write-Host "║  3. Vérification système seulement (SFC + DISM)            ║" -ForegroundColor White
    Write-Host "║  4. Afficher les informations système                      ║" -ForegroundColor White
    Write-Host "║  5. Quitter                                                ║" -ForegroundColor White
    Write-Host "║                                                            ║" -ForegroundColor Cyan
    Write-Host "╚════════════════════════════════════════════════════════════╝" -ForegroundColor Cyan
    Write-Host "`n"
    
    $choice = Read-Host "Sélectionnez une option (1-5)"
    return $choice
}

#endregion

#region Script Principal

# Bannière de démarrage
Clear-Host
Write-Host "╔════════════════════════════════════════════════════════════╗" -ForegroundColor Green
Write-Host "║                                                            ║" -ForegroundColor Green
Write-Host "║       SCRIPT DE MAINTENANCE WINDOWS 10/11 - v$ScriptVersion         ║" -ForegroundColor Green
Write-Host "║                    LM-Tools                                ║" -ForegroundColor Green
Write-Host "║                                                            ║" -ForegroundColor Green
Write-Host "╚════════════════════════════════════════════════════════════╝" -ForegroundColor Green
Write-Host ""

# Initialisation du fichier de log
Write-Log "=== Démarrage du script de maintenance ===" -Level INFO
Write-Log "Version du script: $ScriptVersion" -Level INFO
Write-Log "Fichier de log: $LogPath" -Level INFO

# Vérification des droits administrateur
if (-not (Test-AdminRights)) {
    Write-Log "ERREUR: Ce script nécessite des droits administrateur!" -Level ERROR
    Write-Log "Veuillez exécuter PowerShell en tant qu'administrateur" -Level ERROR
    Read-Host "Appuyez sur Entrée pour quitter"
    exit 1
}

Write-Log "Droits administrateur confirmés" -Level SUCCESS

# Collecte des informations système
Get-SystemInfo

# Affichage de l'espace disque initial
Get-DiskSpace

# Menu principal
do {
    $choice = Show-MaintenanceMenu
    
    switch ($choice) {
        "1" {
            Write-Log "=== Démarrage de la maintenance complète ===" -Level INFO
            Clear-TemporaryFiles
            Invoke-DiskCleanup
            Invoke-DISMRepair
            Invoke-SystemFileCheck
            Test-WindowsUpdate
            Get-DiskSpace
            Write-Log "=== Maintenance complète terminée ===" -Level SUCCESS
            break
        }
        "2" {
            Write-Log "=== Démarrage du nettoyage rapide ===" -Level INFO
            Clear-TemporaryFiles
            Invoke-DiskCleanup
            Get-DiskSpace
            Write-Log "=== Nettoyage rapide terminé ===" -Level SUCCESS
            break
        }
        "3" {
            Write-Log "=== Démarrage de la vérification système ===" -Level INFO
            Invoke-DISMRepair
            Invoke-SystemFileCheck
            Write-Log "=== Vérification système terminée ===" -Level SUCCESS
            break
        }
        "4" {
            Get-SystemInfo
            Get-DiskSpace
            Test-WindowsUpdate
            break
        }
        "5" {
            Write-Log "Sortie du programme" -Level INFO
            break
        }
        default {
            Write-Host "Option invalide. Veuillez choisir entre 1 et 5." -ForegroundColor Red
        }
    }
    
    if ($choice -ne "5") {
        Write-Host "`nAppuyez sur Entrée pour continuer..." -ForegroundColor Yellow
        Read-Host
        Clear-Host
    }
    
} while ($choice -ne "5")

# Résumé final
$EndTime = Get-Date
$Duration = $EndTime - $StartTime

Write-Host "`n╔════════════════════════════════════════════════════════════╗" -ForegroundColor Green
Write-Host "║                    MAINTENANCE TERMINÉE                   ║" -ForegroundColor Green
Write-Host "╚════════════════════════════════════════════════════════════╝" -ForegroundColor Green

Write-Log "=== Script terminé ===" -Level SUCCESS
Write-Log "Durée totale: $($Duration.Hours)h $($Duration.Minutes)m $($Duration.Seconds)s" -Level INFO
Write-Log "Log sauvegardé dans: $LogPath" -Level INFO

Write-Host "`nLe fichier de log a été sauvegardé sur votre Bureau:" -ForegroundColor Cyan
Write-Host $LogPath -ForegroundColor Yellow
Write-Host "`nMerci d'avoir utilisé le script de maintenance LM-Tools!" -ForegroundColor Green
Write-Host ""

Read-Host "Appuyez sur Entrée pour quitter"

#endregion
