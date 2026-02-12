# BLE Internal Analyzer

![Internal Tool](https://img.shields.io/badge/status-internal--tool-orange)
![BLE](https://img.shields.io/badge/technology-BLE-blue)
![Web Bluetooth](https://img.shields.io/badge/WebBluetooth-supported-green)

---

## 🇫🇷 Description (FR)

**BLE Internal Analyzer** est un outil technique interne basé sur Web Bluetooth.

Il permet :

- L’inventaire GATT (Services / Caractéristiques)
- La lecture et l’écriture de caractéristiques BLE
- L’activation de notifications
- Le profilage (temps de connexion, 1ère notification)
- L’export des sessions (JSON / CSV)
- L’ajout de parseurs personnalisés

Cet outil est destiné à un usage professionnel et contrôlé (diagnostic, tests firmware, audit IoT).

Il n’est pas destiné au grand public.

---

## 🇬🇧 Description (EN)

**BLE Internal Analyzer** is an internal technical tool based on Web Bluetooth.

It allows:

- Full GATT inventory (Services / Characteristics)
- Reading and writing BLE characteristics
- Enabling notifications
- Basic performance profiling
- Session export (JSON / CSV)
- Custom protocol parsers

This tool is intended for controlled professional use (diagnostics, firmware testing, IoT audits).

It is not intended for general end users.

---

## ⚠️ Usage Restrictions / Restrictions d’usage

### FR

Utilisation autorisée uniquement :

- Sur des périphériques dont vous êtes propriétaire
- Dans un cadre autorisé
- En environnement de test ou de validation

Les opérations d’écriture peuvent altérer le fonctionnement du périphérique.

Les exports peuvent contenir des identifiants techniques.  
En cas d’usage impliquant des données personnelles, l’utilisateur est responsable de la conformité RGPD.

---

### EN

Authorized use only:

- On devices you own or are authorized to test
- In controlled test environments
- For legitimate technical purposes

Write operations may alter device behavior.

Exports may contain technical identifiers.  
If personal data is involved, the user is responsible for GDPR compliance.

---

## 🔒 Disclaimer

This tool is provided “as is” without warranty of any kind.

The author or maintainer shall not be liable for:

- Device malfunction
- Data loss
- Security incidents
- Regulatory non-compliance
- Indirect damages

Use at your own risk.

---

## 🚀 Deployment

Recommended deployment via GitHub Pages (HTTPS required for Web Bluetooth):

