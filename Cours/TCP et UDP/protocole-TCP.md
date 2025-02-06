# Cours sur le Protocole TCP

## 1. Introduction

Le **protocole TCP (Transmission Control Protocol)** est un protocole de communication de la couche **transport** du modèle **OSI**. Il est utilisé pour assurer une transmission fiable des données entre deux appareils connectés à un réseau.

TCP est un protocole **orienté connexion**, ce qui signifie qu’il établit une liaison entre l’expéditeur et le destinataire avant d’envoyer des données.

---

## 2. Caractéristiques de TCP

- **Fiable** : Garantit que toutes les données envoyées sont bien reçues et dans le bon ordre.
- **Orienté connexion** : Nécessite un établissement de connexion avant l’échange de données.
- **Contrôle de flux** : Régule l’envoi des paquets pour éviter la surcharge du destinataire.
- **Contrôle de congestion** : Ajuste la vitesse d’envoi des paquets en fonction de l’état du réseau.
- **Numérotation des segments** : Chaque segment est numéroté pour assurer l’ordre correct des données.

---

## 3. Établissement et Fermeture d’une Connexion TCP

### **1️⃣ Établissement de Connexion - Handshake en 3 étapes**

TCP utilise un **handshake en trois étapes** pour établir une connexion fiable entre deux hôtes.

1. **SYN** : Le client envoie un segment SYN au serveur pour initier la connexion.
2. **SYN-ACK** : Le serveur répond avec un segment SYN-ACK pour confirmer la demande.
3. **ACK** : Le client envoie un segment ACK, finalisant l’établissement de la connexion.

📌 Une fois ces trois étapes complétées, la communication peut commencer.

### **2️⃣ Fermeture de Connexion - Terminaison en 4 étapes**

1. **FIN** : L’un des hôtes envoie un segment FIN pour demander la fin de la connexion.
2. **ACK** : L’autre hôte accuse réception avec un segment ACK.
3. **FIN** : L’hôte répond à son tour avec un segment FIN.
4. **ACK** : Le premier hôte envoie un dernier ACK confirmant la fermeture.

📌 La connexion est alors officiellement terminée.

---

## 4. Structure de l’En-tête TCP

L’en-tête TCP est composée de 10 (partfois 11) champs essentiels permettant la gestion des communications.

### **Format de l’en-tête TCP (20 octets minimum)**

| Champ | Taille (bits) | Description |
|---------|---------------|-------------|
| **Port Source** | 16 | Numéro de port de l’émetteur |
| **Port Destination** | 16 | Numéro de port du récepteur |
| **Numéro de Séquence** | 32 | Position du premier octet des données |
| **Numéro d’Acknowledge** | 32 | Accusé de réception du dernier octet reçu |
| **Offset des données** | 4 | Longueur de l’en-tête TCP |
| **Réservé** | 3 | Champs inutilisés |
| **Flags** | 9 | Indicateurs de contrôle (SYN, ACK, FIN, etc.) |
| **Fenêtre** | 16 | Taille du tampon de réception |
| **Checksum** | 16 | Vérification d’erreur |
| **Pointeur Urgent** | 16 | Indique des données urgentes |
| **Options** | Variable | Options supplémentaires (si présentes) |

### **Explication des principaux champs :**

- **Numéro de séquence** : Permet d’ordonner les segments reçus.
- **Numéro d’ACK** : Utilisé pour confirmer la réception des segments.
- **Flags** :
  - **SYN** : Demande d’établissement de connexion.
  - **ACK** : Accusé de réception.
  - **FIN** : Demande de fermeture de connexion.
  - **RST** : Réinitialisation de connexion.
  - **PSH** : Transmission immédiate des données.
  - **URG** : Indique des données urgentes.
- **Fenêtre** : Utilisée pour le contrôle de flux, indique la quantité de données que le récepteur peut accepter.
- **Checksum** : Vérifie l’intégrité des données transmises.

---

## 5. Segmentation et Réassemblage des Données

TCP divise les données en **segments**, puis les envoie indépendamment. Chaque segment contient un **numéro de séquence** permettant au destinataire de les réassembler dans le bon ordre.

Si un segment est perdu, TCP demande **une retransmission** pour garantir l’intégrité des données.

---

## 6. Comparaison TCP vs UDP

| **Caractéristique** | **TCP** | **UDP** |
|--------------------|--------|--------|
| Fiabilité | Oui (accusés de réception, retransmission) | Non (pas de vérification) |
| Ordre des paquets | Assuré (numéros de séquence) | Non garanti |
| Contrôle de flux | Oui | Non |
| Vitesse | Plus lent (gestion d’erreurs) | Rapide (pas de contrôle d’erreur) |
| Utilisation | HTTP, FTP, SSH, emails | VoIP, DNS, streaming vidéo |

---

## 7. Conclusion

Le protocole **TCP** est un élément fondamental des communications réseau, garantissant la **fiabilité et l’ordre des transmissions**. Son mode **orienté connexion** le rend idéal pour les applications nécessitant une transmission précise des données.

