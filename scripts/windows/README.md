# Scripts Windows

Ce dossier contient des scripts pour les systèmes Windows.

## Types de scripts

- **Fichiers .bat** : Scripts batch Windows classiques
- **Fichiers .ps1** : Scripts PowerShell

## Utilisation

### Scripts Batch (.bat)
Double-cliquez sur le fichier ou exécutez-le depuis l'invite de commandes :
```cmd
nom_du_script.bat
```

### Scripts PowerShell (.ps1)
Exécutez depuis PowerShell :
```powershell
.\nom_du_script.ps1
```

**Note** : Vous devrez peut-être autoriser l'exécution de scripts PowerShell :
```powershell
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
```

## Liste des scripts

### 🛠️ Scripts de Maintenance

#### Windows-Maintenance.ps1
**Description**: Script PowerShell complet de maintenance système Windows.

**Fonctionnalités**:
- Vérification et réparation des fichiers système (SFC)
- Réparation de l'image Windows (DISM)
- Nettoyage des fichiers temporaires
- Nettoyage du disque Windows (cleanmgr)
- Vérification Windows Update
- Génération de logs détaillés sur le Bureau
- Mode strict pour une exécution sécurisée

**Utilisation**:
```powershell
# Exécuter en tant qu'administrateur
.\Windows-Maintenance.ps1
```

**Prérequis**:
- Windows 10/11
- Droits administrateur
- PowerShell 5.0+

**Documentation complète**: [README-Windows-Maintenance.md](../../README-Windows-Maintenance.md)

---

#### Lancer-Maintenance.bat
**Description**: Lanceur automatique pour Windows-Maintenance.ps1 avec vérification des droits administrateur.

**Fonctionnalités**:
- Détection automatique des droits administrateur
- Élévation automatique des privilèges si nécessaire
- Lancement automatique du script PowerShell

**Utilisation**:
```cmd
# Double-cliquer sur le fichier ou exécuter :
Lancer-Maintenance.bat
```

**Guide rapide**: [GUIDE-RAPIDE.md](../../GUIDE-RAPIDE.md)

---

#### MenuInformatiqueLM.bat
**Description**: Menu interactif pour l'informatique LM avec accès aux outils système.

**Utilisation**:
```cmd
MenuInformatiqueLM.bat
```

---

### 📊 Scripts Utilitaires

#### info_systeme.bat
**Description**: Affiche les informations système Windows de base.

**Fonctionnalités**:
- Nom de l'ordinateur et utilisateur
- Date et heure
- Version du système d'exploitation
- Utilise systeminfo pour les détails

**Utilisation**:
```cmd
info_systeme.bat
```

**Prérequis**: Windows 7 ou supérieur

---

#### processus.ps1
**Description**: Affiche le top 10 des processus par utilisation mémoire.

**Fonctionnalités**:
- Liste les processus triés par utilisation mémoire
- Affichage en MB avec formatage
- Inclut le nom, la mémoire, le CPU et l'ID du processus
- Interface colorée

**Utilisation**:
```powershell
.\processus.ps1
```

**Prérequis**: PowerShell 3.0+
