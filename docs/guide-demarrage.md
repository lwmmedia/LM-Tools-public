# Guide de démarrage

Ce guide vous aidera à commencer avec LM-Tools.

## Installation

### 1. Cloner le dépôt

```bash
git clone https://github.com/lwmmedia/LM-Tools.git
cd LM-Tools
```

### 2. Structure du projet

```
LM-Tools/
├── scripts/
│   ├── windows/     # Scripts Windows (.bat, .ps1)
│   ├── python/      # Scripts Python (.py)
│   └── bash/        # Scripts Bash/Linux (.sh)
├── docs/            # Documentation
└── examples/        # Exemples d'utilisation
```

## Utilisation des scripts

### Scripts Windows

#### Batch (.bat)
Double-cliquez sur le fichier ou exécutez depuis l'invite de commandes :
```cmd
cd scripts\windows
example_info_systeme.bat
```

#### PowerShell (.ps1)
Exécutez depuis PowerShell :
```powershell
cd scripts\windows
.\example_processus.ps1
```

**Important** : Vous devrez peut-être autoriser l'exécution de scripts PowerShell :
```powershell
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
```

### Scripts Python

1. Assurez-vous que Python 3.6+ est installé
2. Naviguez vers le dossier des scripts Python
3. Exécutez le script :

```bash
cd scripts/python
python example_analyse_texte.py mon_fichier.txt
```

### Scripts Bash

1. Rendez le script exécutable (une seule fois)
2. Exécutez le script

```bash
cd scripts/bash
chmod +x example_info_systeme.sh
./example_info_systeme.sh
```

## Prérequis par plateforme

### Windows
- Windows 7 ou supérieur
- PowerShell 5.0+ (pour les scripts .ps1)

### Python
- Python 3.6 ou supérieur
- pip (gestionnaire de paquets Python)

### Linux/Unix
- Bash shell
- Droits d'exécution sur les scripts

## Prochaines étapes

- Explorez les scripts disponibles dans chaque catégorie
- Consultez la documentation spécifique à chaque script
- Contribuez avec vos propres outils !

## Aide et support

Pour toute question, consultez la documentation complète dans le dossier `docs/` ou ouvrez une issue sur GitHub.
