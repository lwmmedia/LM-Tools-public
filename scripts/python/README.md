# Scripts Python

Ce dossier contient des scripts Python utiles pour diverses tâches.

## Prérequis

- Python 3.6 ou supérieur
- Les dépendances spécifiques à chaque script (voir les fichiers individuels)

## Utilisation

Exécutez les scripts Python avec :
```bash
python nom_du_script.py
```

ou sur certains systèmes :
```bash
python3 nom_du_script.py
```

## Installation des dépendances

Si un script nécessite des bibliothèques externes, installez-les avec :
```bash
pip install -r requirements.txt
```

## Liste des scripts

### OptimisationImageGUI.py
**Description**: Optimiseur d'images JPG/JPEG avec interface graphique Tkinter.

**Fonctionnalités**:
- Interface graphique intuitive
- Optimisation et conversion d'images JPG/JPEG
- Réduction de la taille des fichiers
- Prévisualisation des résultats
- Traitement par lot

**Utilisation**:
```bash
python OptimisationImageGUI.py
```

**Prérequis**:
```bash
pip install Pillow
```

---

### example_analyse_texte.py
**Description**: Utilitaire d'analyse de fichiers texte avec statistiques détaillées.

**Fonctionnalités**:
- Comptage des lignes, mots et caractères
- Analyse de fréquence des mots
- Top 5 des mots les plus fréquents
- Support de l'encodage UTF-8

**Utilisation**:
```bash
# Avec argument
python example_analyse_texte.py chemin/vers/fichier.txt

# Mode interactif (sans argument)
python example_analyse_texte.py
```

**Exemples**:
```bash
# Analyser le fichier d'exemple
python example_analyse_texte.py ../../examples/exemple_texte.txt
```

**Prérequis**: Python 3.6+ (bibliothèques standard)

---

### example_calculatrice.py
**Description**: Calculatrice simple en ligne de commande.

**Fonctionnalités**:
- Opérations de base: addition, soustraction, multiplication, division
- Interface interactive
- Gestion des erreurs (division par zéro, valeurs invalides)
- Support des nombres décimaux

**Utilisation**:
```bash
python example_calculatrice.py
```

**Exemples d'opérations**:
```
5 + 3
10 - 2.5
7 * 8
100 / 4
q (pour quitter)
```

**Prérequis**: Python 3.6+ (bibliothèques standard)
