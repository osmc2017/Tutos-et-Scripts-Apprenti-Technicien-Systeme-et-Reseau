# Cours sur les Adresses MAC

## 1. Introduction
L'adresse MAC (**Media Access Control**) est un identifiant unique attribué à une carte réseau (NIC - **Network Interface Card**). Elle permet d'identifier un appareil sur un réseau local (LAN - **Local Area Network**) et joue un rôle essentiel dans la communication des équipements réseau.

---

## 2. Structure d'une Adresse MAC
Une adresse MAC est composée de **48 bits** (6 octets) et est généralement représentée sous la forme **hexadécimale**, séparée par des **deux-points** (`:`) ou des **traits d’union** (`-`).

### **Exemple d’adresse MAC :**
```
00:1A:2B:3C:4D:5E  ou  00-1A-2B-3C-4D-5E
```

### **Détail des 6 octets :**
| **Octets** | **Description** |
|-----------|----------------|
| **Les 3 premiers (OUI - Organizationally Unique Identifier)** | Identifiant du fabricant (ex: Intel, Cisco, Apple, etc.) |
| **Les 3 derniers (NIC Specific)** | Numéro unique attribué à l’interface réseau |

👉 **Chaque fabricant de matériel réseau reçoit une plage d’adresses MAC assignée par l’IEEE.**

---

## 3. Rôle des Adresses MAC
L'adresse MAC est utilisée dans la **couche 2** du modèle OSI (**Liaison de données**) et joue plusieurs rôles :

- **Identification unique** d'un appareil dans un réseau local.
- **Transmission des données** entre deux équipements au sein d’un LAN.
- **Filtrage et sécurisation** des connexions réseau (ex: filtrage MAC sur un routeur).
- **Résolution d’adresse IP en adresse MAC** via le protocole ARP (**Address Resolution Protocol**).

---

## 4. Comparaison des Types d'Adresses MAC

| **Mode d’adressage** | **MAC Destination** | **Qui reçoit le message ?** | **Exemple d’utilisation** |
|---------------------|---------------------|----------------------------|-------------------------|
| **Unicast** | Adresse MAC unique (`AA:BB:CC:DD:EE:FF`) | Un seul appareil spécifique | HTTP, SSH, transfert de fichiers |
| **Broadcast** | `FF:FF:FF:FF:FF:FF` | Tous les appareils du réseau | ARP Request, DHCP Discover |
| **Multicast** | `01:00:5E:xx:xx:xx` | Un groupe d’appareils abonnés | Streaming vidéo, VoIP, IPTV |

---

## 5. Cheminement d'une Trame ARP lorsque la Table est Vide

### **Objectif :**
Un PC (Émetteur) veut envoyer un paquet à un autre PC (Destinataire) dans un réseau local, mais sa table ARP est vide. Nous allons voir comment il trouve l’adresse MAC cible et envoie les données.

### **1️⃣ Vérification de la table ARP**
Avant d’envoyer un paquet à une machine (ex: `192.168.1.10`), le PC émetteur vérifie sa table ARP avec la commande :
```bash
arp -a
```
Si la table est vide ou ne contient pas `192.168.1.10`, le PC ne connaît pas l’adresse MAC associée.

### **2️⃣ Envoi d'une requête ARP en Broadcast**
💡 **Problème** : Le PC émetteur ne connaît pas l’adresse MAC de `192.168.1.10`
💡 **Solution** : Il envoie une requête ARP en **broadcast** à `FF:FF:FF:FF:FF:FF`

📡 Le message est envoyé à tous les appareils du réseau, mais seul le PC qui possède l'IP `192.168.1.10` répond.

### **3️⃣ Réponse ARP en Unicast**
Le PC cible (`192.168.1.10`) reçoit la requête et envoie une réponse ARP en **unicast** à l'émetteur.

📌 Le PC émetteur met à jour sa table ARP avec cette correspondance (`192.168.1.10` → `AA:BB:CC:DD:EE:FF`).

### **4️⃣ Envoi des données en Unicast**
Maintenant que le PC émetteur connaît l’adresse MAC de `192.168.1.10`, il peut envoyer son paquet en **unicast** directement à `AA:BB:CC:DD:EE:FF`.

---

## 6. Cheminement d'une Trame Ethernet lorsque la Table MAC est Vide

### **Objectif :**
Un switch reçoit une trame à destination d’une adresse MAC qu’il ne connaît pas encore. Nous allons voir comment il apprend l’adresse et met à jour sa table MAC.

### **1️⃣ Réception de la Trame par le Switch**
💡 **Problème** : La table MAC du switch ne contient pas l’adresse MAC de destination.
💡 **Solution** : Le switch effectue un **flooding**, envoyant la trame sur tous les ports sauf celui d’origine.

📡 Tous les appareils du réseau reçoivent la trame, mais seul le destinataire légitime répond.

### **2️⃣ Réponse du Destinataire en Unicast**
Le destinataire envoie une réponse directement au switch en **unicast**.

📌 Le switch enregistre l’adresse MAC source de la réponse dans sa table MAC et l’associe au port où il a reçu la réponse.

### **3️⃣ Mise à jour de la Table MAC**
La table MAC est mise à jour avec l’adresse MAC et son port associé, permettant au switch d’envoyer directement les futures trames sans flooding.

---

## 7. Conclusion
L’adresse MAC est essentielle pour l’identification et la communication des appareils dans un réseau. Son association avec l’ARP permet la résolution des adresses IP en adresses MAC, et les switches utilisent la table MAC pour optimiser le routage des trames. Bien comprendre leur fonctionnement est crucial pour tout administrateur réseau !
