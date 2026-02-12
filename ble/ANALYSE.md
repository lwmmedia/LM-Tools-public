# Analyse du dossier `ble/`

## Vue d'ensemble
Le dossier `ble/` contient une mini-application Web Bluetooth orientée usage interne pour analyser des périphériques BLE (inventaire GATT, lecture/écriture de caractéristiques, notifications, export JSON/CSV).

## Structure
- `blue.html` : interface + logique principale (connexion BLE, inventaire, commandes, logs, export).
- `utils.js` : utilitaires (conversion buffer/hex/ascii, sérialisation, téléchargement, formatage).
- `parsers.js` : couche de décodage des valeurs de caractéristiques BLE (batterie, infos appareil, fallback 16 bits).
- `URL.md` : URL de lancement (web + schéma Bluefy).
- `README.md` : documentation fonctionnelle, contraintes et points sécurité/RGPD.

## Points forts
- Découpage propre entre UI/flux BLE (`blue.html`), utilitaires (`utils.js`) et décodage (`parsers.js`).
- Journalisation exploitable pour diagnostic (événements horodatés + export).
- Outil explicitement positionné « interne » avec rappel de limites opérationnelles.

## Risques / limites observés
- `blue.html` centralise une grande partie de la logique applicative : la maintenabilité peut se dégrader si de nouvelles fonctions sont ajoutées sans modularisation.
- `parsers.js` fournit surtout des parseurs génériques : pour un usage métier, il faudra enrichir les UUIDs et schémas de décodage spécifiques.
- L’écriture BLE (write / writeWithoutResponse) peut modifier l’état des équipements : nécessite gouvernance d’usage et profils d’accès.
- Les exports peuvent contenir des données techniques sensibles (identifiants, numéros de série), donc stockage/partage à encadrer.

## Recommandations prioritaires
1. **Modulariser progressivement `blue.html`** (ex. gestion connexion, inventaire GATT, commandes, export) pour améliorer testabilité et lisibilité.
2. **Formaliser une librairie de parseurs métier** par famille d’équipements (UUID documentés + mapping attendu).
3. **Ajouter une stratégie de validation d’entrée** pour les commandes d’écriture (formats, longueur max, garde-fous).
4. **Définir une politique d’export** (rétention, pseudonymisation, emplacement sécurisé) selon le contexte RGPD.

## Conclusion
Le dossier `ble/` est cohérent pour un analyseur BLE interne et pragmatique. Le principal axe d’amélioration est la modularisation de la logique front et la spécialisation progressive du décodage protocolaire.
