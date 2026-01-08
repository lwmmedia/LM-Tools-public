# Guide de contribution

Merci de votre intérêt pour contribuer à LM-Tools !

## Comment contribuer

### 1. Proposer un nouveau script

1. Forkez le dépôt
2. Créez une branche pour votre fonctionnalité (`git checkout -b feature/mon-script`)
3. Ajoutez votre script dans le dossier approprié :
   - `scripts/windows/` pour les scripts Windows
   - `scripts/python/` pour les scripts Python
   - `scripts/bash/` pour les scripts Bash
4. Ajoutez une documentation claire dans le script
5. Committez vos changements (`git commit -m 'Ajout: mon nouveau script'`)
6. Poussez vers la branche (`git push origin feature/mon-script`)
7. Ouvrez une Pull Request

### 2. Améliorer la documentation

La documentation est tout aussi importante que le code ! N'hésitez pas à :
- Corriger les fautes de frappe
- Clarifier les instructions
- Ajouter des exemples
- Traduire la documentation

### 3. Signaler des bugs

Si vous trouvez un bug :
1. Vérifiez qu'il n'a pas déjà été signalé
2. Ouvrez une issue avec :
   - Une description claire du problème
   - Les étapes pour reproduire le bug
   - Votre environnement (OS, version, etc.)
   - Des captures d'écran si pertinent

## Standards de qualité

### Pour les scripts

#### Tous les scripts doivent :
- Avoir un en-tête avec description
- Être bien commentés
- Gérer les erreurs correctement
- Inclure des exemples d'utilisation
- Être testés avant soumission

#### Scripts Windows (.bat, .ps1)
```batch
@echo off
REM =====================================================
REM Nom du script
REM Description: Description claire du script
REM Auteur: Votre nom (optionnel)
REM =====================================================
```

#### Scripts Python (.py)
```python
#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Nom du script
Description: Description claire du script
"""
```

#### Scripts Bash (.sh)
```bash
#!/bin/bash
#=====================================================
# Nom du script
# Description: Description claire du script
#=====================================================
```

### Pour la documentation

- Utilisez le Markdown
- Soyez clair et concis
- Incluez des exemples
- Vérifiez l'orthographe

## Bonnes pratiques

1. **Un script = une tâche** : Gardez les scripts focalisés sur une tâche spécifique
2. **Sécurité** : Ne jamais inclure de mots de passe ou données sensibles
3. **Compatibilité** : Indiquez clairement les prérequis et limitations
4. **Tests** : Testez vos scripts sur différentes configurations si possible
5. **Licence** : Assurez-vous que votre code peut être partagé librement

## Code de conduite

- Soyez respectueux envers les autres contributeurs
- Acceptez les critiques constructives
- Focalisez sur ce qui est meilleur pour la communauté

## Questions ?

N'hésitez pas à ouvrir une issue pour poser vos questions avant de commencer à travailler sur une contribution importante.

Merci de contribuer à LM-Tools ! 🎉
