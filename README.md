# 🛠️ LM-Tools

[![PowerShell Quality](https://github.com/lwmmedia/LM-Tools/actions/workflows/powershell.yml/badge.svg)](https://github.com/lwmmedia/LM-Tools/actions/workflows/powershell.yml)
[![Python Code Quality](https://github.com/lwmmedia/LM-Tools/actions/workflows/python.yml/badge.svg)](https://github.com/lwmmedia/LM-Tools/actions/workflows/python.yml)
[![ShellCheck](https://github.com/lwmmedia/LM-Tools/actions/workflows/shellcheck.yml/badge.svg)](https://github.com/lwmmedia/LM-Tools/actions/workflows/shellcheck.yml)

**LM-Tools** est un dépôt communautaire regroupant des scripts d'automatisation, de maintenance et des utilitaires système pour Windows et Linux. L'objectif est de fournir des ressources fiables, documentées et sécurisées pour faciliter les tâches informatiques quotidiennes.

## 🚀 Outils Principaux

| Outil | Système | Langage | Description |
| :--- | :--- | :--- | :--- |
| **Windows Maintenance** | 🪟 Win 10/11 | PowerShell | Maintenance complète : SFC, DISM, nettoyage disque et fichiers temporaires. |
| **Optimiseur d'images** | 🐍 Multi | Python | Optimisation et conversion d'images JPG/JPEG avec interface graphique. |
| **Info Système (Linux)** | 🐧 Linux | Bash | Affiche l'utilisateur, l'OS, le kernel, l'uptime et l'utilisation des ressources. |
| **Sauvegarde** | 🐧 Linux | Bash | Crée une sauvegarde compressée (tar.gz) d'un répertoire avec timestamp. |
| **Analyseur de Texte** | 🐍 Multi | Python | Génère des statistiques (lignes, mots, fréquences) sur un fichier texte. |
| **Calculatrice CLI** | 🐍 Multi | Python | Utilitaire de calcul simple en ligne de commande. |
| **Info Système (Windows)** | 🪟 Win | Batch | Affiche les informations système Windows de base. |
| **Processus** | 🪟 Win | PowerShell | Affiche le top 10 des processus par utilisation mémoire. |

## 📂 Structure du Dépôt

Le projet est organisé de manière simple et claire par type de langage :

* **[`/scripts`](./scripts)** : Dossier principal contenant tous les scripts classés par langage :
  * [`bash`](./scripts/bash) : Scripts Linux/Unix (info système, sauvegarde)
  * [`python`](./scripts/python) : Scripts multi-plateformes (analyse de texte, optimisation d'images, calculatrice)
  * [`windows`](./scripts/windows) : Scripts Windows (maintenance, info système, processus)
* **[`/docs`](./docs)** : Documentation complète, incluant les [guides de démarrage](./docs/guide-demarrage.md) et de [contribution](./docs/contribution.md).

## 🛠️ Utilisation Rapide

1.  **Clonage du dépôt** :
    ```bash
    git clone https://github.com/lwmmedia/LM-Tools.git
    cd LM-Tools
    ```
2.  **Installation des dépendances Python** :
    ```bash
    pip install -r requirements.txt
    ```
3.  **Maintenance Windows** : Exécutez [`scripts/windows/Lancer-Maintenance.bat`](./scripts/windows/Lancer-Maintenance.bat) (nécessite des droits administrateur).
4.  **Scripts Python** : Installez Python 3.6+ et lancez vos scripts via `python scripts/python/nom_du_script.py`.
5.  **Scripts Bash** : Rendez le script exécutable avec `chmod +x` avant de le lancer.

## 🛡️ Sécurité et Qualité

* **Validation Automatique** : Chaque modification est analysée par PSScriptAnalyzer (PowerShell), Ruff (Python) et ShellCheck (Bash) via GitHub Actions.
* **Mode Strict** : Les scripts sensibles (ex: Maintenance) utilisent `Set-StrictMode` pour garantir une exécution prévisible.
* **Transparence** : Tous les scripts sont open-source, commentés et génèrent des journaux (logs) détaillés pour les opérations critiques.

## 🤝 Contribution

Les contributions sont les bienvenues ! Pour proposer un script ou une amélioration :
1. Consultez le **[Guide de contribution](./docs/contribution.md)**.
2. Respectez les standards de qualité (en-tête de description, commentaires et tests).
3. Ouvrez une Pull Request sur une branche dédiée.

---
**Développé par la communauté LM-Tools** | 2026 avec l'active participation de Laurent MARQUET.
