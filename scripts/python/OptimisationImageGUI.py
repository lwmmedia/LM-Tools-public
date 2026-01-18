#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Optimiseur d'images JPG avec une interface graphique (GUI).

Ce script permet de traiter des fichiers JPG et JPEG dans un dossier source, en offrant des fonctionnalités telles que :
- Conversion en différents formats d'image (JPEG et WebP).
- Redimensionnement des images en fonction de la plus longue bordure.
- Ajustement de la qualité de compression des images JPEG.
- Structure répliquée des dossiers dans un dossier de sortie.
- Support des métadonnées comme EXIF et ICC.

Utilisateur cible :
- Toute personne ayant besoin d'optimiser des collections de photos de manière rapide et efficace avec une interface simple.

Dépendances :
- Pillow pour traitement des images (https://python-pillow.org/).
- tkinter (standard dans les distributions Python) pour la GUI.

Usage :
- Lancer ce script directement pour ouvrir l'interface utilisateur (GUI).
- Choisir les répertoires source et destination, et configurer les options de traitement.

Auteur : [Votre Nom]
Date : 2026
"""

import os
import sys
import threading
from pathlib import Path
from datetime import datetime
import tkinter as tk
from tkinter import ttk, filedialog, messagebox
from tkinter.scrolledtext import ScrolledText

from PIL import Image, ImageOps

# Titre de l'application
APP_TITLE = "Optimiseur d'images JPG - GUI"
SUPPORTED_EXTS = (".jpg", ".jpeg", ".JPG", ".JPEG")

class ImageOptimizerGUI(tk.Tk):
    """Classe principale pour l'interface graphique d'optimisation d'images.

    Cette classe hérite de `tk.Tk` pour fournir une interface utilisateur.
    Les utilisateurs peuvent configurer le traitement des images via des champs
    et des cases à cocher.
    """
    def __init__(self):
        super().__init__()
        self.title(APP_TITLE)
        self.geometry("780x620")
        self.minsize(720, 580)

        # Variables UI
        self.var_src = tk.StringVar()
        self.var_dst = tk.StringVar()
        self.var_quality = tk.IntVar(value=85)
        self.var_resize = tk.BooleanVar(value=False)
        self.var_max_side = tk.IntVar(value=1920)
        self.var_convert_webp = tk.BooleanVar(value=False)
        self.var_overwrite = tk.BooleanVar(value=False)
        self.var_keep_jpeg = tk.BooleanVar(value=True)  # garder JPEG même si conversion WebP activée
        self.var_progress_text = tk.StringVar(value="En attente…")

        self.stop_event = threading.Event()
        self.worker_thread = None

        self._build_ui()

    def _build_ui(self):
        """Construit l'interface utilisateur.

        Cette méthode initialise les différents widgets tkinter dans
        des cadres logiques (cadres pour les dossiers, paramètres, journal, etc.).
        """
        pad = {"padx": 10, "pady": 8}

        # Cadre Dossiers
        f_paths = ttk.LabelFrame(self, text="Dossiers")
        f_paths.pack(fill="x", **pad)
        ...

    def browse_src(self):
        """Ouvre un dialogue pour sélectionner le dossier source d'images."""
        ...
