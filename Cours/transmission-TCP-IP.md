# Processus de Transmission des Données selon le Modèle TCP/IP

## 1. Introduction
Le **modèle TCP/IP** est une architecture en **4 couches** qui définit comment les données circulent sur un réseau. Il est plus simple que le **modèle OSI (Open Systems Interconnection)** et correspond mieux à l’Internet moderne. 

Chaque couche joue un rôle précis dans l'encapsulation et la transmission des données, de l’application de l'utilisateur jusqu'à l'envoi physique sur le réseau.

Nous allons détailler le fonctionnement du modèle TCP/IP en expliquant chaque étape de transmission des données.

---

## 2. Tableau récapitulatif du Modèle TCP/IP

| **N° Couche** | **Nom (Anglais)** | **Nom (Français)** | **Rôle principal** |
|--------------|------------------|-----------------|-------------------------|
| 4 | Application | Application | Interaction avec l’utilisateur et les applications |
| 3 | Transport | Transport | Fiabilité et contrôle du flux des données (TCP/UDP) |
| 2 | Internet | Réseau | Routage et adressage IP des paquets |
| 1 | Network Access | Accès Réseau | Transmission des trames sur un réseau physique |

---

## 3. Schéma de comparaison entre le Modèle OSI et TCP/IP

```
+-------------------------+-------------------------+
| Modèle OSI             | Modèle TCP/IP           |
+-------------------------+-------------------------+
| 7. Application         | 4. Application         |
| 6. Présentation        |                         |
| 5. Session             |                         |
|-------------------------|-------------------------|
| 4. Transport           | 3. Transport           |
|-------------------------|-------------------------|
| 3. Réseau              | 2. Internet            |
|-------------------------|-------------------------|
| 2. Liaison de données  | 1. Accès Réseau        |
| 1. Physique            |                         |
+-------------------------+-------------------------+
```

👉 **Remarque :** Le modèle TCP/IP regroupe les couches **Application, Présentation et Session** du modèle OSI en une seule couche **Application**. De même, les couches **Liaison de données et Physique** sont regroupées sous **Accès Réseau**.

---

## 4. Schéma du Modèle TCP/IP et Transmission des Données

```
+-------------------+
| 4. Application   |
| -----------------|
| 3. Transport     |
| -----------------|
| 2. Internet      |
| -----------------|
| 1. Accès Réseau  |
+-------------------+

Données ---> Segment ---> Paquet ---> Trame ---> Bits
(Encapsulation à l'envoi, Décapsulation à la réception)
```

---

## 5. Étape par étape : Transmission des données

### **1️⃣ Côté Émetteur (de la couche 4 à la couche 1)**

1. **Couche Application (Layer 4 - Application)** :
   - L’utilisateur utilise une application (navigateur, messagerie, etc.).
   - **Synthèse** : Génération des données via des protocoles comme **HTTP, FTP, SMTP, DNS...**

2. **Couche Transport (Layer 3 - Transport)** :
   - Découpe les données en **segments** et gère leur fiabilité (TCP) ou rapidité (UDP).
   - **Synthèse** : Gestion du flux et des connexions grâce à **TCP ou UDP**.

3. **Couche Internet (Layer 2 - Internet)** :
   - Encapsulation des segments dans des **paquets IP**, ajout des adresses IP source et destination.
   - **Synthèse** : Acheminement des données à travers des réseaux grâce à **IP, ICMP, ARP**.

4. **Couche Accès Réseau (Layer 1 - Network Access)** :
   - Transformation des paquets IP en **trames Ethernet** pour leur transmission sur un réseau local.
   - **Synthèse** : Transmission physique sur un réseau via **Ethernet, Wi-Fi, Fibre...**.

---

### **2️⃣ Côté Récepteur (de la couche 1 à la couche 4)**

1. **Couche Accès Réseau (Layer 1 - Network Access)** :
   - Réception des signaux et conversion en **trames**.

2. **Couche Internet (Layer 2 - Internet)** :
   - Extraction du **paquet IP** et routage vers la bonne adresse.

3. **Couche Transport (Layer 3 - Transport)** :
   - Réassemblage des **segments TCP/UDP** et contrôle des erreurs.

4. **Couche Application (Layer 4 - Application)** :
   - Les données sont interprétées et affichées dans l’application (navigateur, client mail, etc.).

---

## 6. Conclusion Générale
Le **modèle TCP/IP** est le modèle de référence pour Internet et les réseaux modernes.

- Il est **plus simple que le modèle OSI**, avec seulement **4 couches**.
- Chaque couche encapsule et décapsule les données pour assurer leur transmission.
- **TCP/IP est conçu pour être robuste et flexible**, supportant une communication fiable (TCP) ou rapide (UDP).

