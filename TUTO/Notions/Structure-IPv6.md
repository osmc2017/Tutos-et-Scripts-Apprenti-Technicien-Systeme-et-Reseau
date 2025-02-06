# Structure de l'Adresse IPv6

## 1. Introduction
L’**adresse IPv6** (**Internet Protocol version 6**) est la nouvelle génération d’adressage IP, conçue pour pallier l’épuisement des adresses IPv4 et améliorer la gestion du réseau. Elle permet une meilleure scalabilité, sécurité et simplifie l’acheminement des paquets.

Une adresse IPv6 est composée de **128 bits**, représentés sous la forme de **huit groupes de 16 bits** séparés par des deux-points (`:`).

### **Exemple d’adresse IPv6 :**
```
2001:0db8:85a3:0000:0000:8a2e:0370:7334
```
Chaque groupe est représenté en hexadécimal et peut avoir une valeur entre **0000 et FFFF**.

---

## 2. Structure d’une Adresse IPv6

Une adresse IPv6 est divisée en **deux parties principales** :

- **L’identifiant réseau (Network Prefix)** : Détermine le réseau auquel appartient l’adresse (généralement les 64 premiers bits).
- **L’identifiant interface (Interface ID)** : Identifie l’appareil spécifique sur le réseau (généralement les 64 derniers bits).

### **Représentation d’une adresse IPv6 :**
```
2001:0db8:85a3:0000:0000:8a2e:0370:7334
```
| **Partie Réseau** | **Partie Hôte (Interface ID)** |
|------------------|-----------------------------|
| 2001:0db8:85a3  | 0000:0000:8a2e:0370:7334   |

### **Compression des adresses IPv6**
Pour simplifier l’écriture, les **zéros consécutifs** peuvent être abrégés avec `::` (une seule fois dans une adresse) :
```
2001:db8:85a3::8a2e:370:7334
```

---

## 3. ET Logique et Détermination du Réseau en IPv6

L’opération de **ET logique (AND binaire)** est utilisée en IPv6 pour déterminer le **préfixe réseau** en appliquant le **masque de sous-réseau (Prefix Length)**.

### **Exemple de calcul du réseau avec ET logique :**

#### **Adresse IPv6 :** `2001:db8:abcd:1234:5678:9abc:def0:1234`
#### **Masque de sous-réseau :** `/64` (`FFFF:FFFF:FFFF:FFFF:0000:0000:0000:0000`)

Application du **ET logique** bit à bit :
```
2001:db8:abcd:1234:5678:9abc:def0:1234   (Adresse IPv6)
AND  FFFF:FFFF:FFFF:FFFF:0000:0000:0000:0000   (Masque /64)
------------------------------------------------------------
=    2001:db8:abcd:1234:0000:0000:0000:0000   (Préfixe réseau)
```

**Résultat :** `2001:db8:abcd:1234::/64` est le réseau IPv6 auquel appartient cette adresse.

L’ET logique permet donc d’**extraire le réseau** à partir d’une adresse IPv6 et de son masque de sous-réseau.

---

## 4. Types d'Adresses IPv6

Les adresses IPv6 sont classées en plusieurs catégories :

| **Type d’Adresse** | **Préfixe** | **Utilisation** |
|------------------|------------|----------------|
| **Unicast Global** | `2000::/3` | Adresse unique sur Internet |
| **Unicast Local** | `FC00::/7` | Utilisation privée (non routable sur Internet) |
| **Link-Local** | `FE80::/10` | Communication entre appareils sur le même lien |
| **Multicast** | `FF00::/8` | Transmission vers plusieurs hôtes |
| **Anycast** | Variable | Adresse partagée par plusieurs hôtes |

---

## 5. Notation CIDR en IPv6

Comme en IPv4, IPv6 utilise une notation CIDR pour indiquer le **préfixe réseau**.

| **Notation CIDR** | **Nombre d’adresses disponibles** |
|------------------|----------------------------|
| `/32`           | 4,3 milliards de réseaux  |
| `/48`           | 65 536 sous-réseaux        |
| `/64`           | 18,4 quintillions d’hôtes  |

Un préfixe `/64` est généralement attribué aux réseaux locaux, permettant une énorme quantité d’adresses par sous-réseau.

---

## 6. Conclusion
L’**adresse IPv6** offre une **capacité d’adressage immense** et simplifie la gestion des réseaux en supprimant le NAT et en améliorant la sécurité.

L’**ET logique** reste un outil essentiel pour déterminer les réseaux en IPv6, comme en IPv4.

Avec l’adoption croissante de l’IPv6, comprendre sa structure et son fonctionnement est **indispensable pour tout administrateur réseau**.

