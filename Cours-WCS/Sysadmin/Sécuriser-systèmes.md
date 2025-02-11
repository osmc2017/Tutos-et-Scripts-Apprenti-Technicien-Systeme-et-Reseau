# Sécuriser les systèmes

## **Sommaire**

1. Introduction
2. Sécurité physique
3. Les logiciels
4. Droits d'accès
5. Composants et outils de sécurité

---

## **1 - Introduction**

### **Objectif de l'administrateur système**

📌 Fournir des **serveurs et terminaux clients** pour supporter les applications métier.
📌 Maintenir ces systèmes **en condition opérationnelle**.
📌 **Les incidents de sécurité** nuisent à cette mission ⟶ **Importance de la sécurisation**.

### **Le point de vue du sysadmin**

📌 Un **serveur ou un poste de travail** est un environnement complexe avec **de nombreux composants**.
📌 **Chaque composant peut comporter des vulnérabilités**.
✅ **Réduction de la surface d'attaque (principe de minimisation)** :

- Réduire le nombre de composants au strict minimum.
- Permettre des mises à jour et un suivi efficace.
- Simplifier la surveillance et la détection des menaces.

### **Sécurité vs Confort d'utilisation**

📌 Les mesures de sécurité **ne doivent pas empêcher l’utilisation légitime** du système.
📌 **Sensibilisation et formation des utilisateurs** essentielles.
📌 **Défense en profondeur** : Ajouter plusieurs couches de sécurité pour dissuader et ralentir un attaquant.

---

## **2 - Sécurité physique**

### **Protection de l'accès aux machines**

✅ **Armoire sécurisée et verrouillée** pour les machines critiques.
✅ **Restreindre l’accès physique aux équipements sensibles**.
✅ Activer **un mot de passe de démarrage (BIOS/boot)**.
✅ **Désactiver le démarrage depuis des périphériques amovibles**.
✅ **Chiffrement des disques**.

### **Minimisation physique**

✅ **Limiter le nombre de périphériques accessibles** :

- Ports USB, lecteurs optiques.
- Interfaces réseau (Ethernet, Wi-Fi, Bluetooth).
  ✅ **Possibilité de désactiver matériellement certains composants**.

### **Choix du matériel**

✅ **Fournisseur de confiance**.
✅ **Matériel conforme aux spécifications** (pas de composants non désirés).
✅ **Support matériel pour la sécurité** :

- Virtualisation des I/O (VT-x, AMD-V).
- TPM (Trusted Platform Module) pour le stockage sécurisé des clés cryptographiques.

---

## **3 - Les logiciels**

### **Inventaire et gestion des logiciels**

📌 **Un OS contient de nombreux composants**.
✅ **Désinstaller les services et applications inutiles**.
✅ **Gérer les dépendances et mises à jour**.
✅ **Utiliser des outils de gestion de parc informatique**.

### **Choix et récupération des logiciels**

✅ **Éditeur de confiance**.
✅ **Utiliser des logiciels open-source audités**.
✅ **Téléchargement depuis des sources officielles uniquement**.
✅ **Vérification des signatures numériques et des empreintes**.
✅ **Utiliser un gestionnaire de paquets avec des dépôts sécurisés**.

### **Configuration et durcissement (Hardening)**

✅ **Configurer correctement les services** :

- Désactiver les comptes et mots de passe par défaut.
- Restreindre les services en écoute sur l’interface réseau nécessaire uniquement.
  ✅ **Appliquer les recommandations de l’éditeur ou des guides de sécurité**.

### **Mises à jour et gestion des vulnérabilités**

📌 **Les vulnérabilités sont découvertes et corrigées régulièrement**.
✅ **Appliquer les correctifs dès leur publication**.
✅ **Tester les mises à jour avant leur déploiement en production**.
✅ **Gérer les versions des logiciels avec une politique de support à long terme (LTS)**.
✅ **Migrer les systèmes obsolètes (Legacy)** ou les isoler dans un environnement restreint.

---

## **4 - Droits d'accès**

### **Gestion des droits**

📌 **Les logiciels disposent généralement d’une gestion des accès basée sur l’authentification et les autorisations**.
✅ **Principe du moindre privilège** : chaque utilisateur doit avoir uniquement les droits nécessaires.
✅ **Sécurisation des comptes** :

- Suppression des comptes inutilisés.
- Interdiction des comptes partagés (ex : "Invité", "Stagiaire").
- Séparation des comptes administrateurs et utilisateurs.
  ✅ **Utilisation de l’élévation temporaire des privilèges** (ex : `sudo` sous Linux).
  ✅ **Mise en place d’une politique d’authentification forte** :
- Mots de passe robustes.
- Authentification multi-facteurs (MFA / 2FA).

---

## **5 - Composants et outils de sécurité**

### **Outils de protection**

📌 **Sécuriser un système est complexe et nécessite des outils dédiés**.
✅ **Antivirus** : Protection contre les malwares (ex : ClamAV en open-source).
✅ **HIDS (Host-based Intrusion Detection System)** : Détection d'intrusions locales (ex : OSSEC, Samhain, fail2ban).
✅ **EDR (Endpoint Detection and Response)** : Analyse et réponse aux menaces en temps réel.
✅ **Pare-feu personnel** : Protection contre les connexions non autorisées.

### **Détection des malwares et attaques**

📌 **Détection via signatures, heuristique et analyse comportementale**.
✅ **Antivirus** : Recherche de logiciels malveillants connus.
✅ **HIDS/HIPS** : Analyse de l’activité système (CPU, mémoire, réseau, fichiers).
✅ **Journaux d’événements** : Surveillance et alertes automatiques.

📌 **Exemples d’outils HIDS** :
✅ **Samhain** : Surveillance des fichiers systèmes.
✅ **OSSEC** : Détection d’intrusions.
✅ **fail2ban** : Blocage des attaques par force brute.
✅ **CrowdSec** : Protection collaborative contre les cyberattaques.

---

## **Conclusion**

📌 **Sécuriser un système demande une approche globale**.
📌 **Principes clés :**
✅ **Minimisation des services et composants installés**.
✅ **Application du principe du moindre privilège**.
✅ **Déploiement d’outils de sécurité adaptés**.
✅ **Mise en place de politiques de mise à jour rigoureuses**.
✅ **Formation et sensibilisation des utilisateurs**.



