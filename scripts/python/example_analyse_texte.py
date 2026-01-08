#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Script Python d'exemple
Description: Utilitaire pour analyser un fichier texte
"""

import os
import sys
from collections import Counter


def analyser_fichier(chemin_fichier):
    """Analyse un fichier texte et affiche des statistiques."""
    
    if not os.path.exists(chemin_fichier):
        print(f"Erreur: Le fichier '{chemin_fichier}' n'existe pas.")
        return
    
    try:
        with open(chemin_fichier, 'r', encoding='utf-8') as f:
            contenu = f.read()
        
        # Statistiques
        lignes = contenu.split('\n')
        mots = contenu.split()
        caracteres = len(contenu)
        
        print("=" * 50)
        print("    ANALYSE DU FICHIER")
        print("=" * 50)
        print(f"Fichier: {chemin_fichier}")
        print(f"Nombre de lignes: {len(lignes)}")
        print(f"Nombre de mots: {len(mots)}")
        print(f"Nombre de caractères: {caracteres}")
        print()
        
        # Mots les plus fréquents
        if mots:
            freq_mots = Counter(mot.lower().strip('.,!?;:') for mot in mots)
            print("Top 5 des mots les plus fréquents:")
            for mot, freq in freq_mots.most_common(5):
                print(f"  - {mot}: {freq} fois")
        
        print("=" * 50)
        
    except Exception as e:
        print(f"Erreur lors de la lecture du fichier: {e}")


def main():
    """Fonction principale."""
    print()
    
    if len(sys.argv) > 1:
        chemin = sys.argv[1]
    else:
        print("Utilisation: python example_analyse_texte.py <chemin_fichier>")
        print()
        chemin = input("Entrez le chemin du fichier à analyser: ")
    
    if chemin:
        analyser_fichier(chemin)
    else:
        print("Aucun fichier spécifié.")
    
    print()


if __name__ == "__main__":
    main()
