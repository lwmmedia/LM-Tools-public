# BLE Internal Analyzer (iOS / Bluefy)

Outil technique interne basé sur **Web Bluetooth** pour l’analyse de périphériques **BLE (Bluetooth Low Energy)** depuis un iPhone via Bluefy.

Fonctionnalités principales :

- Inventaire complet GATT (Services / Caractéristiques / Descriptors*)
- Lecture de caractéristiques
- Notifications (monitoring en temps réel)
- Écriture HEX / ASCII
- Profilage (temps connexion, 1ère notif, volume)
- Export session JSON
- Export événements CSV
- Décodage modulaire (parsers.js)

> *Les descriptors peuvent être partiellement restreints selon iOS.*

---

## 📁 Structure

ble/
├── blue.html
├── utils.js
├── parsers.js
└── README.md

---

## 🚀 Déploiement (GitHub Pages)

1. Ajouter le dossier `ble/` au dépôt.
2. Activer GitHub Pages (branch `main`, root `/`).
3. URL finale :

https://lwmmedia.github.io/LM-Tools-public/ble/blue.html


Ou ouverture directe Bluefy :

bluefy://open?url=https://lwmmedia.github.io/LM-Tools-public/ble/blue.html


---

## 📲 Utilisation (iOS)

### Pré-requis

- Application Bluefy installée
- Bluetooth activé sur iOS
- Page servie en HTTPS
- Web Bluetooth activé dans Bluefy

---

### Connexion

1. Ouvrir `blue.html`
2. Cliquer sur **Sélectionner périphérique**
3. Choisir un appareil BLE dans le sélecteur iOS
4. L’inventaire GATT démarre automatiquement

---

## 🔍 Inventaire GATT

Affiche :

- Services (`SVC`)
- Caractéristiques (`CH`)
- Propriétés (`read`, `write`, `notify`, etc.)
- Descriptors (`DS`)
- Lecture “sample” si autorisée
- Décodage si parseur existant

---

## 🧪 Commandes ciblées

### Lecture
- Renseigner UUID caractéristique
- Cliquer **Lire**

### Notifications
- Cliquer **Notif ON**
- Les événements sont journalisés
- Cliquer **Notif OFF** pour arrêter

### Écriture
- Choisir mode HEX ou ASCII
- Sélectionner `write` ou `writeWithoutResponse`
- Cliquer **Écrire**

---

## 📊 Profilage

L’outil mesure :

- Temps de connexion (ms)
- Durée inventaire GATT
- Temps jusqu’à première notification
- Nombre total de notifications

---

## 📁 Export

### JSON
Contient :
- Méta session
- Infos périphérique
- Profilage
- Inventaire GATT
- Journal complet

### CSV
Export des événements :
- timestamp
- type
- service
- characteristic
- hex
- ascii
- decoded
- size

---

## 🧠 Décodage personnalisé

Le fichier `parsers.js` permet d’ajouter des décodages spécifiques.

Exemple :

```javascript
if (svc === "0x180f" && ch === "0x2a19") {
  return { battery_percent: dv.getUint8(0) };
}
Pour ajouter un périphérique custom :

Identifier Service UUID

Identifier Characteristic UUID

Ajouter un parseur dans decodeValue()

⚠️ Limites
BLE uniquement (pas Bluetooth classique)

Pas de sniff radio

Sélection obligatoire via picker iOS

Certaines API restreintes par iOS

🛠 Cas d’usage recommandés
Diagnostic IoT

Tests firmware ESP32 / Heltec

Analyse Mesh BLE

Reverse engineering léger

Audit technique terrain

Comparaison versions firmware

🔐 Sécurité
Outil prévu pour usage interne.

Ne pas exposer publiquement si :

périphériques sensibles

environnements critiques

données confidentielles

🧩 Évolutions possibles
Statistiques notifications (débit, jitter)

Vue “Frames” dédiée (Meshcore/Meshtastic)

Filtrage log par service/UUID

Mode capture longue durée

Export compressé

Auteur
Usage interne – LWM Tools
IT / Network / BLE diagnostics
