# VPN - Réseaux Privés Virtuels

## **Sommaire**
1. Le concept de VPN
2. IPsec
3. TLS
4. OpenVPN

---

## **1 - Le concept de VPN**

### **Définition**
Un **réseau privé virtuel (VPN)** permet de simuler un réseau privé en s’appuyant sur un réseau existant (public ou privé). Il assure :
✅ Un **accès sécurisé** aux ressources d’un système d’information.
✅ Un **niveau de sécurité constant**, même à travers un réseau public.
✅ Un **fonctionnement transparent**, comme si l’utilisateur était connecté localement.

### **Notion de tunnel**
Un **VPN est un tunnel sécurisé** à travers un réseau, permettant :
📌 **Encapsulation de protocoles** : Le paquet original est traité comme une donnée.
📌 **Chiffrement et authentification** : Protection contre les interceptions.
📌 **Transmission encapsulée** : L’information est intégrée dans un autre protocole.

### **Types de VPN**
| Type | Description |
|------|------------|
| **Site à site** | Interconnexion de réseaux entiers (routeurs comme extrémités). |
| **Accès distant (Host-to-Network)** | Connexion d’un client unique à un réseau d’entreprise. |
| **Point à point (Host-to-Host)** | Communication sécurisée entre deux machines spécifiques. |

### **Solutions techniques**
📌 Différents protocoles permettent de réaliser un VPN :
- **IPsec** : Intégré directement au protocole IP.
- **OpenVPN** : Basé sur TLS.
- **WireGuard, MPLS, L2TP, GRE, SSH**.

---

## **2 - IPsec (Internet Protocol Security)**

### **Définition et origine**
📌 Protocole défini par l’IETF en 1995 pour **sécuriser les communications IP**.
📌 Inclus dans **IPv6**, rétrocompatible avec **IPv4**.
📌 Utilise **trois protocoles principaux** :
- **IKEv2 (Internet Key Exchange)** : Négociation de connexion.
- **AH (Authentication Header)** : Authentification et intégrité.
- **ESP (Encapsulating Security Payloads)** : Chiffrement + authentification.

### **Modes de fonctionnement**
| Mode | Fonctionnalité |
|------|---------------|
| **Transport** | Protection du protocole de transport (TCP, UDP) tout en laissant l’en-tête IP visible. |
| **Tunnel** | Encapsulation complète du paquet IP d’origine. |

### **Cryptographie et sécurité**
📌 Assure :
✅ **Authentification et intégrité**
✅ **Confidentialité (chiffrement)**
✅ **Protection contre le rejeu**
📌 Utilise des **clés symétriques/asymétriques** avec gestion dynamique via IKEv2.

### **Security Association (SA)**
📌 Chaque connexion IPsec repose sur une **association de sécurité (SA)** qui définit :
✅ **Les cryptosystèmes utilisés**.
✅ **Les clés nécessaires**.
✅ **L’utilisation d’AH et/ou ESP**.
✅ **Le mode tunnel ou transport**.

### **Phase de négociation (IKEv2)**
📌 **IKEv2 (RFC 7296)** remplace ISAKMP.
✅ Établit un **canal sécurisé** via Diffie-Hellman.
✅ **Authentification mutuelle** par clé partagée (PSK) ou certificats.
✅ Utilisation des **ports UDP 500 et 4500** pour traverser les NAT.

---

## **3 - TLS (Transport Layer Security)**

### **Définition et historique**
📌 **Successeur de SSL**, développé par **Netscape** pour sécuriser HTTP.
📌 **Standardisé en 1999** sous le nom **TLS 1.0 (RFC 2246)**.
📌 Sécurise les **protocoles applicatifs** (HTTPS, SMTP, IMAP, etc.).
📌 Assure :
✅ **Authentification client/serveur** (certificats X.509).
✅ **Confidentialité et intégrité**.
✅ **Protection contre le rejeu** (Perfect Forward Secrecy - PFS).

### **Versions TLS recommandées**
| Version | Statut |
|---------|--------|
| **SSL 1.0 / 2.0 / 3.0** | Dépréciés (RFC 6176, 7568) |
| **TLS 1.0 / 1.1** | Dépréciés (RFC 8996) |
| **TLS 1.2** | Utilisable (RFC 5246) |
| **TLS 1.3** | Recommandé (RFC 8446) |

### **Fonctionnement TLS**
📌 **HandShake TLS** :
✅ Établissement d’un canal sécurisé via **ECDH**.
✅ Négociation des paramètres cryptographiques.
✅ Authentification du serveur (et optionnellement du client).

📌 **Une fois la connexion établie** :
✅ Échanges chiffrés via **AES 128/256 bits**.
✅ Intégrité assurée via **HMAC**.

### **Utilisations de TLS**
| Service | Protocole |
|---------|----------|
| **Web sécurisé** | HTTPS (TCP 443) |
| **Email sécurisé** | SMTPS (TCP 465), IMAPS (TCP 993) |
| **VPN sécurisé** | OpenVPN |
| **DNS sécurisé** | DoT (TCP 853) |

---

## **4 - OpenVPN**

### **Définition**
📌 **VPN libre et multiplateforme**, basé sur **TLS**.
📌 Initialement publié en **2001**.
📌 Utilise **UDP (DTLS)** ou **TCP** (port 1194 par défaut).
📌 Permet la mise en place de tunnels **niveau 2 (pont)** ou **niveau 3 (routeur)**.

### **Authentification**
✅ **Login/Mot de passe**.
✅ **Clé partagée (Pre-Shared Key - PSK)**.
✅ **Certificats X.509** via une Infrastructure à Clés Publiques (PKI).

### **Infrastructure à Clés Publiques (PKI)**
📌 Pour la gestion des certificats et des clés, il est recommandé :
✅ De générer une **PKI interne** plutôt qu’utiliser une AC externe.
✅ De stocker la **clé privée hors ligne** pour éviter les compromissions.
✅ De gérer la **révocation des certificats** via une **CRL (Certificate Revocation List)** ou **OCSP**.

### **Modes de fonctionnement**
📌 **Mode routeur (Layer 3 - TUN)** :
- Création de **pseudo-interfaces TUN** sur client et serveur.
- Transmission des **paquets IP** à travers le tunnel.

📌 **Mode pont (Layer 2 - TAP)** :
- Création de **pseudo-interfaces TAP** sur client et serveur.
- Transmission des **trames Ethernet** comme un switch.

### **Bilan OpenVPN**
✅ **Interconnexion de sites et d’hôtes via VPN**.
✅ **Mode routeur (niveau 3) ou pont (niveau 2)**.
✅ **Présent sur de nombreux firewalls et routeurs**.

---

## **Conclusion**
📌 **Un VPN permet de sécuriser l’accès à un réseau privé à travers un réseau public.**
📌 **IPsec assure une sécurité au niveau IP, tandis que TLS protège les applications.**
📌 **OpenVPN est une solution populaire et flexible basée sur TLS.**
📌 **Une bonne gestion des clés et de l’authentification est cruciale pour la sécurité.**

🎯 **La mise en place d’un VPN doit être accompagnée d’une stratégie de surveillance et d’un cloisonnement des accès.**