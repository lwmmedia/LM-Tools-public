# Politique de Sécurité

## Versions Supportées

Seule la dernière version du dépôt (`main`) reçoit des correctifs de sécurité.

| Branche | Supportée |
|---------|-----------|
| `main`  | Oui       |
| Autres  | Non       |

## Signaler une Vulnérabilité

**Ne créez pas d'Issue publique pour signaler une faille de sécurité.**

Si vous découvrez une vulnérabilité dans l'un des scripts ou outils de LM-Tools, merci de la signaler de manière responsable :

1. **Utilisez le signalement privé GitHub** : rendez-vous sur l'onglet **Security** du dépôt et cliquez sur **"Report a vulnerability"**.
2. Décrivez précisément :
   - Le script ou fichier concerné
   - La nature de la vulnérabilité (injection de commande, élévation de privilèges, fuite de données, etc.)
   - Les étapes pour reproduire le problème
   - L'impact potentiel estimé

Vous recevrez un accusé de réception sous **72 heures**. Un correctif sera publié dès que possible selon la gravité du problème.

## Bonnes Pratiques de Sécurité

Les scripts de LM-Tools sont conçus pour être sûrs. Voici les principes appliqués :

- **Aucune donnée sensible dans le code** : pas de mots de passe, tokens ou clés API en clair
- **Mode strict activé** : les scripts PowerShell utilisent `Set-StrictMode` pour prévenir les comportements inattendus
- **Validation des entrées** : les paramètres utilisateur sont vérifiés avant utilisation
- **Principe du moindre privilège** : les scripts demandent uniquement les droits nécessaires
- **Journalisation** : les opérations critiques génèrent des logs horodatés

## Avertissement

Les scripts de ce dépôt sont fournis "tels quels", sans garantie d'aucune sorte. Il est de votre responsabilité de les tester dans un environnement sécurisé avant tout déploiement en production. Consultez toujours le code source avant d'exécuter un script avec des droits élevés.
