# Principe des réseaux

## **Sommaire**

1. Notions de base
2. La notion de protocole
3. Le modèle en couche et l’encapsulation
4. Le modèle OSI
5. Le modèle TCP/IP
6. Topologie de réseaux
7. Les équipements d'interconnexion

---

## **1 - Notions de base**

### **Définition d’un réseau informatique**

Un **réseau informatique** est un **ensemble d’éléments interconnectés** permettant l’échange d’informations.

**Éléments constitutifs :**

- **Supports physiques** : câbles, fibres optiques, ondes radio.
- **Équipements d’interconnexion** : routeurs, switchs, hubs.
- **Hôtes** : ordinateurs, serveurs, terminaux.

### **Types de réseaux**

| Type                                | Portée                               |
| ----------------------------------- | ------------------------------------ |
| **PAN** (Personal Area Network)     | Échelle individuelle (ex: Bluetooth) |
| **LAN** (Local Area Network)        | Échelle d’un bâtiment                |
| **MAN** (Metropolitan Area Network) | Échelle d’une ville                  |
| **WAN** (Wide Area Network)         | Échelle d’un pays/continent          |
| **GAN** (Global Area Network)       | Échelle mondiale                     |

### **Commutation de circuit vs paquet**

- **Commutation de circuit** : Un canal dédié est réservé pour chaque communication (ex: téléphonie analogique).
- **Commutation par paquets** : L’information est **découpée** en petits morceaux (datagrammes) et acheminée via différents chemins (ex: Internet).

---

## **2 - La notion de protocole**

### **Définition d’un protocole réseau**

Un **protocole réseau** est un **ensemble de règles** permettant l’échange de données entre équipements.

**Exemples de protocoles connus :**

- **HTTP (port 80)** : Communication Web.
- **FTP (port 21)** : Transfert de fichiers.
- **SMTP (port 25)** : Envoi d’emails.

### **Organismes de standardisation**

| Organisme | Rôle                                                 |
| --------- | ---------------------------------------------------- |
| **IETF**  | Définit les protocoles Internet (TCP/IP, DNS, etc.)  |
| **IEEE**  | Normalisation des réseaux physiques (WiFi, Ethernet) |
| **UIT**   | Réglementation des télécommunications                |

---

## **3 - Le modèle en couche et l’encapsulation**

### **Pourquoi un modèle en couches ?**

✅ Facilite le développement et la compréhension des réseaux.
✅ Permet une interopérabilité entre différents systèmes.
✅ Chaque couche **remplit un rôle précis** et échange avec la couche adjacente.

### **Concept d’encapsulation**

📦 Chaque couche ajoute son **en-tête** de gestion avant d’envoyer les données à la couche inférieure.

Exemple :

```
Application ➝ Transport ➝ Réseau ➝ Liaison ➝ Physique
```

---

## **4 - Le modèle OSI**

### **Historique**

- **1978** : Création du modèle OSI.
- **1984** : Standardisation par l’ISO.

### **Les 7 couches du modèle OSI**

| Couche               | Fonction                                                   |
| -------------------- | ---------------------------------------------------------- |
| **7 - Application**  | Interface utilisateur (HTTP, SMTP, FTP)                    |
| **6 - Présentation** | Format des données, chiffrement (SSL, ASCII, JPEG)         |
| **5 - Session**      | Gestion des connexions (RPC, NetBIOS)                      |
| **4 - Transport**    | Fiabilité des échanges (TCP, UDP)                          |
| **3 - Réseau**       | Routage des paquets (IP, ICMP)                             |
| **2 - Liaison**      | Adressage physique et détection d’erreurs (Ethernet, WiFi) |
| **1 - Physique**     | Transmission des bits (RJ45, fibre, ondes)                 |

### **Critiques du modèle OSI**

❌ Peu utilisé en pratique, remplacé par **TCP/IP**.
❌ Certaines couches sont rarement distinctes (Session, Présentation).

---

## **5 - Le modèle TCP/IP**

### **Historique**

- **1974** : Vinton Cerf et Bob Kahn définissent TCP/IP.
- **1983** : Adoption par **ARPANET**, ancêtre d’Internet.

### **Les 4 couches du modèle TCP/IP**

| Couche OSI   | Couche TCP/IP | Exemples de protocoles |
| ------------ | ------------- | ---------------------- |
| Application  | Application   | HTTP, FTP, SMTP, DNS   |
| Présentation | Application   | SSL/TLS                |
| Session      | Application   | SSH, Telnet            |
| Transport    | Transport     | TCP, UDP               |
| Réseau       | Internet      | IP, ICMP, ARP          |
| Liaison      | Accès réseau  | Ethernet, WiFi         |
| Physique     | Accès réseau  | RJ45, fibre            |

### **Comparaison OSI vs TCP/IP**

📌 **TCP/IP est plus simple** et mieux adapté aux réseaux actuels.
📌 **OSI est un modèle théorique** de référence.

---

## **6 - Topologie de réseaux**

### **Types de topologies**

| Type        | Description                                   |
| ----------- | --------------------------------------------- |
| **Bus**     | Tous les hôtes connectés à un même câble      |
| **Anneau**  | Transmission circulaire des données           |
| **Étoile**  | Tous les équipements connectés à un switch    |
| **Maillée** | Chaque équipement connecté à plusieurs autres |
| **Hybride** | Combinaison de plusieurs topologies           |

### **Réseaux physiques vs logiques**

- **Topologie physique** : Structure matérielle du réseau.
- **Topologie logique** : Chemins empruntés par les données.

---

## **7 - Les équipements d'interconnexion**

### **Principaux équipements**

| Équipement     | Fonction                               | Couche OSI                |
| -------------- | -------------------------------------- | ------------------------- |
| **Répéteur**   | Amplifie le signal                     | 1 - Physique              |
| **Hub**        | Diffuse les données à tous les ports   | 1 - Physique              |
| **Bridge**     | Sépare un réseau en segments           | 2 - Liaison               |
| **Switch**     | Acheminement intelligent des trames    | 2 - Liaison               |
| **Routeur**    | Acheminement des paquets entre réseaux | 3 - Réseau                |
| **Passerelle** | Conversion de protocoles               | 4+ - Transport et au-delà |

### **Exemple de transmission de données**

Lorsqu’un fichier est envoyé :

1. Il est découpé en segments (Transport).
2. Il est encapsulé en paquets (Réseau).
3. Il est transformé en trames (Liaison).
4. Il est converti en signaux électriques/optique (Physique).

---

## **Conclusion**

📌 Un réseau est composé d’éléments interconnectés permettant l’échange de données.
📌 Les **protocoles** définissent les règles de communication.
📌 **Le modèle OSI** (théorique) et **TCP/IP** (pratique) structurent les réseaux.
📌 **Les équipements d’interconnexion** assurent la communication et le routage.



