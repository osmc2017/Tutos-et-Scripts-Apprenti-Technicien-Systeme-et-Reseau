# Ethernet

## **Sommaire**

1. La norme Ethernet
2. Le câblage et les équipements
3. Les adresses MAC
4. La trame Ethernet
5. Protocole CSMA/CD
6. La commutation
7. Les VLAN

---

## **1 - La norme Ethernet**

### **Définition**

Ethernet est un ensemble de protocoles permettant la mise en place de réseaux locaux (LAN) filaires. Définie par la norme **IEEE 802.3**, elle est aujourd’hui le protocole le plus couramment utilisé pour les réseaux filaires.

📌 **Débits** : 10 Mbps à 400 Gbps (objectif : Ethernet 1,6 Tbps).

### **Architecture en couche IEEE**

Ethernet est structuré selon le modèle IEEE en couches :

- **Couche physique (PHY - couche 1)** : Débit, médium, taux d'erreur.
- **Couche liaison (MAC et LLC - couche 2)** :
  - **MAC** (Medium Access Control) : Gestion des adresses et accès au médium.
  - **LLC** (Logical Link Control) : Optionnel en IPv4.

### **Normes IEEE associées**

| Norme IEEE | Usage                      |
| ---------- | -------------------------- |
| **802.1**  | Bridging & Management      |
| **802.2**  | Logical Link Control (LLC) |
| **802.3**  | Ethernet                   |
| **802.11** | WiFi                       |
| **802.15** | Bluetooth                  |
| **802.16** | WiMAX                      |

---

## **2 - Le câblage et les équipements**

### **Types de câbles Ethernet**

| Type                              | Description                                           |
| --------------------------------- | ----------------------------------------------------- |
| **Coaxial**                       | Utilisé dans les premiers réseaux Ethernet (10Base2). |
| **Paire torsadée (Twisted Pair)** | Limite les interférences, standard actuel.            |
| **Fibre optique**                 | Débits plus élevés, distances plus longues.           |

### **Connecteurs RJ45**

📌 Connecteur standard pour câbles **paires torsadées**.
📌 Types de câblage :

- **Droit (MDI)** : Hôte ↔ Switch
- **Croisé (MDI-X)** : Hôte ↔ Hôte (devenu rare avec Auto MDI/MDI-X).

### **Catégories de câbles RJ45**

| Catégorie  | Débit max | Fréquence |
| ---------- | --------- | --------- |
| **Cat 5e** | 1 Gbps    | 100 MHz   |
| **Cat 6**  | 10 Gbps   | 250 MHz   |
| **Cat 7**  | 10 Gbps   | 600 MHz   |

### **Blindage des câbles**

| Type      | Description                            |
| --------- | -------------------------------------- |
| **U/UTP** | Non blindé                             |
| **F/UTP** | Blindage général                       |
| **S/FTP** | Blindage total avec blindage par paire |

### **Équipements réseau**

- **Carte réseau (NIC)** : Interface entre l'ordinateur et le réseau.
- **Switch** : Gère le trafic entre appareils.
- **SFP/GBIC** : Modules pour fibre optique.

---

## **3 - Les adresses MAC**

### **Définition**

Une adresse **MAC** est un identifiant unique de 48 bits (6 octets) attribué à une carte réseau.

### **Format**

`00:1A:2B:3C:4D:5E`

- **3 premiers octets** : Identifiant du constructeur.
- **3 derniers octets** : Numéro unique attribué par le constructeur.

### **Types d'adresses MAC**

| Adresse             | Type                       |
| ------------------- | -------------------------- |
| `00:1A:2B:3C:4D:5E` | Unicast (hôte unique)      |
| `FF:FF:FF:FF:FF:FF` | Broadcast (tous les hôtes) |
| `01:00:5E:00:00:FB` | Multicast                  |

### **Commandes utiles**

- Linux : `ip link show`
- Windows : `Get-NetAdapter`

---

## **4 - La trame Ethernet**

### **Structure**

| Champ                           | Taille           |
| ------------------------------- | ---------------- |
| **Préambule**                   | 7 octets         |
| **SFD** (Start Frame Delimiter) | 1 octet          |
| **MAC destination**             | 6 octets         |
| **MAC source**                  | 6 octets         |
| **EtherType/Longueur**          | 2 octets         |
| **Données** (payload)           | 46 à 1500 octets |
| **FCS (CRC Checksum)**          | 4 octets         |

📌 **MTU standard** : 1500 octets (Jumbo Frames : jusqu'à 9000 octets).

---

## **5 - Protocole CSMA/CD**

### **Définition**

CSMA/CD (Carrier Sense Multiple Access with Collision Detection) permet la gestion du médium partagé.

### **Fonctionnement**

1. Écoute du médium (`Carrier Sense`).
2. Envoi si libre (`Multiple Access`).
3. **Collision ?** Oui → arrêt et envoi d’un signal (`Collision Detection`).
4. Temps d'attente aléatoire avant une nouvelle tentative (`Backoff`).

📌 **Obsolète avec les switches modernes en full-duplex**.

---

## **6 - La commutation**

### **Fonctionnement d’un switch**

- Équipement de **couche 2** utilisant les **adresses MAC**.
- Crée des **liens dédiés** entre source et destination.
- Sépare les domaines de **collision**.

### **Apprentissage des adresses MAC**

- Lecture de la **source** d’une trame.
- Ajout dans la **table MAC**.
- Transmission vers le port correct si destination connue.
- Sinon, diffusion à tous (`flooding`).

### **Caractéristiques avancées des switches**

- **Port mirroring** : Duplication du trafic pour analyse.
- **QoS (802.1p)** : Priorisation des flux.
- **Redondance (SPB 802.1aq)** : Tolérance aux pannes.

---

## **7 - Les VLAN**

### **Définition**

Un VLAN (Virtual LAN) permet de segmenter un réseau Ethernet sans séparation physique.

### **Avantages**

✅ **Réduction du broadcast**.
✅ **Sécurisation des échanges**.
✅ **Segmentation logique des départements (IT, RH, Finance, etc.)**.

### **IEEE 802.1Q (VLAN tagging)**

📌 Ajoute **4 octets** à l’en-tête Ethernet pour identifier le VLAN.
📌 Seul le **trafic entre switches** contient ces tags.

### **Commandes de configuration**

- **Linux** : `ip link add link eth0 name eth0.10 type vlan id 10`
- **Cisco** : `switchport access vlan 10`

---

## **Conclusion**

📌 **Ethernet est la technologie réseau locale la plus utilisée**.
📌 **CSMA/CD est devenu obsolète avec les switches full-duplex**.
📌 **Les VLAN segmentent un réseau pour une meilleure sécurité et gestion**.



