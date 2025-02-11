# DNS - Domain Name System

## **Sommaire**

1. Introduction
2. Les noms de domaine
3. Le protocole DNS
4. Les enregistrements DNS
5. Enregistrer un nom de domaine
6. Outils et commandes DNS

---

## **1 - Introduction**

### **Pourquoi DNS ?**

- Les adresses IP (IPv4 : 32 bits, IPv6 : 128 bits) sont difficiles à mémoriser.
- **DNS (Domain Name System)** permet de convertir des noms de domaine en adresses IP.
- Initialement géré via un fichier `HOSTS.TXT`, remplacé par un système décentralisé.

### **Caractéristiques du DNS**

✅ **Base de données répartie et décentralisée** → Fiabilité et scalabilité.
✅ **Technologie d’infrastructure invisible** pour l’utilisateur.
✅ **Associe un nom à plusieurs types d’informations** (adresses IP, emails, certificats, etc.).

---

## **2 - Les noms de domaine**

### **Définition**

- Un **nom de domaine** est un identifiant **unique, hiérarchique et stable**.
- Séparé en plusieurs parties (labels) par des `.` (ex: `www.example.com`).

### **Structure hiérarchique**

| Niveau                     | Exemple               |
| -------------------------- | --------------------- |
| **Racine** (`.`)           | `.`                   |
| **TLD (Top Level Domain)** | `.com`, `.org`, `.fr` |
| **Domaine Secondaire**     | `example.com`         |
| **Sous-domaine**           | `www.example.com`     |

### **Internationalized Domain Name (IDN)**

- Support des caractères non-ASCII (`exemple.fr`, `中国.com`).
- Codage en **Punycode** (`xn--exemple-9xa.com`).

---

## **3 - Le protocole DNS**

### **Caractéristiques du protocole**

✅ **Protocole client-serveur** (couche 7 - application).
✅ Utilisation de **UDP 53** (principalement) et **TCP 53** (grandes réponses, transferts de zone).
✅ **DNS over TLS (DoT)** et **DNS over HTTPS (DoH)** pour sécuriser les requêtes.

### **Types de serveurs DNS**

| Type                         | Rôle                                                              |
| ---------------------------- | ----------------------------------------------------------------- |
| **Serveur racine**           | Contient les TLD (ex: `.com`, `.fr`).                             |
| **Serveur TLD**              | Gère les domaines de second niveau.                               |
| **Serveur faisant autorité** | Détient les enregistrements DNS d’un domaine.                     |
| **Résolveur DNS (cache)**    | Répond aux requêtes clients en cherchant les données nécessaires. |

### **Processus de résolution DNS**

1. L’utilisateur interroge un **stub resolver** (ex: `dig example.com`).
2. Le résolveur DNS consulte son **cache**.
3. Si absent, il interroge les **serveurs racines** (`.`).
4. Ceux-ci redirigent vers le **TLD** (`.com`).
5. Le TLD redirige vers le **serveur faisant autorité** (`example.com`).
6. La réponse est transmise au client.

### **Exemples de résolveurs DNS publics**

| Fournisseur    | IPv4                 | IPv6                   |
| -------------- | -------------------- | ---------------------- |
| **Google**     | `8.8.8.8`, `8.8.4.4` | `2001:4860:4860::8888` |
| **Cloudflare** | `1.1.1.1`, `1.0.0.1` | `2606:4700:4700::1111` |
| **Quad9**      | `9.9.9.9`            | `2620:fe::fe`          |

---

## **4 - Les enregistrements DNS**

### **Définition**

- Chaque **nom de domaine** est associé à un ou plusieurs **Resource Records (RR)**.
- Ces enregistrements sont stockés sur les **serveurs faisant autorité**.

### **Principaux types d’enregistrements**

| Type    | Fonction                                      |
| ------- | --------------------------------------------- |
| `A`     | Associe un domaine à une IPv4.                |
| `AAAA`  | Associe un domaine à une IPv6.                |
| `NS`    | Indique les serveurs faisant autorité.        |
| `CNAME` | Alias vers un autre domaine.                  |
| `MX`    | Serveur de messagerie du domaine.             |
| `PTR`   | Résolution inverse (IP → domaine).            |
| `TXT`   | Stocke des informations diverses (SPF, DKIM). |
| `SOA`   | Décrit la zone DNS (Start of Authority).      |

### **Résolution inverse (Reverse DNS - PTR)**

- Associe une **adresse IP** à un **nom de domaine**.
- Utilise le **domaine spécial** `.in-addr.arpa` (IPv4) ou `.ip6.arpa` (IPv6).
- Ex: `192.168.1.1 → 1.1.168.192.in-addr.arpa → example.com`.

### **Round Robin DNS**

- Technique de **répartition de charge**.
- Une requête DNS retourne différentes adresses IP à chaque demande.

---

## **5 - Enregistrer un nom de domaine**

### **Gestion des domaines**

- **ICANN** gère la racine et délègue les TLD aux **registries** (ex: **AFNIC** pour `.fr`).
- Un **bureau d’enregistrement** (ex: **OVH, Gandi**) vend les noms de domaine.
- L’acheteur doit configurer ses **serveurs DNS** ou utiliser ceux de son fournisseur.

### **Types de TLD**

| Type                  | Exemples                 |
| --------------------- | ------------------------ |
| **ccTLD (Code Pays)** | `.fr`, `.de`, `.jp`      |
| **gTLD (Générique)**  | `.com`, `.org`, `.net`   |
| **sTLD (Sponsorisé)** | `.gov`, `.edu`, `.mil`   |
| **nTLD (Nouveaux)**   | `.tech`, `.shop`, `.xyz` |

---

## **6 - Outils et commandes DNS**

### **Principaux outils d’interrogation**

| Outil      | OS        | Usage                        |
| ---------- | --------- | ---------------------------- |
| `dig`      | Linux/Mac | Requête DNS avancée.         |
| `nslookup` | Windows   | Requête DNS basique.         |
| `host`     | Linux     | Recherche d’enregistrements. |

### **Exemples d'utilisation**

#### **Rechercher l’adresse IP d’un domaine**

```bash
dig example.com A
```

```powershell
nslookup example.com
```

#### **Trouver le serveur de messagerie d’un domaine**

```bash
dig example.com MX
```

#### **Résolution inverse (PTR)**

```bash
dig -x 8.8.8.8
```

---

## **Conclusion**

📌 **DNS est un système hiérarchique et distribué permettant la résolution de noms en adresses IP.**
📌 **Il repose sur des serveurs faisant autorité, des résolveurs et un ensemble de records DNS.**
📌 **Les entreprises et particuliers doivent enregistrer et configurer leurs noms de domaine auprès d’un bureau d’enregistrement.**
📌 **Des outils comme ****`dig`**** et ****`nslookup`**** permettent de diagnostiquer les problèmes DNS.**



