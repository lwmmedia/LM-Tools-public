# Guide de Contribution

Merci de l'intérêt que vous portez à LM-Tools ! Ce guide vous explique comment contribuer efficacement au projet.

## Table des Matières

- [Avant de commencer](#avant-de-commencer)
- [Comment contribuer](#comment-contribuer)
- [Standards de qualité](#standards-de-qualité)
- [Processus de Pull Request](#processus-de-pull-request)
- [Signaler un bug](#signaler-un-bug)
- [Proposer une fonctionnalité](#proposer-une-fonctionnalité)

## Avant de Commencer

1. Lisez le [Code de Conduite](./CODE_OF_CONDUCT.md)
2. Vérifiez les [Issues](https://github.com/lwmmedia/LM-Tools/issues) pour éviter les doublons
3. Pour les changements majeurs, ouvrez d'abord une issue pour en discuter

## Comment Contribuer

### 1. Proposer un nouveau script

1. Forkez le dépôt
2. Créez une branche dédiée : `git checkout -b feature/nom-de-mon-script`
3. Ajoutez votre script dans le dossier approprié :
   - `scripts/windows/` — Scripts PowerShell et Batch
   - `scripts/python/` — Scripts Python multi-plateformes
   - `scripts/bash/` — Scripts Bash Linux/Unix
4. Documentez votre script (en-tête obligatoire, voir [Standards de qualité](#standards-de-qualité))
5. Committez : `git commit -m 'feat: ajouter mon-script'`
6. Poussez : `git push origin feature/nom-de-mon-script`
7. Ouvrez une Pull Request

### 2. Améliorer la documentation

La documentation est tout aussi importante que le code. Vous pouvez :

- Corriger les fautes de frappe ou d'orthographe
- Clarifier des instructions ambiguës
- Ajouter des exemples d'utilisation
- Traduire du contenu

### 3. Corriger un bug

Référencez l'issue correspondante dans votre commit : `fix: corriger le crash de l'optimiseur d'images (#42)`.

## Standards de Qualité

Tout script soumis doit respecter les conventions suivantes.

### En-tête obligatoire

#### Scripts PowerShell (`.ps1`)

```powershell
#Requires -Version 5.1
<#
.SYNOPSIS
    Nom du script
.DESCRIPTION
    Description claire et concise du script.
.NOTES
    Auteur  : Votre nom (optionnel)
    Version : 1.0.0
    Licence : MIT
#>
```

#### Scripts Python (`.py`)

```python
#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Nom du script
Description : Description claire et concise du script.
"""
```

#### Scripts Bash (`.sh`)

```bash
#!/usr/bin/env bash
# =====================================================
# Nom du script
# Description : Description claire et concise.
# =====================================================
set -euo pipefail
```

#### Scripts Batch (`.bat`)

```batch
@echo off
REM =====================================================
REM Nom du script
REM Description : Description claire et concise.
REM =====================================================
```

### Règles générales

| Règle | Détail |
|-------|--------|
| **Un script = une tâche** | Gardez les scripts focalisés |
| **Sécurité** | Aucun mot de passe ni donnée sensible dans le code |
| **Compatibilité** | Précisez les prérequis et limitations |
| **Tests** | Testez sur au moins un environnement cible |
| **Commentaires** | Le code non évident doit être commenté |
| **Licence** | Tout code doit être librement redistribuable |

### Validation automatique

Chaque Pull Request est analysée par les outils suivants. Vos contributions doivent passer ces vérifications :

- **PSScriptAnalyzer** — qualité des scripts PowerShell
- **Ruff** — qualité et formatage des scripts Python
- **ShellCheck** — qualité des scripts Bash

## Processus de Pull Request

1. Remplissez le modèle de Pull Request fourni automatiquement
2. Liez les Issues concernées (`Closes #XX`)
3. Attendez la revue d'un mainteneur
4. Apportez les modifications demandées si nécessaire
5. Une fois approuvé, votre PR sera fusionnée

## Signaler un Bug

Utilisez le modèle **Bug Report** dans les Issues GitHub. Incluez :

- La version du système d'exploitation et ses paramètres régionaux
- La version de PowerShell, Python ou Bash selon le cas
- Les étapes exactes pour reproduire le problème
- Le comportement attendu vs. le comportement observé
- Les messages d'erreur complets (logs, stacktraces)

## Proposer une Fonctionnalité

Utilisez le modèle **Feature Request** dans les Issues GitHub. Décrivez :

- Le problème que vous essayez de résoudre
- La solution que vous proposez
- Les alternatives que vous avez envisagées

---

Des questions ? Ouvrez une issue avec le label `question`. Merci de contribuer à LM-Tools !
