# LM-Tools

Un dépôt regroupant divers outils informatiques sous forme de scripts Windows, Python et Bash (Linux), accompagné de documentations variées.

**L'objectif** : fournir des ressources utiles pour la communauté.

## 📁 Structure du Dépôt (explication simple)

Le dépôt est organisé **deux fois** pour vous laisser choisir la façon la plus facile pour vous :

1. **Par type de script** (si vous cherchez un langage précis).
2. **Par plateforme** (si vous savez sur quel système vous travaillez).

### ✅ Où chercher en premier ?

| Vous cherchez... | Allez dans... |
| --- | --- |
| Un script Windows (batch ou PowerShell) | `scripts/windows/` |
| Un script Python (tous systèmes) | `scripts/python/` |
| Un script Bash/Linux | `scripts/bash/` |
| Un outil Linux spécifique | `linux/` |
| Un outil Windows spécifique | `windows/` |
| De la documentation | `docs/` |
| Des exemples | `examples/` |

### Structure par Type de Script (la plus simple pour débuter)

```
LM-Tools/
├── scripts/
│   ├── windows/     # Scripts Windows (.bat, .ps1)
│   ├── python/      # Scripts Python (.py)
│   └── bash/        # Scripts Bash/Linux (.sh)
├── docs/            # Documentation
└── examples/        # Exemples d'utilisation
```

### Structure par Plateforme (si vous partez d’un OS précis)

- **`/linux`** - Outils organisés pour les systèmes Linux
  - `linux/scripts_shell/` - Scripts Shell (bash, sh, etc.)
  - `linux/python/` - Scripts Python pour Linux

- **`/windows`** - Outils organisés pour les systèmes Windows
  - `windows/fichiers_batch/` - Fichiers Batch (.bat, .cmd)
  - `windows/scripts_powershell/` - Scripts PowerShell (.ps1)
  - `windows/python/` - Scripts Python pour Windows

### 🧭 Exemple rapide (débutant)

- **Vous êtes sur Windows** et cherchez un outil de maintenance :
  - Commencez par `scripts/windows/`
  - Si l’outil est très spécifique, regardez aussi dans `windows/`

## 🛠️ Outils Disponibles

### Script de Maintenance Windows 10/11

Un script PowerShell sécurisé pour effectuer des opérations de maintenance système sur Windows 10 et Windows 11.

**Fichiers :**
- `Windows-Maintenance.ps1` - Script PowerShell principal
- `Lancer-Maintenance.bat` - Lanceur simple pour faciliter l'exécution
- `README-Windows-Maintenance.md` - Documentation complète

**Fonctionnalités :**
- ✅ Nettoyage des fichiers temporaires
- ✅ Nettoyage de disque Windows
- ✅ Vérification des fichiers système (SFC)
- ✅ Réparation de l'image système (DISM)
- ✅ Vérification de Windows Update
- ✅ Journalisation complète de toutes les opérations
- ✅ Menu interactif avec plusieurs modes de fonctionnement

**Utilisation Rapide :**
1. Téléchargez les fichiers
2. Double-cliquez sur `Lancer-Maintenance.bat` OU
3. Exécutez `Windows-Maintenance.ps1` dans PowerShell en tant qu'administrateur

📖 **[Voir la documentation complète](README-Windows-Maintenance.md)**

## 🚀 Utilisation

### Scripts Windows
Les scripts Windows se trouvent dans `scripts/windows/` et `windows/` et peuvent être exécutés sur les systèmes Windows.

### Scripts Python
Les scripts Python se trouvent dans `scripts/python/`. Assurez-vous d'avoir Python installé sur votre système.

### Scripts Bash
Les scripts Bash se trouvent dans `scripts/bash/` et `linux/scripts_shell/` et sont destinés aux systèmes Linux/Unix.

## 📚 Documentation

La documentation complète se trouve dans le dossier `docs/`. Chaque répertoire contient également son propre README avec des informations spécifiques.

## 🤝 Contributions

Les contributions sont les bienvenues ! Lorsque vous contribuez à ce répertoire :

1. **Choisissez la structure appropriée** :
   - Pour des scripts simples : utilisez `/scripts/[type]/`
   - Pour des outils spécifiques à une plateforme : utilisez `/linux/` ou `/windows/`

2. Ajoutez une brève description ou commentaire expliquant à quoi sert votre script
3. Suivez les conventions de nommage utilisées dans chaque répertoire
4. Mettez à jour les fichiers README pertinents si vous ajoutez des fonctionnalités importantes

### Guide de Migration

Si vous travaillez avec une version antérieure de ce répertoire ayant une structure différente :
- `windows/Batch/` → `windows/fichiers_batch/`
- `windows/PowerShell/` → `windows/scripts_powershell/`

## 📋 À Propos

Ce projet est destiné à la communauté et vise à fournir des ressources utiles pour faciliter la maintenance et la gestion des systèmes.

## 📄 Licence

Ce projet est destiné à la communauté et vise à fournir des ressources utiles.
