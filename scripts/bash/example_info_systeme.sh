#!/bin/bash
#=====================================================
# Script Bash d'exemple
# Description: Affiche des informations système Linux
#=====================================================

echo ""
echo "========================================"
echo "    Informations Système Linux"
echo "========================================"
echo ""

# Nom d'utilisateur et hostname
echo "Utilisateur: $(whoami)"
echo "Nom de la machine: $(hostname)"
echo ""

# Système d'exploitation
if [ -f /etc/os-release ]; then
    . /etc/os-release
    echo "OS: $NAME $VERSION"
else
    echo "OS: $(uname -s)"
fi

# Version du kernel
echo "Kernel: $(uname -r)"
echo ""

# Uptime
echo "Uptime: $(uptime -p 2>/dev/null || uptime)"
echo ""

# Utilisation disque
echo "Utilisation du disque:"
df -h / | tail -n 1 | awk '{print "  - Partition: "$1"\n  - Utilisé: "$3"/"$2" ("$5")"}'
echo ""

# Mémoire
echo "Utilisation de la mémoire:"
free -h | grep "Mem:" | awk '{print "  - Total: "$2"\n  - Utilisé: "$3"\n  - Libre: "$4}'
echo ""

echo "========================================"
