# IPv4 : Adresse et Paquet

## **Sommaire**

1. Définition et notions de base
2. Adresses IPv4
3. Configuration réseau
4. Le paquet IPv4
5. Protocoles associés (ICMP, ARP, DHCP)

---

## **1 - Définition et notions de base**

### **Qu’est-ce qu’IPv4 ?**

📌 **Internet Protocol version 4** (IPv4) est un protocole de communication utilisé sur Internet.
📌 Il fonctionne à la **couche 3 (réseau) du modèle OSI**.
📌 Permet l’identification des hôtes et l’acheminement des données via des adresses IP.
📌 Deux versions sont actuellement en activité : **IPv4 et IPv6**.

### **Rôle d’IPv4**

- Acheminer les paquets à travers les réseaux interconnectés.
- Gérer l’adressage et le routage des paquets.
- Fonctionner avec les protocoles de **couche transport (TCP, UDP)**.

---

## **2 - Adresses IPv4**

### **Structure des adresses IPv4**

- **Adresses sur 32 bits (4 octets)** → **4,3 milliards d’adresses possibles**.
- Notation **décimale pointée** : `192.168.1.1`.
- Une adresse se compose de :
  - **Identifiant de réseau** (préfixe).
  - **Identifiant d’hôte** (suffixe).

### **Ancien modèle d’adressage (classes)**

| Classe | Plage d’adresses              | Nombre de réseaux | Nombre d’hôtes |
| ------ | ----------------------------- | ----------------- | -------------- |
| A      | `1.0.0.0 - 126.255.255.255`   | 128               | 16M            |
| B      | `128.0.0.0 - 191.255.255.255` | 16K               | 65K            |
| C      | `192.0.0.0 - 223.255.255.255` | 2M                | 254            |

❌ **Problème des classes** : inefficace pour répartir les adresses → introduction du **CIDR**.

### **CIDR (Classless Inter-Domain Routing)**

✅ Notation : `192.168.1.0/24` (24 bits pour le réseau).
✅ Permet **une meilleure gestion de l’espace d’adressage**.
✅ Remplace le système de classes d’adresses.

### **Adresses particulières**

| Adresse           | Rôle                                 |
| ----------------- | ------------------------------------ |
| `0.0.0.0`         | Adresse inconnue ou par défaut       |
| `127.0.0.1`       | Adresse de boucle locale (localhost) |
| `192.168.0.0/16`  | Réseau privé (RFC 1918)              |
| `169.254.0.0/16`  | Adresse APIPA (Auto-assignée)        |
| `255.255.255.255` | Broadcast (diffusion globale)        |

### **Attribution des adresses publiques**

- **IANA (Internet Assigned Numbers Authority)** gère l’attribution.
- Division en **RIR (Registres Internet Régionaux)**.
- **RIPE NCC** (Europe), **ARIN** (Amérique du Nord), etc.

---

## **3 - Configuration réseau**

### **Plan d’adressage**

✅ Définir les plages d’adresses à attribuer (privées/publiques).
✅ Utilisation de NAT pour masquer les adresses internes.
✅ Segmentation en VLANs pour optimiser le réseau.

### **Configuration sous Linux**

#### **Commande pour afficher l’adresse IP**

```bash
ip -4 address show
```

#### **Attribuer une adresse temporairement**

```bash
sudo ip address add 192.168.1.100/24 dev eth0
```

#### **Rendre la configuration persistante** (fichier `/etc/network/interfaces`)

```bash
iface eth0 inet static
    address 192.168.1.100
    netmask 255.255.255.0
    gateway 192.168.1.1
```

### **Configuration sous Windows**

#### **Afficher la configuration réseau**

```powershell
Get-NetIPConfiguration
```

#### **Attribuer une adresse IP**

```powershell
New-NetIPAddress -InterfaceIndex 2 -IPAddress 192.168.1.100 -PrefixLength 24 -DefaultGateway 192.168.1.1
```

---

## **4 - Le paquet IPv4**

### **Structure d’un paquet IPv4**

| Champ                   | Taille  | Description                               |
| ----------------------- | ------- | ----------------------------------------- |
| **Version**             | 4 bits  | Identifie IPv4                            |
| **IHL**                 | 4 bits  | Longueur de l’en-tête                     |
| **Type of Service**     | 8 bits  | QoS et priorité                           |
| **Total Length**        | 16 bits | Taille totale du paquet                   |
| **Identification**      | 16 bits | Identifiant du paquet                     |
| **Flags**               | 3 bits  | Indique si fragmentation                  |
| **Fragment Offset**     | 13 bits | Position du fragment                      |
| **TTL (Time to Live)**  | 8 bits  | Limite de sauts                           |
| **Protocol**            | 8 bits  | Indique le protocole encapsulé (TCP, UDP) |
| **Header Checksum**     | 16 bits | Vérification des erreurs                  |
| **Source Address**      | 32 bits | Adresse émettrice                         |
| **Destination Address** | 32 bits | Adresse destinataire                      |

### **Fragmentation des paquets**

- Si un paquet est trop grand pour passer sur un réseau → **il est fragmenté**.
- Chaque fragment contient une partie des données + l’en-tête IP.
- Reconstitution du paquet uniquement par la machine destinataire.

---

## **5 - Protocoles associés**

### **ICMP (Internet Control Message Protocol)**

✅ Utilisé pour les **messages d’erreur et de diagnostic**.
✅ Exemples de messages ICMP :

- `Echo Request` / `Echo Reply` → Utilisé par `ping`.
- `Destination Unreachable` → Routeur inaccessible.
- `Time Exceeded` → TTL expiré (traceroute).

### **ARP (Address Resolution Protocol)**

✅ Associe une adresse IP à une **adresse MAC**.
✅ Fonctionnement :

1. Une machine demande : *“Qui a l’IP 192.168.1.1 ?”*
2. Le propriétaire répond : *“C’est moi, MAC xx\:xx\:xx\:xx\:xx**:xx**”*

#### **Afficher le cache ARP**

```bash
arp -a  # Sous Windows et Linux
```

### **DHCP (Dynamic Host Configuration Protocol)**

✅ Permet d’attribuer automatiquement des adresses IP.
✅ Fonctionne en **client/serveur**.
✅ Étapes principales :

1. `DHCPDISCOVER` (client → broadcast)
2. `DHCPOFFER` (serveur → client)
3. `DHCPREQUEST` (client → serveur)
4. `DHCPACK` (serveur → client)

---

## **Conclusion**

📌 **IPv4 est toujours le protocole réseau dominant**.
📌 **L’adressage CIDR remplace le modèle en classes**.
📌 **Le paquet IPv4 contient des informations essentielles pour le routage et la fragmentation**.
📌 **ICMP, ARP et DHCP sont des protocoles complémentaires clés**.



