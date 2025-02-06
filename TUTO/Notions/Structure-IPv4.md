# Structure de l'Adresse IPv4

## 1. Introduction
L’**adresse IPv4** (**Internet Protocol version 4**) est un identifiant unique utilisé pour adresser des appareils sur un réseau. Elle permet l’acheminement des paquets de données entre les appareils sur un **réseau local (LAN)** ou sur **Internet**.

Une adresse IPv4 est composée de **32 bits**, représentés sous la forme de **quatre octets (8 bits chacun)** séparés par des points.

### **Exemple d’adresse IPv4 :**
```
192.168.1.1
```
Chaque octet peut avoir une valeur entre **0 et 255** (2⁸ possibilités).

---

## 2. Structure d’une Adresse IPv4

Une adresse IPv4 est divisée en **deux parties principales** :

- **L’identifiant réseau (Network ID)** : Identifie le réseau auquel appartient l’adresse.
- **L’identifiant hôte (Host ID)** : Identifie l’appareil spécifique au sein du réseau.

La séparation entre ces parties est déterminée par le **masque de sous-réseau**.

### **Représentation binaire d’une adresse IPv4 :**
```
192.168.1.1 = 11000000.10101000.00000001.00000001
```

| **Adresse IPv4**  | **Représentation binaire**             |
|-----------------|---------------------------------|
| 192.168.1.1    | 11000000.10101000.00000001.00000001 |
| 10.0.0.1       | 00001010.00000000.00000000.00000001 |
| 172.16.5.20    | 10101100.00010000.00000101.00010100 |

---

## 3. ET Logique et Détermination du Réseau

L’opération de **ET logique (AND binaire)** est utilisée pour déterminer l’identifiant réseau d’une adresse IP en appliquant le **masque de sous-réseau**.

### **Exemple de calcul du réseau avec ET logique :**

#### **Adresse IP :** `192.168.1.10` (`11000000.10101000.00000001.00001010`)
#### **Masque de sous-réseau :** `255.255.255.0` (`11111111.11111111.11111111.00000000`)

Application du **ET logique** bit à bit :
```
11000000.10101000.00000001.00001010   (192.168.1.10)
AND  11111111.11111111.11111111.00000000   (255.255.255.0)
----------------------------------------------------------
=    11000000.10101000.00000001.00000000   (192.168.1.0)
```

**Résultat :** `192.168.1.0` est l’identifiant réseau.

L’ET logique sert donc à **extraire l’adresse du réseau** à partir d’une adresse IP et de son masque.

---

## 4. Types d'Adresses IPv4

Les adresses IPv4 peuvent être classées selon leur usage :

| **Type d’Adresse** | **Plage d’adresses** | **Utilisation** |
|-------------------|--------------------|----------------|
| **Adresses privées** | `10.0.0.0/8`, `172.16.0.0/12`, `192.168.0.0/16` | Réseaux internes (non routables sur Internet) |
| **Adresses publiques** | Tout sauf les adresses privées et réservées | Routables sur Internet |
| **Boucle locale (localhost)** | `127.0.0.0/8` (`127.0.0.1` le plus courant) | Tests et communication interne d’un appareil |
| **Lien local** | `169.254.0.0/16` | Attribution automatique sans DHCP (APIPA) |
| **Multicast** | `224.0.0.0/4` | Transmission vers plusieurs hôtes |
| **Expérimental** | `240.0.0.0/4` | Réservé pour des usages futurs |

---

## 5. Masque de Sous-Réseau

Le **masque de sous-réseau** est une valeur qui détermine **quelle partie d’une adresse IPv4 correspond au réseau** et **quelle partie correspond aux hôtes**.

### **Exemple :**
```
Adresse IP : 192.168.1.10
Masque de sous-réseau : 255.255.255.0
```

| **Partie Réseau** | **Partie Hôte** |
|------------------|---------------|
| 192.168.1       | 10            |

### **Notation CIDR (Classless Inter-Domain Routing)**
La notation **CIDR** permet de représenter l’adresse et le masque de sous-réseau de manière compacte.

| **Notation Classique** | **Notation CIDR** |
|---------------------|----------------|
| 255.0.0.0         | /8             |
| 255.255.0.0       | /16            |
| 255.255.255.0     | /24            |

Une notation `/24` signifie que **les 24 premiers bits** sont réservés à l’identifiant réseau, et les **8 bits restants** pour l’identifiant hôte.

---

## 6. Conclusion
L’**adresse IPv4** est un élément fondamental du routage et de la communication sur les réseaux informatiques. Son organisation en **partie réseau et partie hôte**, associée à l’utilisation des **masques de sous-réseaux**, permet une gestion efficace des adresses IP.

L’utilisation de l’**ET logique** est une méthode clé pour identifier un réseau à partir d’une adresse IP donnée et de son masque.

Cependant, avec l’augmentation du nombre d’appareils connectés, l’**IPv6** devient de plus en plus nécessaire pour pallier l’épuisement des adresses IPv4.

**👉 Comprendre la structure d'une adresse IPv4 et l'utilisation du ET logique est essentiel pour toute administration réseau et configuration d'infrastructure informatique.**
