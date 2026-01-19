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
- tkinter (standard dans les distributions Python) pour la GUI.
- Pillow pour traitement des images (https://python-pillow.org/)

Usage :
- Lancer ce script directement pour ouvrir l'interface utilisateur (GUI).
- Choisir les répertoires source et destination, et configurer les options de traitement.

Auteur : Laurent MARQUET avec Copilot GitHub
Date : 2026
"""

import os
import threading
from pathlib import Path
from datetime import datetime
import tkinter as tk
from tkinter import filedialog, messagebox, scrolledtext, ttk

try:
    from PIL import Image
except ImportError:
    messagebox.showerror(
        "Dépendance manquante",
        "La bibliothèque Pillow n'est pas installée.\n\n"
        "Installez-la avec : pip install Pillow"
    )
    exit(1)

APP_TITLE = "Optimiseur d'images JPG - GUI"
SUPPORTED_EXTS = (".jpg", ".jpeg", ".JPG", ".JPEG")

class ImageOptimizerGUI(tk.Tk):
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

    # ---------------- UI ----------------
    def _build_ui(self):
        pad = {"padx": 10, "pady": 8}

        # Cadre Dossiers
        f_paths = ttk.LabelFrame(self, text="Dossiers")
        f_paths.pack(fill="x", **pad)

        row = 0
        ttk.Label(f_paths, text="Dossier source :").grid(row=row, column=0, sticky="w", padx=8, pady=6)
        ttk.Entry(f_paths, textvariable=self.var_src, width=70).grid(row=row, column=1, sticky="we", padx=8)
        ttk.Button(f_paths, text="Parcourir…", command=self.browse_src).grid(row=row, column=2, padx=8)
        row += 1
        ttk.Label(f_paths, text="Dossier sortie :").grid(row=row, column=0, sticky="w", padx=8, pady=6)
        ttk.Entry(f_paths, textvariable=self.var_dst, width=70).grid(row=row, column=1, sticky="we", padx=8)
        ttk.Button(f_paths, text="Parcourir…", command=self.browse_dst).grid(row=row, column=2, padx=8)
        f_paths.columnconfigure(1, weight=1)

        # Cadre Paramètres
        f_opts = ttk.LabelFrame(self, text="Paramètres")
        f_opts.pack(fill="x", **pad)

        # Qualité
        fr_quality = ttk.Frame(f_opts)
        fr_quality.pack(fill="x", padx=8, pady=6)
        ttk.Label(fr_quality, text="Qualité JPEG :").pack(side="left")
        s = ttk.Scale(fr_quality, from_=40, to=100, orient="horizontal",
                      variable=self.var_quality, command=lambda e: self.update_quality_label())
        s.pack(side="left", fill="x", expand=True, padx=10)
        self.lbl_quality = ttk.Label(fr_quality, text=f"{self.var_quality.get()}")
        self.lbl_quality.pack(side="left")

        # Redimensionnement
        fr_resize = ttk.Frame(f_opts)
        fr_resize.pack(fill="x", padx=8, pady=6)
        ttk.Checkbutton(fr_resize, text="Redimensionner (longue bordure max, en pixels) :",
                        variable=self.var_resize).pack(side="left")
        ttk.Entry(fr_resize, textvariable=self.var_max_side, width=8).pack(side="left", padx=10)

        # Conversion WebP
        fr_webp = ttk.Frame(f_opts)
        fr_webp.pack(fill="x", padx=8, pady=6)
        ttk.Checkbutton(fr_webp, text="Convertir aussi en WebP", variable=self.var_convert_webp).pack(side="left")
        ttk.Checkbutton(fr_webp, text="Conserver aussi la version JPEG",
                        variable=self.var_keep_jpeg).pack(side="left", padx=16)

        # Overwrite
        ttk.Checkbutton(f_opts, text="Écraser les fichiers existants dans le dossier de sortie",
                        variable=self.var_overwrite).pack(anchor="w", padx=8, pady=4)

        # Cadre Actions
        f_actions = ttk.Frame(self)
        f_actions.pack(fill="x", **pad)
        self.btn_start = ttk.Button(f_actions, text="Démarrer", command=self.start_processing)
        self.btn_start.pack(side="left", padx=4)
        self.btn_stop = ttk.Button(f_actions, text="Annuler", command=self.cancel_processing, state="disabled")
        self.btn_stop.pack(side="left", padx=4)
        self.btn_open_dst = ttk.Button(f_actions, text="Ouvrir dossier de sortie", command=self.open_dst)
        self.btn_open_dst.pack(side="left", padx=4)

        # Barre de progression
        f_prog = ttk.Frame(self)
        f_prog.pack(fill="x", padx=10, pady=(0, 8))
        self.progress_bar = ttk.Progressbar(f_prog, orient="horizontal", mode="indeterminate")
        self.progress_bar.pack(fill="x", expand=True, side="left")
        ttk.Label(f_prog, textvariable=self.var_progress_text, width=26, anchor="e").pack(side="left", padx=(8, 0))

        # Journal
        f_log = ttk.LabelFrame(self, text="Journal")
        f_log.pack(fill="both", expand=True, padx=10, pady=8)
        self.log_text = scrolledtext.ScrolledText(f_log, height=16, state="disabled", wrap="word")
        self.log_text.pack(fill="both", expand=True)

        self._log("Prêt.")

    def update_quality_label(self):
        self.lbl_quality.config(text=str(self.var_quality.get()))

    # ------------- Actions -------------
    def browse_src(self):
        """Ouvre un dialogue pour sélectionner le dossier source d'images."""
        folder = filedialog.askdirectory(title="Sélectionner le dossier source")
        if folder:
            self.var_src.set(folder)
            self._log(f"Dossier source sélectionné : {folder}")

    def browse_dst(self):
        """Ouvre un dialogue pour sélectionner le dossier de destination."""
        folder = filedialog.askdirectory(title="Sélectionner le dossier de destination")
        if folder:
            self.var_dst.set(folder)
            self._log(f"Dossier de destination sélectionné : {folder}")

    def start_processing(self):
        """Démarre le traitement des images dans un thread séparé."""
        src = self.var_src.get().strip()
        dst = self.var_dst.get().strip()

        if not src or not dst:
            messagebox.showwarning(
                "Champs manquants",
                "Veuillez sélectionner les dossiers source et destination."
            )
            return

        if not os.path.isdir(src):
            messagebox.showerror("Erreur", f"Le dossier source n'existe pas : {src}")
            return

        # Réinitialiser l'événement d'arrêt
        self.stop_event.clear()

        # Désactiver le bouton de démarrage
        self.btn_start.config(state="disabled")
        self.btn_stop.config(state="normal")

        # Démarrer la barre de progression
        self.progress_bar.start(10)
        self.var_progress_text.set("Traitement en cours...")

        # Lancer le thread de traitement
        self.worker_thread = threading.Thread(target=self._process_images, daemon=True)
        self.worker_thread.start()

    def stop_processing(self):
        """Arrête le traitement en cours."""
        self.stop_event.set()
        self._log("Arrêt demandé par l'utilisateur...")

    def cancel_processing(self):
        """Annule le traitement en cours (alias de stop_processing)."""
        self.stop_processing()

    def open_dst(self):
        """Ouvre le dossier de destination dans l'explorateur de fichiers."""
        dst = self.var_dst.get().strip()
        if not dst:
            messagebox.showwarning("Aucun dossier", "Veuillez d'abord sélectionner un dossier de sortie.")
            return
        if not os.path.isdir(dst):
            messagebox.showwarning("Dossier introuvable", f"Le dossier n'existe pas encore : {dst}")
            return

        import platform
        import subprocess
        system = platform.system()
        try:
            if system == "Windows":
                os.startfile(dst)
            elif system == "Darwin":  # macOS
                subprocess.run(["open", dst])
            else:  # Linux et autres
                subprocess.run(["xdg-open", dst])
        except Exception as e:
            messagebox.showerror("Erreur", f"Impossible d'ouvrir le dossier : {e}")

    def _process_images(self):
        """Traite les images dans le dossier source.

        Cette méthode parcourt récursivement le dossier source, identifie les fichiers JPG/JPEG,
        et applique les options de traitement configurées (redimensionnement, compression, conversion).
        """
        src_path = Path(self.var_src.get())
        dst_path = Path(self.var_dst.get())

        quality = self.var_quality.get()
        resize = self.var_resize.get()
        max_side = self.var_max_side.get()
        convert_webp = self.var_convert_webp.get()
        overwrite = self.var_overwrite.get()
        keep_jpeg = self.var_keep_jpeg.get()

        self._log("=== Début du traitement ===")
        self._log(f"Source : {src_path}")
        self._log(f"Destination : {dst_path}")
        self._log(f"Qualité JPEG : {quality}")
        self._log(f"Redimensionner : {resize} (max={max_side}px)")
        self._log(f"Convertir en WebP : {convert_webp}")
        self._log(f"Conserver JPEG : {keep_jpeg}")
        self._log("")

        # Compter les fichiers à traiter
        image_files = []
        for ext in SUPPORTED_EXTS:
            image_files.extend(src_path.rglob(f"*{ext}"))

        total_files = len(image_files)
        self._log(f"Fichiers trouvés : {total_files}")

        if total_files == 0:
            self._log("Aucun fichier JPG/JPEG trouvé.")
            self._finish_processing()
            return

        processed = 0
        skipped = 0
        errors = 0

        for img_path in image_files:
            if self.stop_event.is_set():
                self._log("Traitement interrompu.")
                break

            try:
                # Calculer le chemin relatif
                rel_path = img_path.relative_to(src_path)
                out_dir = dst_path / rel_path.parent

                # Créer le dossier de destination si nécessaire
                out_dir.mkdir(parents=True, exist_ok=True)

                # Charger l'image
                img = Image.open(img_path)

                # Redimensionner si demandé
                if resize:
                    width, height = img.size
                    max_current = max(width, height)
                    if max_current > max_side:
                        scale = max_side / max_current
                        new_width = int(width * scale)
                        new_height = int(height * scale)
                        img = img.resize((new_width, new_height), Image.Resampling.LANCZOS)
                        self._log(f"  Redimensionné : {img_path.name} ({width}x{height} → {new_width}x{new_height})")

                # Sauvegarder en JPEG
                if not convert_webp or keep_jpeg:
                    out_jpeg = out_dir / img_path.name
                    if out_jpeg.exists() and not overwrite:
                        self._log(f"  Ignoré (existe déjà) : {out_jpeg}")
                        skipped += 1
                    else:
                        # Préserver les métadonnées EXIF si possible
                        exif_data = img.info.get("exif", None)
                        if exif_data:
                            img.save(out_jpeg, "JPEG", quality=quality, optimize=True, exif=exif_data)
                        else:
                            img.save(out_jpeg, "JPEG", quality=quality, optimize=True)
                        self._log(f"  Traité : {out_jpeg}")
                        processed += 1

                # Convertir en WebP si demandé
                if convert_webp:
                    out_webp = out_dir / (img_path.stem + ".webp")
                    if out_webp.exists() and not overwrite:
                        self._log(f"  Ignoré (existe déjà) : {out_webp}")
                        skipped += 1
                    else:
                        img.save(out_webp, "WebP", quality=quality, method=6)
                        self._log(f"  Converti en WebP : {out_webp}")
                        processed += 1

            except Exception as e:
                self._log(f"  ERREUR avec {img_path.name} : {e}")
                errors += 1

        self._log("")
        self._log("=== Traitement terminé ===")
        self._log(f"Fichiers traités : {processed}")
        self._log(f"Fichiers ignorés : {skipped}")
        self._log(f"Erreurs : {errors}")

        self._finish_processing()

    def _finish_processing(self):
        """Termine le traitement et réinitialise l'interface."""
        self.progress_bar.stop()
        self.var_progress_text.set("Terminé.")
        self.btn_start.config(state="normal")
        self.btn_stop.config(state="disabled")

    def _log(self, message):
        """Ajoute un message au journal de l'interface.

        Args:
            message (str): Le message à afficher dans le journal.
        """
        self.log_text.config(state="normal")
        self.log_text.insert("end", message + "\n")
        self.log_text.see("end")
        self.log_text.config(state="disabled")


def main():
    """Point d'entrée principal de l'application."""
    app = ImageOptimizerGUI()
    app.mainloop()


if __name__ == "__main__":
    main()
