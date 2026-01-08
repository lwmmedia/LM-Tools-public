# Guide de Démarrage Rapide - Maintenance Windows

## 🚀 Démarrage en 3 Étapes

### Méthode Simple (Recommandée pour Débutants)

1. **Téléchargez les fichiers** dans un dossier (ex: `C:\Maintenance\`)
2. **Double-cliquez** sur `Lancer-Maintenance.bat`
3. **Acceptez** l'élévation des privilèges quand demandé

C'est tout ! Le script se lance automatiquement.

---

## ⚡ Options Rapides

### Pour un Nettoyage Hebdomadaire (5-10 min)
→ Choisissez l'option **2** dans le menu

### Pour une Maintenance Mensuelle (30-60 min)  
→ Choisissez l'option **1** dans le menu

### En cas de Problèmes Système (20-45 min)
→ Choisissez l'option **3** dans le menu

---

## 📊 Que Fait le Script ?

| Action | Description | Durée |
|--------|-------------|-------|
| 🗑️ Nettoyage Temporaire | Supprime fichiers temp, cache, prefetch | 2-5 min |
| 💿 Nettoyage Disque | Utilise l'outil Windows cleanmgr | 3-5 min |
| 🔍 SFC Scan | Vérifie et répare fichiers système | 15-30 min |
| 🛠️ DISM Repair | Répare l'image Windows | 10-20 min |
| 📦 Windows Update | Vérifie les mises à jour disponibles | 1-2 min |

---

## ⚠️ Important

✅ **À FAIRE avant de lancer :**
- Fermez vos applications ouvertes
- Branchez votre ordinateur portable (si applicable)
- Prévoyez 30-60 minutes pour maintenance complète

❌ **À NE PAS FAIRE pendant l'exécution :**
- Éteindre l'ordinateur
- Fermer la fenêtre PowerShell
- Débrancher l'ordinateur portable

---

## 📝 Où Trouver le Rapport ?

Le script crée automatiquement un fichier de log sur votre **Bureau** :

📄 `Windows-Maintenance-Log_AAAAMMJJ_HHMMSS.txt`

Ce fichier contient :
- Toutes les actions effectuées
- Espace disque libéré
- Erreurs éventuelles
- Durée totale

---

## 🆘 Problèmes Courants

### Le script ne démarre pas

**Solution 1 :** Exécutez PowerShell en Administrateur
1. Cherchez "PowerShell" dans le menu Démarrer
2. Clic droit → "Exécuter en tant qu'administrateur"
3. Tapez : `cd C:\Maintenance` (ajustez le chemin)
4. Tapez : `.\Windows-Maintenance.ps1`

**Solution 2 :** Autoriser l'exécution temporairement
```powershell
PowerShell -ExecutionPolicy Bypass -File "C:\Maintenance\Windows-Maintenance.ps1"
```

### "Erreur : droits administrateur requis"

→ Vous devez exécuter en tant qu'administrateur (voir Solution 1 ci-dessus)

### Le script semble bloqué

→ C'est normal ! SFC et DISM prennent 15-30 minutes. Soyez patient.

---

## 💡 Astuces

1. **Première utilisation** : Faites une maintenance complète (option 1)
2. **Ensuite** : Nettoyage rapide hebdomadaire (option 2)
3. **Conservez les logs** : Utiles pour suivre l'évolution de votre système
4. **Redémarrez après** : Recommandé pour finaliser certaines opérations

---

## 📚 Plus d'Informations

Pour une documentation détaillée, consultez :
→ **[README-Windows-Maintenance.md](README-Windows-Maintenance.md)**

---

**Développé par LM-Tools** | Version 1.0 | 2026
