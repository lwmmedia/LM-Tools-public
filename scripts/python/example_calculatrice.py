#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Script Python d'exemple
Description: Utilitaire de calcul simple
"""


def calculatrice():
    """Calculatrice simple en ligne de commande."""
    
    print("=" * 50)
    print("    CALCULATRICE SIMPLE")
    print("=" * 50)
    print()
    print("Opérations disponibles:")
    print("  + : Addition")
    print("  - : Soustraction")
    print("  * : Multiplication")
    print("  / : Division")
    print("  q : Quitter")
    print()
    
    while True:
        try:
            operation = input("Entrez une opération (ex: 5 + 3) ou 'q' pour quitter: ").strip()
            
            if operation.lower() == 'q':
                print("Au revoir!")
                break
            
            # Évaluation sécurisée de l'opération
            parties = operation.split()
            
            if len(parties) != 3:
                print("Format incorrect. Utilisez: nombre opérateur nombre")
                continue
            
            num1 = float(parties[0])
            operateur = parties[1]
            num2 = float(parties[2])
            
            if operateur == '+':
                resultat = num1 + num2
            elif operateur == '-':
                resultat = num1 - num2
            elif operateur == '*':
                resultat = num1 * num2
            elif operateur == '/':
                if num2 == 0:
                    print("Erreur: Division par zéro!")
                    continue
                resultat = num1 / num2
            else:
                print(f"Opérateur '{operateur}' non reconnu.")
                continue
            
            print(f"Résultat: {resultat}")
            print()
            
        except ValueError:
            print("Erreur: Veuillez entrer des nombres valides.")
        except KeyboardInterrupt:
            print("\nInterruption détectée. Au revoir!")
            break
        except Exception as e:
            print(f"Erreur: {e}")


if __name__ == "__main__":
    calculatrice()
