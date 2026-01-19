# Scripts Bash

Ce dossier contient des scripts Bash pour les systèmes Linux/Unix.

## Prérequis

- Système Linux/Unix ou WSL (Windows Subsystem for Linux)
- Bash shell

## Utilisation

### Rendre un script exécutable
```bash
chmod +x nom_du_script.sh
```

### Exécuter un script
```bash
./nom_du_script.sh
```

ou
```bash
bash nom_du_script.sh
```

## Liste des scripts

### example_info_systeme.sh
**Description**: Affiche des informations détaillées sur le système Linux.

**Fonctionnalités**:
- Nom d'utilisateur et hostname
- Version de l'OS et du kernel
- Uptime du système
- Utilisation du disque
- Utilisation de la mémoire

**Utilisation**:
```bash
chmod +x example_info_systeme.sh
./example_info_systeme.sh
```

**Prérequis**: Aucun (commandes système standard)

---

### example_sauvegarde.sh
**Description**: Crée une sauvegarde compressée (tar.gz) d'un répertoire.

**Fonctionnalités**:
- Compression automatique avec timestamp
- Gestion des erreurs
- Affichage coloré des messages
- Création automatique du répertoire de destination

**Utilisation**:
```bash
chmod +x example_sauvegarde.sh
./example_sauvegarde.sh <répertoire_à_sauvegarder> [destination]
```

**Exemples**:
```bash
# Sauvegarder dans le dossier par défaut ./backups
./example_sauvegarde.sh /home/user/documents

# Sauvegarder vers un emplacement spécifique
./example_sauvegarde.sh /home/user/documents /backup
```

**Prérequis**: tar, gzip (préinstallés sur la plupart des distributions)
