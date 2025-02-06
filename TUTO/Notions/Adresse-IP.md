# Cours sur la Structure de l'Adresse IP

## 1. Introduction
Une adresse IP (**Internet Protocol**) est un identifiant unique attribué à un appareil connecté à un réseau utilisant le protocole IP. Elle permet l'acheminement des paquets de données sur un réseau local (LAN) ou à travers Internet.

Il existe deux versions principales d'adresses IP :
- **IPv4 (Internet Protocol version 4)**
- **IPv6 (Internet Protocol version 6)**

Nous allons détailler la structure et les différences entre ces deux versions.

---

## 2. Structure d'une Adresse IPv4

Une adresse IPv4 est composée de **32 bits** et est généralement représentée sous forme **décimale pointée**, divisée en **4 octets** (8 bits chacun), séparés par des points.

### **Exemple d’adresse IPv4 :**
```
192.168.1.1
```

| **Octet 1** | **Octet 2** | **Octet 3** | **Octet 4** |
|------------|------------|------------|------------|
| 192        | 168        | 1          | 1          |

Chaque octet peut prendre une valeur entre **0 et 255** (2⁸ possibilités).

### **Composition d'une adresse IPv4 :**
Une adresse IPv4 est généralement divisée en **deux parties** :
- **L’identifiant réseau (Network ID)** : Partie qui identifie le réseau.
- **L’identifiant hôte (Host ID)** : Partie qui identifie l’appareil sur ce réseau.

La séparation entre ces parties est définie par le **masque de sous-réseau**.

### **Classes d'Adresses IPv4** (Obsolètes mais encore mentionnées)
Les adresses IPv4 étaient historiquement classées en plusieurs catégories en fonction de leur premier octet.

| **Classe** | **Plage d’adresses** | **Usage** |
|-----------|--------------------|-----------|
| A | 1.0.0.0 - 126.255.255.255 | Réseaux très grands |
| B | 128.0.0.0 - 191.255.255.255 | Réseaux de taille moyenne |
| C | 192.0.0.0 - 223.255.255.255 | Petits réseaux |
| D | 224.0.0.0 - 239.255.255.255 | Multicast |
| E | 240.0.0.0 - 255.255.255.255 | Réservé (expérimental) |

---

## 3. Adresses IPv4 Réservées
Certaines plages d’adresses IPv4 sont réservées pour des usages spécifiques.

| **Type** | **Plage d’adresses** | **Utilisation** |
|---------|--------------------|----------------|
| **Adresses privées** | `10.0.0.0/8`, `172.16.0.0/12`, `192.168.0.0/16` | Réseaux internes (non routables sur Internet) |
| **Adresses publiques** | Tout sauf les adresses privées et réservées | Adresses routables sur Internet |
| **Boucle locale (localhost)** | `127.0.0.0/8` (`127.0.0.1` le plus courant) | Test et communication interne d’un appareil |
| **Lien local** | `169.254.0.0/16` | Assignation automatique sans DHCP (APIPA) |
| **Multicast** | `224.0.0.0/4` | Communication vers plusieurs hôtes |
| **Expérimental** | `240.0.0.0/4` | Réservé pour des usages futurs |

---

## 4. Structure d'une Adresse IPv6

L’IPv6 est une version améliorée de l’IPv4, introduite pour résoudre le problème d’épuisement des adresses IPv4. Une adresse IPv6 est composée de **128 bits**, divisés en **8 groupes de 16 bits** chacun, séparés par des **deux-points (:).**

### **Exemple d’adresse IPv6 :**
```
2001:0db8:85a3:0000:0000:8a2e:0370:7334
```

Pour simplifier l'affichage, les groupes de zéros consécutifs peuvent être remplacés par `::` une seule fois :
```
2001:db8:85a3::8a2e:370:7334
```

### **Composition d'une adresse IPv6 :**
Comme en IPv4, une adresse IPv6 est divisée en **deux parties** :
- **L’identifiant réseau (Prefix)** : Correspond aux **64 premiers bits**.
- **L’identifiant hôte (Interface ID)** : Correspond aux **64 derniers bits**.

### **Types d'Adresses IPv6**
Les adresses IPv6 se classent en plusieurs catégories :

| **Type** | **Préfixe** | **Usage** |
|---------|------------|-----------|
| Unicast global | 2000::/3 | Identifie un appareil unique sur Internet |
| Unicast local | FC00::/7 | Utilisation privée (LAN) |
| Link-local | FE80::/10 | Communication entre appareils sur un même lien |
| Multicast | FF00::/8 | Transmission vers plusieurs appareils |
| Anycast | Variable | Adresse partagée par plusieurs hôtes |

---

## 5. Comparaison entre IPv4 et IPv6

| **Caractéristique** | **IPv4** | **IPv6** |
|--------------------|---------|---------|
| Taille de l’adresse | 32 bits | 128 bits |
| Nombre total d’adresses | ≈ 4,3 milliards | ≈ 340 sextillions |
| Notation | Décimale pointée (192.168.1.1) | Hexadécimale (2001:db8::1) |
| Sous-réseau | Masque de sous-réseau | Préfixe CIDR |
| Diffusion (Broadcast) | Oui | Non (remplacé par multicast) |
| Sécurité | IPSec optionnel | IPSec natif |
| Configuration automatique | Nécessite DHCP | SLAAC (Stateless Address Autoconfiguration) |

---

## 6. Conclusion
L’adresse IP est essentielle pour l’identification et la communication des appareils sur un réseau. **IPv4** reste largement utilisé, mais **IPv6** s’impose progressivement grâce à son espace d’adressage beaucoup plus grand et ses fonctionnalités améliorées.

**👉 Comprendre la structure des adresses IP et les plages réservées est crucial pour tout administrateur réseau !**
