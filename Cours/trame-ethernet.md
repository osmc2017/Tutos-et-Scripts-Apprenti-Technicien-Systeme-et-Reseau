# Structure de la trame Ethernet

## 1. Introduction à Ethernet
Ethernet est une technologie de réseau local (LAN) qui définit la manière dont les données sont formatées et transmises sur un réseau câblé. La trame Ethernet est l'unité de transmission de base utilisée par Ethernet.

---

## 2. Structure d'une trame Ethernet
La trame Ethernet est constituée de plusieurs champs ayant des fonctions spécifiques. Sa taille minimale est de **64 octets** et sa taille maximale est de **1518 octets** (sans VLAN) ou **1522 octets** (avec VLAN).

### Principaux champs d'une trame Ethernet :
1. **Préambule (7 octets)** → Synchronisation entre les équipements.
2. **Délimiteur de début de trame (Start Frame Delimiter - SFD, 1 octet)** → Indique le début de la trame.
3. **Adresse MAC destination (6 octets)** → Adresse du destinataire de la trame.
4. **Adresse MAC source (6 octets)** → Adresse de l'émetteur de la trame.
5. **Type/Ethertype (2 octets)** → Indique le type de protocole utilisé (IPv4, IPv6, ARP, etc.).
6. **Données/Payload (46 à 1500 octets)** → Contient les données à transmettre.
7. **FCS (Frame Check Sequence, 4 octets)** → Vérifie l'intégrité des données (CRC).

---

## 3. Schéma de la trame Ethernet
```
+------------+-------------+----------------+----------------+---------+------------------+-----+
| Préambule  | SFD (1o)    | MAC Dest (6o)  | MAC Source (6o)| Type (2o) | Données (46-1500o) | FCS |
+------------+-------------+----------------+----------------+---------+------------------+-----+
```

---

## 4. Comparaison des tailles et limitations

| **Caractéristique** | **Valeur** |
|--------------------|------------|
| Taille minimale d'une trame | 64 octets |
| Taille maximale d'une trame (standard) | 1518 octets |
| Taille maximale avec VLAN | 1522 octets |
| Taille maximale avec Jumbo Frames | Jusqu'à 9000 octets |
| Taille du champ Type/Ethertype | 2 octets |

---

## 5. Explication simplifiée
- **Le préambule et le SFD** permettent la synchronisation.
- **Les adresses MAC** identifient l’émetteur et le destinataire.
- **Le champ Type/Ethertype** informe du protocole utilisé (IPv4, IPv6, ARP...).
- **Les données transportent l'information**.
- **Le FCS (CRC)** vérifie l’intégrité des données.

---

## 6. PDU et Taille des Adresses
- **PDU (Protocol Data Unit)** : En Ethernet, le PDU s'appelle une **trame**.
- **Taille des adresses MAC** :
  - Chaque adresse MAC fait **48 bits** (6 octets).
- **Taille minimale et maximale d’une trame** :
  - **Minimum** : **64 octets** (pour éviter les collisions en half-duplex).
  - **Maximum** : **1518 octets** (sans VLAN), **1522 octets** (avec VLAN), jusqu'à **9000 octets** (Jumbo Frames pour certaines architectures).

Cela montre que **la trame Ethernet est conçue pour être efficace en LAN tout en supportant des extensions pour les réseaux modernes**.
