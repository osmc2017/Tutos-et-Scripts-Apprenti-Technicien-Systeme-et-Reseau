# Processus de Transmission des Données selon le Modèle OSI

## 1. Introduction
Dans un réseau informatique, la transmission des données suit un processus structuré selon le **modèle OSI (Open Systems Interconnection)**. Ce modèle définit **7 couches**, chacune ayant un rôle précis. Lorsqu’un ordinateur envoie des données à un autre, ces données **descendent les 7 couches** avant d’être transmises physiquement. À l’arrivée, elles sont **réassemblées en remontant les couches** du modèle OSI chez le destinataire.

Nous allons suivre ce cheminement, en expliquant chaque étape.

---

## 2. Tableau récapitulatif du Modèle OSI

| **N° Couche** | **Nom (Anglais)** | **Nom (Français)** | **Rôle principal** |
|--------------|------------------|-----------------|-------------------------|
| 7 | Application | Application | Interaction avec l’utilisateur et applications |
| 6 | Presentation | Présentation | Formatage, chiffrement, compression des données |
| 5 | Session | Session | Gestion des connexions entre applications |
| 4 | Transport | Transport | Contrôle du flux et fiabilité des données (TCP/UDP) |
| 3 | Network | Réseau | Routage et adressage IP des paquets |
| 2 | Data Link | Liaison de données | Encapsulation en trames et adressage MAC |
| 1 | Physical | Physique | Transmission des bits sur le support physique |

---

## 3. Schéma du Modèle OSI et Transmission des Données

```
+-------------------+
| 7. Application   |
| -----------------|
| 6. Présentation  |
| -----------------|
| 5. Session       |
| -----------------|
| 4. Transport     |
| -----------------|
| 3. Réseau        |
| -----------------|
| 2. Liaison       |
| -----------------|
| 1. Physique      |
+-------------------+

Données ---> Segment ---> Paquet ---> Trame ---> Bits
(Encapsulation à l'envoi, Décapsulation à la réception)
```

---

## 4. Étape par étape : Transmission des données

### **1️⃣ Côté Émetteur (de la couche 7 à la couche 1)**

1. **Couche Application (Layer 7 - Application)** :
   - L’utilisateur utilise une application (navigateur web, client mail, etc.).
   - **Synthèse** : Génération des données et requêtes via des protocoles comme **HTTP, FTP, SMTP...**

2. **Couche Présentation (Layer 6 - Presentation)** :
   - Formatage des données, chiffrement si nécessaire.
   - **Synthèse** : Assure le bon format des données pour la transmission.

3. **Couche Session (Layer 5 - Session)** :
   - Gère les connexions entre les applications communicantes.
   - **Synthèse** : Établit, maintient et termine les sessions.

4. **Couche Transport (Layer 4 - Transport)** :
   - Découpe les données en segments avec contrôle de l’ordre et de l’intégrité.
   - **Synthèse** : Fiabilise le transport avec **TCP ou UDP**.

5. **Couche Réseau (Layer 3 - Network)** :
   - Encapsulation des segments dans des **paquets IP** avec adresses source et destination.
   - **Synthèse** : Acheminement des données grâce à **IP, ICMP, ARP**.

6. **Couche Liaison de données (Layer 2 - Data Link)** :
   - Encapsulation des paquets IP en **trames Ethernet**, ajout des adresses MAC.
   - **Synthèse** : Transmission locale sur un réseau physique via **Ethernet, Wi-Fi**.

7. **Couche Physique (Layer 1 - Physical)** :
   - Conversion des trames en signaux électriques, optiques ou radio.
   - **Synthèse** : Transmission brute des bits sur le support physique.

---

### **2️⃣ Côté Récepteur (de la couche 1 à la couche 7)**

1. **Couche Physique (Layer 1 - Physical)** :
   - Réception des signaux et conversion en données binaires.

2. **Couche Liaison de données (Layer 2 - Data Link)** :
   - Vérification de l’intégrité et extraction du **paquet IP**.

3. **Couche Réseau (Layer 3 - Network)** :
   - Vérification et transmission du **paquet IP** à la destination correcte.

4. **Couche Transport (Layer 4 - Transport)** :
   - Réassemblage des segments et correction d’éventuelles erreurs.

5. **Couche Session (Layer 5 - Session)** :
   - Validation de l’état de la connexion.

6. **Couche Présentation (Layer 6 - Presentation)** :
   - Déchiffrement et mise en forme des données.

7. **Couche Application (Layer 7 - Application)** :
   - Les données sont interprétées et affichées par l’application (navigateur, client mail, etc.).

---

## 5. Conclusion Générale
Le **modèle OSI** est un cadre de référence qui permet de standardiser la communication entre équipements réseau. Il assure une organisation claire et modulaire des échanges de données. 

- Chaque couche joue un rôle précis et interagit avec la couche adjacente.
- L’**encapsulation** permet d’ajouter les informations nécessaires pour le transport des données.
- À la réception, le processus de **décapsulation** inverse l’opération pour restituer les données à l’application.


