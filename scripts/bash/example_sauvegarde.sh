#!/bin/bash
#=====================================================
# Script Bash d'exemple
# Description: Sauvegarde un répertoire
#=====================================================

# Couleurs pour l'affichage
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

echo ""
echo "========================================"
echo "    Script de Sauvegarde"
echo "========================================"
echo ""

# Fonction d'affichage des erreurs
error_exit() {
    echo -e "${RED}Erreur: $1${NC}" >&2
    exit 1
}

# Fonction d'affichage des succès
success_msg() {
    echo -e "${GREEN}$1${NC}"
}

# Fonction d'affichage des avertissements
warning_msg() {
    echo -e "${YELLOW}$1${NC}"
}

# Vérifier les arguments
if [ $# -lt 1 ]; then
    echo "Utilisation : $0 <répertoire_à_sauvegarder> [destination]"
    echo ""
    echo "Exemple: $0 /home/user/documents /backup"
    echo ""
    exit 1
fi

SOURCE_DIR="$1"
BACKUP_BASE="${2:-./backups}"
TIMESTAMP=$(date +"%Y%m%d_%H%M%S")
BACKUP_NAME="backup_${TIMESTAMP}.tar.gz"
BACKUP_PATH="${BACKUP_BASE}/${BACKUP_NAME}"

# Vérifier que le répertoire source existe
if [ ! -d "$SOURCE_DIR" ]; then
    error_exit "Le répertoire source '$SOURCE_DIR' n'existe pas."
fi

# Créer le répertoire de destination si nécessaire
mkdir -p "$BACKUP_BASE" || error_exit "Impossible de créer le répertoire de destination."

echo "Source: $SOURCE_DIR"
echo "Destination: $BACKUP_PATH"
echo ""

# Créer l'archive
warning_msg "Création de la sauvegarde en cours..."
ERROR_MSG=$(tar -czf "$BACKUP_PATH" -C "$(dirname "$SOURCE_DIR")" "$(basename "$SOURCE_DIR")" 2>&1)
if [ $? -eq 0 ]; then
    BACKUP_SIZE=$(du -h "$BACKUP_PATH" | cut -f1)
    success_msg "Sauvegarde créée avec succès!"
    echo ""
    echo "Fichier: $BACKUP_PATH"
    echo "Taille: $BACKUP_SIZE"
else
    error_exit "Échec de la création de la sauvegarde: $ERROR_MSG"
fi

echo ""
echo "========================================"
