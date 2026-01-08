# Script de Maintenance Windows 10/11

## 📋 Description

Script PowerShell sécurisé pour effectuer des opérations de maintenance système sur Windows 10 et Windows 11. Ce script automatise les tâches courantes de maintenance tout en garantissant la sécurité et l'intégrité de votre système.

## ✨ Fonctionnalités

### 1. Maintenance Complète
- Nettoyage des fichiers temporaires
- Nettoyage de disque Windows (cleanmgr)
- Vérification et réparation de l'image système (DISM)
- Vérification des fichiers système (SFC)
- Vérification de Windows Update

### 2. Nettoyage Rapide
- Suppression des fichiers temporaires
- Nettoyage de disque Windows
- Rapport d'espace disque libéré

### 3. Vérification Système
- Analyse DISM (CheckHealth, ScanHealth, RestoreHealth)
- Vérification des fichiers système avec SFC

### 4. Informations Système
- Détails du système d'exploitation
- Informations matérielles
- Espace disque disponible
- Statut de Windows Update

## 🔒 Caractéristiques de Sécurité

- **Droits Administrateur Requis** : Vérification automatique des privilèges
- **Exécution Sécurisée** : Mode strict activé (`Set-StrictMode`)
- **Journalisation Complète** : Tous les événements sont enregistrés
- **Gestion des Erreurs** : Traitement approprié des erreurs sans interruption
- **Pas de Suppression Dangereuse** : Seuls les fichiers temporaires sûrs sont supprimés

## 📋 Prérequis

- **Système d'exploitation** : Windows 10 ou Windows 11
- **PowerShell** : Version 5.1 ou supérieure
- **Droits** : Privilèges administrateur
- **Espace disque** : Au moins 1 GB libre pour les opérations de maintenance

## 🚀 Installation

1. Téléchargez le fichier `Windows-Maintenance.ps1`
2. Placez-le dans un dossier de votre choix (par exemple : `C:\Scripts\`)

## 📖 Utilisation

### Méthode 1 : Exécution Interactive (Recommandée)

1. **Ouvrez PowerShell en tant qu'administrateur** :
   - Cliquez droit sur le menu Démarrer
   - Sélectionnez "Windows PowerShell (Admin)" ou "Terminal (Admin)"

2. **Naviguez vers le dossier du script** :
   ```powershell
   cd C:\Scripts
   ```

3. **Exécutez le script** :
   ```powershell
   .\Windows-Maintenance.ps1
   ```

4. **Suivez le menu interactif** et choisissez l'option souhaitée

### Méthode 2 : Exécution Directe depuis l'Explorateur

1. **Cliquez droit** sur le fichier `Windows-Maintenance.ps1`
2. Sélectionnez **"Exécuter avec PowerShell"**
3. Acceptez l'élévation des privilèges si demandée

### Méthode 3 : Bypass de la Politique d'Exécution (Temporaire)

Si vous rencontrez une erreur de politique d'exécution :

```powershell
PowerShell -ExecutionPolicy Bypass -File "C:\Scripts\Windows-Maintenance.ps1"
```

## 📊 Options du Menu

```
╔════════════════════════════════════════════════════════════╗
║   Script de Maintenance Windows 10/11 - Version 1.0       ║
╠════════════════════════════════════════════════════════════╣
║                                                            ║
║  1. Maintenance complète (recommandé)                      ║
║  2. Nettoyage rapide seulement                             ║
║  3. Vérification système seulement (SFC + DISM)            ║
║  4. Afficher les informations système                      ║
║  5. Quitter                                                ║
║                                                            ║
╚════════════════════════════════════════════════════════════╝
```

### Option 1 : Maintenance Complète (Durée : 30-60 minutes)
Effectue toutes les opérations de maintenance. **Recommandé pour une maintenance mensuelle.**

### Option 2 : Nettoyage Rapide (Durée : 5-10 minutes)
Nettoie uniquement les fichiers temporaires et l'espace disque. **Idéal pour une maintenance hebdomadaire.**

### Option 3 : Vérification Système (Durée : 20-45 minutes)
Vérifie et répare les fichiers système corrompus. **À utiliser en cas de problèmes système.**

### Option 4 : Informations Système (Durée : < 1 minute)
Affiche les informations du système sans effectuer de modifications.

## 📝 Fichiers de Log

Le script génère automatiquement un fichier de log sur votre **Bureau** avec le format :
```
Windows-Maintenance-Log_AAAAMMJJ_HHMMSS.txt
```

Exemple : `Windows-Maintenance-Log_20260108_153045.txt`

Le log contient :
- Horodatage de chaque opération
- Détails des actions effectuées
- Erreurs ou avertissements rencontrés
- Espace disque libéré
- Durée totale d'exécution

## ⚠️ Avertissements et Bonnes Pratiques

### Avant d'Exécuter le Script

1. **Sauvegardez vos données importantes** (recommandé mais non obligatoire)
2. **Fermez toutes les applications** en cours d'utilisation
3. **Assurez-vous d'avoir une connexion Internet** (pour DISM RestoreHealth)
4. **Connectez votre ordinateur portable** au secteur

### Pendant l'Exécution

- ⏳ **Soyez patient** : Certaines opérations (SFC, DISM) peuvent prendre 15-30 minutes
- 💻 **N'éteignez pas l'ordinateur** pendant l'exécution
- 🔌 **Ne débranchez pas** si sur ordinateur portable

### Après l'Exécution

- 📄 **Consultez le fichier de log** pour voir les détails
- 🔄 **Redémarrez votre ordinateur** pour finaliser certaines opérations
- ✅ **Vérifiez que tout fonctionne** correctement

## 🛠️ Résolution de Problèmes

### Le script ne démarre pas

**Erreur : "L'exécution de scripts est désactivée sur ce système"**

Solution :
```powershell
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
```

**Erreur : "Ce script nécessite des droits administrateur"**

Solution : Exécutez PowerShell en tant qu'administrateur (clic droit → Exécuter en tant qu'administrateur)

### SFC ou DISM échoue

Si SFC ou DISM signale des erreurs qui ne peuvent pas être réparées :

1. Vérifiez le fichier `C:\Windows\Logs\CBS\CBS.log` pour plus de détails
2. Essayez de redémarrer et réexécuter le script
3. Consultez le support Microsoft pour des erreurs spécifiques

### Le nettoyage libère peu d'espace

C'est normal si :
- Vous avez récemment nettoyé votre système
- Votre système est relativement neuf
- Vous n'accumulez pas beaucoup de fichiers temporaires

## 🔧 Personnalisation

Le script peut être personnalisé en modifiant les variables au début du fichier :

```powershell
# Modifier le chemin du log
$LogPath = "C:\Logs\Maintenance_$(Get-Date -Format 'yyyyMMdd_HHmmss').txt"
```

## 📈 Fréquence de Maintenance Recommandée

| Type de Maintenance | Fréquence |
|---------------------|-----------|
| Nettoyage Rapide    | Hebdomadaire |
| Maintenance Complète| Mensuelle |
| Vérification Système| Trimestrielle ou en cas de problème |

## 🔐 Sécurité et Confidentialité

- ✅ **Aucune donnée personnelle** n'est collectée ou transmise
- ✅ **Aucune connexion externe** sauf pour Windows Update
- ✅ **Code source ouvert** et vérifiable
- ✅ **Pas de modifications du registre dangereuses**
- ✅ **Suppression uniquement de fichiers temporaires sûrs**

## 📄 Licence

Ce script fait partie du projet LM-Tools et est fourni "tel quel" sans garantie d'aucune sorte.

## 🤝 Support

Pour toute question ou problème :
- Consultez le fichier de log généré
- Vérifiez la documentation Windows pour SFC et DISM
- Ouvrez une issue sur le dépôt GitHub

## 📚 Ressources Supplémentaires

- [Documentation SFC (Microsoft)](https://support.microsoft.com/fr-fr/topic/utiliser-l-outil-vérificateur-des-fichiers-système-pour-réparer-les-fichiers-système-manquants-ou-endommagés-79aa86cb-ca52-166a-92a3-966e85d4094e)
- [Documentation DISM (Microsoft)](https://learn.microsoft.com/fr-fr/windows-hardware/manufacture/desktop/what-is-dism)
- [Nettoyage de disque Windows](https://support.microsoft.com/fr-fr/windows/nettoyage-de-disque-dans-windows-8a96ff42-5751-39ad-23d6-434b4d5b9a68)

## ⚙️ Versions

### Version 1.0 (2026-01-08)
- Version initiale
- Support Windows 10 et Windows 11
- Menu interactif
- Journalisation complète
- 4 modes de fonctionnement

---

**Développé avec ❤️ par LM-Tools**
