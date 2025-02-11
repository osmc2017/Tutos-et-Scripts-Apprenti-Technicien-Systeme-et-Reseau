# IPv6 : Adresse et Paquet

## **Sommaire**

1. Introduction
2. Les adresses IPv6
3. Auto-configuration
4. Le paquet IPv6
5. Protocoles associés

---

## **1 - Introduction**

### **Pourquoi IPv6 ?**

✅ **Remplace IPv4** et étend les capacités d’adressage.
✅ **Simplifie les en-têtes** pour un traitement plus efficace.
✅ **Automatise la configuration** avec SLAAC.
✅ **Améliore la sécurité** avec IPsec natif.
✅ **Réduit la fragmentation** via Path MTU Discovery (PMTUd).

### **Objectifs d’IPv6**

- Une **meilleure évolutivité** grâce à des adresses sur **128 bits**.
- L'élimination du **NAT** (adressage public généralisé).
- Une gestion optimisée des réseaux avec **autoconfiguration et mobilité**.

---

## **2 - Les adresses IPv6**

### **Caractéristiques des adresses IPv6**

📌 **128 bits** → ≈ \$3,4 × 10^{38}\$ adresses possibles.
📌 **Trois types d’adresses** :

- **Unicast** : Identifie une seule interface.
- **Multicast** : Diffuse à plusieurs hôtes (remplace le broadcast).
- **Anycast** : Adresse partagée, le plus proche répond.

### **Notation IPv6**

- **Hexadécimal** séparé par `:` en groupes de 16 bits.
- **Omission des zéros non significatifs**.
- **Suppression des séquences de ****`0`**** continues** (`::`).

#### **Exemples**

| Notation complète                         | Notation abrégée                                            |
| ----------------------------------------- | ----------------------------------------------------------- |
| `2001:0db8:0000:85a3:0000:0000:ac1f:8001` | `2001:db8:0:85a3::ac1f:8001`                                |
| `fe80:0000:0000:0000:0000:4cff:fe4f:4f50` | `fe80::4cff:fe4f:4f50`                                      |
| `::1`                                     | Adresse de boucle locale (équivalent à `127.0.0.1` en IPv4) |

### **Types d’adresses spéciales**

| Adresse     | Rôle                                             |
| ----------- | ------------------------------------------------ |
| `::1`       | Loopback (boucle locale)                         |
| `::`        | Adresse indéfinie (équivalent `0.0.0.0` en IPv4) |
| `ff00::/8`  | Multicast                                        |
| `fe80::/10` | Lien local (non routable)                        |
| `fc00::/7`  | Unicast local (réseau privé)                     |
| `2000::/3`  | Unicast global (Internet)                        |

---

## **3 - Auto-configuration**

### **SLAAC (Stateless Address Autoconfiguration)**

✅ **Configuration automatique** sans DHCP.
✅ **Les routeurs diffusent leur préfixe** (`Router Advertisement`).
✅ **L’adresse est générée avec l’interface ID** (souvent dérivée de l’adresse MAC).

### **Durée de vie des adresses IPv6**

- **Provisoire** → En attente de validation.
- **Préférée** → Utilisée activement.
- **Dépréciée** → Remplacée par une autre.
- **Invalide** → Non utilisable.

### **Identification de l’interface**

- Génération aléatoire (`RFC 8981`).
- Basée sur **MAC modifié (EUI-64)** (`RFC 4291`).
- **Cryptographique** (`RFC 3972`).

---

## **4 - Le paquet IPv6**

### **Structure simplifiée**

| Champ                              | Description                                   |
| ---------------------------------- | --------------------------------------------- |
| **Version** (4 bits)               | Indique IPv6.                                 |
| **Traffic Class** (8 bits)         | QoS et priorité.                              |
| **Flow Label** (20 bits)           | Identifiant de flux.                          |
| **Payload Length** (16 bits)       | Taille de la charge utile.                    |
| **Next Header** (8 bits)           | Type de protocole suivant (TCP, UDP, ICMPv6). |
| **Hop Limit** (8 bits)             | TTL, décrémenté à chaque routeur.             |
| **Source Address** (128 bits)      | Adresse émettrice.                            |
| **Destination Address** (128 bits) | Adresse cible.                                |

### **Fragmentation**

- **IPv6 n’autorise pas la fragmentation en route**.
- Utilisation de **Path MTU Discovery (PMTUd)** (`RFC 8201`).
- Si un routeur détecte un paquet trop grand : **il le rejette et prévient l’émetteur**.

---

## **5 - Protocoles associés**

### **ICMPv6 (RFC 4443)**

✅ Remplace **ICMP, ARP et IGMP**.
✅ Utilisé pour la **détection de voisins** (`Neighbor Discovery Protocol - NDP`).
✅ Gère la **détection d’adresses dupliquées** et les **messages d’erreur**.

### **DHCPv6 (RFC 3315)**

✅ Optionnel grâce à **SLAAC**, mais utile pour **DNS dynamique**.
✅ Fonctionne avec multicast (`FF02::1:2`).
✅ Utilise les **ports UDP 546 et 547**.

### **IPsec (Sécurisation d’IPv6)**

✅ Intégré nativement à IPv6.
✅ Permet l’**authentification, intégrité et chiffrement** des paquets.
✅ Utilise les protocoles **AH, ESP, IKE**.

### **Mobilité IPv6 (RFC 6275)**

✅ **Maintien des connexions lors des changements de réseaux**.
✅ Utilisation d’une **Home Address** et d’une **Care-of Address**.
✅ **Home Agent** intercepte et redirige le trafic.

---

## **Conclusion**

📌 **IPv6 offre une meilleure évolutivité et sécurité que IPv4**.
📌 **L’autoconfiguration** permet une gestion plus simple des adresses.
📌 **Les en-têtes sont optimisés** pour améliorer les performances.
📌 **ICMPv6, IPsec et DHCPv6** sont essentiels au fonctionnement d’IPv6.



