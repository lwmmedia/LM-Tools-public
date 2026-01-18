
import os
import sys
import threading
from pathlib import Path
from datetime import datetime
import tkinter as tk
from tkinter import ttk, filedialog, messagebox
from tkinter.scrolledtext import ScrolledText

from PIL import Image, ImageOps

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
        self.btn_cancel = ttk.Button(f_actions, text="Annuler", command=self.cancel_processing, state="disabled")
        self.btn_cancel.pack(side="left", padx=4)
        self.btn_open_dst = ttk.Button(f_actions, text="Ouvrir dossier de sortie", command=self.open_dst)
        self.btn_open_dst.pack(side="left", padx=4)

        # Barre de progression
        f_prog = ttk.Frame(self)
        f_prog.pack(fill="x", padx=10, pady=(0, 8))
        self.progress = ttk.Progressbar(f_prog, orient="horizontal", mode="determinate")
        self.progress.pack(fill="x", expand=True, side="left")
        ttk.Label(f_prog, textvariable=self.var_progress_text, width=26, anchor="e").pack(side="left", padx=(8, 0))

        # Journal
        f_log = ttk.LabelFrame(self, text="Journal")
        f_log.pack(fill="both", expand=True, padx=10, pady=8)
        self.txt_log = ScrolledText(f_log, height=16)
        self.txt_log.pack(fill="both", expand=True)

        self.log("Prêt.")

    def update_quality_label(self):
        self.lbl_quality.config(text=str(self.var_quality.get()))

    # ------------- Actions -------------
    def browse_src(self):
        path = filedialog.askdirectory(title="Choisir le dossier source")
        if path:
            self.var_src.set(Path(path).as_posix())

    def browse_dst(self):
        path = filedialog.askdirectory(title="Choisir le dossier de sortie")
        if path:
            self.var_dst.set(Path(path).as_posix())

    def open_dst(self):
        dst = self.var_dst.get().strip()
        if not dst:
            messagebox.showinfo("Information", "Veuillez d'abord sélectionner un dossier de sortie.")
            return
        p = Path(dst)
        if not p.exists():
            messagebox.showwarning("Attention", "Le dossier de sortie n'existe pas encore.")
            return
        try:
            if sys.platform.startswith("win"):
                os.startfile(p)  # type: ignore
            elif sys.platform == "darwin":
                os.system(f'open "{p}"')
            else:
                os.system(f'xdg-open "{p}"')
        except Exception as e:
            messagebox.showerror("Erreur", f"Impossible d'ouvrir le dossier : {e}")

    def start_processing(self):
        src = self.var_src.get().strip()
        dst = self.var_dst.get().strip()
        if not src or not dst:
            messagebox.showerror("Erreur", "Veuillez sélectionner un dossier source et un dossier de sortie.")
            return

        src_p = Path(src)
        dst_p = Path(dst)
        if not src_p.exists() or not src_p.is_dir():
            messagebox.showerror("Erreur", "Le dossier source est invalide.")
            return
        if src_p.resolve() == dst_p.resolve():
            messagebox.showerror("Erreur", "Le dossier de sortie doit être différent du dossier source.")
            return

        dst_p.mkdir(parents=True, exist_ok=True)

        # Setup UI state
        self.stop_event.clear()
        self.btn_start.config(state="disabled")
        self.btn_cancel.config(state="normal")
        self.progress["value"] = 0
        self.var_progress_text.set("Préparation…")
        self.log("Démarrage du traitement…")

        # Lancer le thread de travail
        self.worker_thread = threading.Thread(target=self._worker, daemon=True)
        self.worker_thread.start()

    def cancel_processing(self):
        if self.worker_thread and self.worker_thread.is_alive():
            self.stop_event.set()
            self.log("Annulation demandée…")

    def _worker(self):
        try:
            self._process_images()
        except Exception as e:
            self.log(f"[ERREUR] {e}")
            messagebox.showerror("Erreur fatale", str(e))
        finally:
            # Rétablir l'UI
            self.btn_start.config(state="normal")
            self.btn_cancel.config(state="disabled")

    # ----------- Cœur du traitement -----------
    def _process_images(self):
        src_p = Path(self.var_src.get().strip())
        dst_p = Path(self.var_dst.get().strip())
        quality = int(self.var_quality.get())
        do_resize = bool(self.var_resize.get())
        max_side = int(self.var_max_side.get()) if self.var_max_side.get() > 0 else 0
        to_webp = bool(self.var_convert_webp.get())
        keep_jpeg = bool(self.var_keep_jpeg.get())
        overwrite = bool(self.var_overwrite.get())

        # Lister les fichiers à traiter
        files = []
        for root, _, filenames in os.walk(src_p):
            for name in filenames:
                if name.endswith(SUPPORTED_EXTS):
                    files.append(Path(root) / name)

        total = len(files)
        if total == 0:
            self.log("Aucune image JPG/JPEG trouvée.")
            self.var_progress_text.set("0 / 0")
            return

        self.progress["maximum"] = total
        self.log(f"{total} fichier(s) à traiter.")

        processed = 0
        for src_file in files:
            if self.stop_event.is_set():
                self.log("Traitement annulé par l'utilisateur.")
                self.var_progress_text.set(f"{processed} / {total} (annulé)")
                break

            # Chemin relatif pour répliquer l'arborescence
            rel = src_file.relative_to(src_p)
            out_jpg = (dst_p / rel).with_suffix(".jpg")
            out_webp = (dst_p / rel).with_suffix(".webp")

            # Créer le sous-dossier si nécessaire
            out_jpg.parent.mkdir(parents=True, exist_ok=True)

            # Saut si pas overwrite et fichier existe
            if not overwrite:
                # Cas 1: si on garde JPEG
                if keep_jpeg and out_jpg.exists() and not to_webp:
                    self.log(f"[SKIP] Existant (JPEG) : {out_jpg}")
                    processed += 1
                    self._update_progress(processed, total)
                    continue
                # Cas 2: si WebP seul
                if to_webp and not keep_jpeg and out_webp.exists():
                    self.log(f"[SKIP] Existant (WebP) : {out_webp}")
                    processed += 1
                    self._update_progress(processed, total)
                    continue
                # Cas 3: si WebP + JPEG
                if to_webp and keep_jpeg and out_jpg.exists() and out_webp.exists():
                    self.log(f"[SKIP] Existant (JPEG+WebP) : {rel}")
                    processed += 1
                    self._update_progress(processed, total)
                    continue

            try:
                with Image.open(src_file) as im:
                    # Appliquer orientation EXIF si présente
                    im = ImageOps.exif_transpose(im)

                    # Convertir en RGB (JPEG/WebP attendent RGB)
                    if im.mode not in ("RGB", "L"):
                        im = im.convert("RGB")

                    # Redimensionner si demandé
                    if do_resize and max_side > 0:
                        im = self.resize_long_edge(im, max_side)

                    # Récupérer métadonnées utiles
                    exif_bytes = im.info.get("exif")
                    icc = im.info.get("icc_profile")

                    # Sauvegarde JPEG (si demandé ou si pas de WebP seul)
                    if keep_jpeg or not to_webp:
                        self.save_as_jpeg(im, out_jpg, quality, exif_bytes, icc, overwrite)

                    # Sauvegarde WebP (si demandé)
                    if to_webp:
                        self.save_as_webp(im, out_webp, quality, icc, overwrite)

                self.log(f"[OK] {rel.as_posix()}")
            except Exception as e:
                self.log(f"[ERREUR] {rel.as_posix()} : {e}")

            processed += 1
            self._update_progress(processed, total)

        if not self.stop_event.is_set():
            self.var_progress_text.set(f"Terminé : {processed} / {total}")
            self.log("Traitement terminé.")

    def resize_long_edge(self, im: Image.Image, max_side: int) -> Image.Image:
        w, h = im.size
        long_side = max(w, h)
        if long_side <= max_side:
            return im
        scale = max_side / float(long_side)
        new_size = (max(1, int(w * scale)), max(1, int(h * scale)))
        return im.resize(new_size, Image.LANCZOS)

    def save_as_jpeg(self, im, path: Path, quality: int, exif_bytes, icc, overwrite: bool):
        if path.exists() and not overwrite:
            return
        save_kwargs = {
            "format": "JPEG",
            "quality": int(quality),
            "optimize": True,
            "progressive": True,
            "subsampling": "auto",  # Pillow choisit le meilleur compromis
        }
        if exif_bytes:
            save_kwargs["exif"] = exif_bytes
        if icc:
            save_kwargs["icc_profile"] = icc
        path.parent.mkdir(parents=True, exist_ok=True)
        im.save(path, **save_kwargs)

    def save_as_webp(self, im, path: Path, quality: int, icc, overwrite: bool):
        if path.exists() and not overwrite:
            return
        save_kwargs = {
            "format": "WEBP",
            "quality": int(quality),
            "method": 6,  # meilleur ratio
        }
        if icc:
            save_kwargs["icc_profile"] = icc
        path.parent.mkdir(parents=True, exist_ok=True)
        # WebP ne supporte pas l'EXIF de la même façon que JPEG ; on conserve surtout l'ICC
        if im.mode not in ("RGB", "L"):
            im = im.convert("RGB")
        im.save(path, **save_kwargs)

    def _update_progress(self, processed: int, total: int):
        self.progress["value"] = processed
        self.var_progress_text.set(f"{processed} / {total}")
        # Force un rafraîchissement UI
        self.update_idletasks()

    def log(self, msg: str):
        timestamp = datetime.now().strftime("%H:%M:%S")
        self.txt_log.insert("end", f"[{timestamp}] {msg}\n")
        self.txt_log.see("end")

def main():
    app = ImageOptimizerGUI()
    app.mainloop()

if __name__ == "__main__":
    main()
