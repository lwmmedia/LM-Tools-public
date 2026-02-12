# BLE Internal Analyzer

![Internal Tool](https://img.shields.io/badge/status-internal--tool-orange)
![Not for Production](https://img.shields.io/badge/environment-not--for--production-red)
![BLE](https://img.shields.io/badge/technology-BLE-blue)
![Web Bluetooth](https://img.shields.io/badge/WebBluetooth-required-green)

---

# 🇫🇷 PRÉSENTATION

**BLE Internal Analyzer** est un outil technique interne basé sur Web Bluetooth permettant l’analyse et l’interaction avec des périphériques Bluetooth Low Energy (BLE).

Il est destiné à un usage professionnel contrôlé : diagnostic, validation firmware, audit IoT, analyse GATT.

⚠ Cet outil n’est pas conçu pour un déploiement en production ni pour un usage grand public.

---

# 🇬🇧 OVERVIEW

**BLE Internal Analyzer** is an internal technical tool based on Web Bluetooth enabling interaction with Bluetooth Low Energy (BLE) devices.

It is intended for controlled professional use: diagnostics, firmware validation, IoT audit, and GATT inspection.

⚠ This tool is not intended for production deployment or public use.

---

# 🇫🇷 ARCHITECTURE

ble/
├── blue.html → Application principale (UI + logique BLE)
├── utils.js → Fonctions utilitaires (buffers, export)
├── parsers.js → Couche de décodage protocolaire
└── README.md


### Composants

- **blue.html** : Interface utilisateur et gestion Web Bluetooth
- **utils.js** : Conversion HEX/ASCII, export JSON/CSV
- **parsers.js** : Décodage des caractéristiques (extensible)

---

# 🇬🇧 ARCHITECTURE

ble/
├── blue.html
├── utils.js
├── parsers.js
└── README.md


### Components

- **blue.html**: Web Bluetooth UI and logic
- **utils.js**: Buffer conversion and export utilities
- **parsers.js**: Extendable protocol decoding layer

---

# 🇫🇷 FONCTIONNALITÉS

## Inventaire GATT
- Liste des services primaires
- Liste des caractéristiques et propriétés
- Tentative de lecture initiale si autorisée
- Affichage technique structuré

## Lecture / Écriture
Support :
- read
- write
- writeWithoutResponse
- notify
- indicate

Formats :
- HEX (`01 02 ff`)
- ASCII (`HELLO`)

⚠ L’écriture peut modifier le comportement du périphérique.

## Notifications
- Capture temps réel
- Compteur d’événements
- Temps jusqu’à première notification
- Journalisation complète

## Export
- JSON : session complète (métadonnées + inventaire + événements)
- CSV : flux d’événements exploitable

---

# 🇬🇧 FEATURES

## GATT Inventory
- Primary services listing
- Characteristics and properties
- Sample read when permitted
- Structured technical output

## Read / Write
Supports:
- read
- write
- writeWithoutResponse
- notify
- indicate

Formats:
- HEX (`01 02 ff`)
- ASCII (`HELLO`)

⚠ Writing may alter device behavior.

## Notifications
- Real-time capture
- Event counter
- First notification latency
- Full logging

## Export
- JSON: full session capture
- CSV: event stream export

---

# 🇫🇷 DÉPLOIEMENT

Web Bluetooth nécessite HTTPS.

URL recommandée :

https://lwmmedia.github.io/LM-Tools-public/ble/blue.html


Ouverture directe Bluefy :

bluefy://open?url=https://lwmmedia.github.io/LM-Tools-public/ble/blue.html


---

# 🇬🇧 DEPLOYMENT

Web Bluetooth requires HTTPS.

Recommended URL:

https://lwmmedia.github.io/LM-Tools-public/ble/blue.html


Bluefy direct launch:


bluefy://open?url=https://lwmmedia.github.io/LM-Tools-public/ble/blue.html


---

# 🇫🇷 SÉCURITÉ & RGPD

Les exports peuvent contenir :
- Identifiants BLE persistants
- Numéros de série
- Données techniques corrélables à une personne

En environnement réglementé (école, collectivité, entreprise) :

- Vérifier la base légale du traitement
- Appliquer le principe de minimisation
- Sécuriser les fichiers exportés
- Définir une durée de conservation

L’outil ne transmet aucune donnée vers un serveur externe.

---

# 🇬🇧 SECURITY & GDPR

Exports may contain:
- Persistent BLE identifiers
- Serial numbers
- Technical telemetry potentially linkable to individuals

In regulated environments:

- Ensure lawful basis
- Apply data minimization
- Secure exported files
- Define retention policies

The tool does not transmit data externally.

---

# 🇫🇷 LIMITATIONS

- BLE uniquement (pas Bluetooth classique)
- Pas de sniff radio
- Sélecteur iOS obligatoire
- Accès partiel aux descriptors
- Contraintes de sécurité navigateur

---

# 🇬🇧 LIMITATIONS

- BLE only (no classic Bluetooth)
- No RF sniffing
- iOS picker required
- Partial descriptor access
- Browser security restrictions apply

---

# 🇫🇷 AVERTISSEMENT

Outil fourni « en l’état », sans garantie.

L’auteur ne peut être tenu responsable de :
- Dysfonctionnement matériel
- Perte de données
- Usage non conforme
- Non-respect réglementaire

Usage sous votre entière responsabilité.

---

# 🇬🇧 DISCLAIMER

Provided “as is” without warranty.

The author shall not be liable for:
- Device malfunction
- Data loss
- Misuse
- Regulatory non-compliance

Use entirely at your own risk.
