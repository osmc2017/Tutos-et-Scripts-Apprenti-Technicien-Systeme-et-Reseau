# Cours sur les Ports, les Communications Multiples et les Interfaces de Connexion

## 1. Introduction

Dans les réseaux informatiques, un **port** est un identifiant numérique permettant d’associer une communication réseau à un service spécifique sur un appareil. Il permet d’acheminer les données vers la bonne application.

Chaque communication entre deux appareils utilise une **paire d’interfaces de connexion** composée de :
- **Une adresse IP (source et destination).**
- **Un port (source et destination).**

Un port est toujours associé à un **protocole de transport**, généralement **TCP** ou **UDP**.

---

## 2. Fonctionnement des Ports

Les ports sont numérotés de **0 à 65535** et sont gérés par l’**IANA (Internet Assigned Numbers Authority)**. Ils sont divisés en trois catégories :

| **Type de Ports** | **Plage** | **Utilisation** |
|------------------|----------|----------------|
| **Ports bien connus** | 0 - 1023 | Réservés aux services standards (HTTP, FTP, SSH, etc.) |
| **Ports enregistrés** | 1024 - 49151 | Attribués aux applications spécifiques par l'IANA |
| **Ports dynamiques** | 49152 - 65535 | Utilisés temporairement pour les connexions clients |

📌 **Exemple** : Une requête web utilise généralement le port 80 (HTTP) ou 443 (HTTPS) côté serveur et un **port dynamique** côté client.

---

## 3. Communications Multiples et Séparées

Les protocoles de la couche transport (**TCP et UDP**) utilisent des **numéros de port** pour gérer plusieurs communications simultanées. Chaque requête envoyée par un hôte est associée à un **numéro de port source dynamique**, tandis que le **port de destination** identifie le service demandé.

Par exemple, lorsqu’un utilisateur accède à un site web, son ordinateur génère une requête avec un **port source dynamique (ex: 1099)** et un **port de destination correspondant au service web (ex: 80 pour HTTP)**. 

Un serveur peut offrir **plusieurs services simultanément**, comme :
- **Un serveur web sur le port 80 (HTTP).**
- **Un serveur FTP sur le port 21.**

### **Exemple de communication simultanée**

| Type de Connexion | Adresse IP Source | Port Source | Adresse IP Destination | Port Destination |
|------------------|-----------------|------------|---------------------|----------------|
| **Requête Web**  | 192.168.1.5     | 1099       | 192.168.1.7         | 80 (HTTP)     |
| **Requête FTP**  | 192.168.1.5     | 1305       | 192.168.1.7         | 21 (FTP)      |

Grâce à ces ports distincts, un client peut gérer **plusieurs connexions simultanées** vers un même serveur ou plusieurs serveurs différents.

---

## 4. Paires d'Interfaces de Connexion

Chaque segment TCP ou datagramme UDP encapsule les **ports source et destination** pour identifier la connexion. Ces ports sont ensuite encapsulés dans un **paquet IP** contenant l’**adresse IP source et destination**.

### **Définition d'une interface de connexion**
Une **interface de connexion** est définie par la combinaison de :
- **Adresse IP source + Port source**
- **Adresse IP destination + Port destination**

Ainsi, une connexion est unique par la combinaison des **deux sockets** (client et serveur).

📌 **Exemple d’interface de connexion pour une requête Web :**
```
Client : 192.168.1.5:1099 → Serveur Web : 192.168.1.7:80
```

📌 **Exemple d’interface de connexion pour une requête FTP :**
```
Client : 192.168.1.5:1305 → Serveur FTP : 192.168.1.7:21
```

Lorsque le serveur répond, il **inverse les ports source et destination** :
- **Le serveur web envoie une réponse à 192.168.1.5:1099.**
- **Le serveur FTP envoie une réponse à 192.168.1.5:1305.**

### **Illustration des connexions multiples**
| IP Source | Port Source | IP Destination | Port Destination | Service |
|-----------|------------|----------------|-------------------|---------|
| 192.168.1.5 | 1099 | 192.168.1.7 | 80 | Web (HTTP) |
| 192.168.1.5 | 1305 | 192.168.1.7 | 21 | FTP |

Grâce à cette différenciation des ports, un client peut **accéder à plusieurs services simultanément**, et un serveur peut **gérer plusieurs clients en même temps**.

L’interface de connexion permet également de garantir que **les réponses sont renvoyées à l’application correcte sur l’hôte client**, évitant ainsi toute confusion entre différentes connexions en cours.

---

## 5. Principaux Ports et Protocoles Utilisés

| **Port**  | **Protocole** | **Nom complet** | **Type (TCP/UDP)** | **Couche OSI** |
|---------|-------------|------------------------------------|----------------|-------------|
| 20      | FTP        | File Transfer Protocol (Données)  | TCP            | Application |
| 21      | FTP        | File Transfer Protocol (Contrôle) | TCP            | Application |
| 22      | SSH        | Secure Shell                      | TCP            | Application |
| 23      | Telnet     | Telnet Protocol                   | TCP            | Application |
| 25      | SMTP       | Simple Mail Transfer Protocol     | TCP            | Application |
| 53      | DNS        | Domain Name System                | TCP/UDP        | Application |
| 67      | DHCP       | Dynamic Host Configuration Protocol (Serveur) | UDP | Application |
| 68      | DHCP       | Dynamic Host Configuration Protocol (Client)  | UDP | Application |
| 69      | TFTP       | Trivial File Transfer Protocol    | UDP            | Application |
| 80      | HTTP       | Hypertext Transfer Protocol       | TCP            | Application |
| 110     | POP3       | Post Office Protocol 3            | TCP            | Application |
| 119     | NNTP       | Network News Transfer Protocol (Usenet) | TCP | Application |
| 123     | NTP        | Network Time Protocol             | UDP            | Application |
| 137-139 | NetBIOS    | Network Basic Input/Output System | TCP/UDP        | Session     |
| 143     | IMAP       | Internet Message Access Protocol  | TCP            | Application |
| 161-162 | SNMP       | Simple Network Management Protocol | UDP           | Application |
| 1723    | PPTP       | Point-to-Point Tunneling Protocol | TCP            | Session     |
| 194     | IRC        | Internet Relay Chat               | TCP            | Application |
| 389     | LDAP       | Lightweight Directory Access Protocol | TCP | Application |
| 443     | HTTPS      | Hypertext Transfer Protocol Secure | TCP            | Application |
| 465     | SMTPS      | Simple Mail Transfer Protocol Secure | TCP | Application |
| 514     | Syslog     | System Logging Protocol           | UDP            | Application |
| 636     | LDAPS      | Secure LDAP                       | TCP            | Application |
| 993     | IMAPS      | Internet Message Access Protocol Secure | TCP | Application |
| 995     | POP3S      | Post Office Protocol 3 Secure     | TCP            | Application |
| 1433    | MS-SQL     | Microsoft SQL Server              | TCP            | Application |
| 1521    | Oracle SQL | Oracle Database                   | TCP            | Application |
| 3306    | MySQL      | MySQL Database                    | TCP            | Application |
| 3389    | RDP        | Remote Desktop Protocol           | TCP            | Application |
| 5060    | SIP        | Session Initiation Protocol (VoIP) | TCP/UDP       | Application |
| 5432    | PostgreSQL | PostgreSQL Database               | TCP            | Application |
| 5900    | VNC        | Virtual Network Computing         | TCP            | Application |
| 8080    | HTTP Alt   | Alternative HTTP Port             | TCP            | Application |
| 990, 989 | FTPS      | File Transfer Protocol Secure     | TCP            | Application |
| 1-65535 | TCP        | Transmission Control Protocol     | TCP            | Transport   |
| 1-65535 | UDP        | User Datagram Protocol            | UDP            | Transport   |
| -       | SCTP       | Stream Control Transmission Protocol | SCTP       | Transport   |
| -       | DCCP       | Datagram Congestion Control Protocol | DCCP       | Transport   |
| 443     | QUIC       | Quick UDP Internet Connections    | UDP            | Transport   |
| -       | IP         | Internet Protocol                 | -              | Réseau      |
| -       | ICMP       | Internet Control Message Protocol | -              | Réseau      |
| -       | IGMP       | Internet Group Management Protocol | -             | Réseau      |
| -       | ARP        | Address Resolution Protocol       | -              | Réseau      |
| -       | PPP        | Point-to-Point Protocol           | -              | Liaison de données |
| -       | Ethernet   | Ethernet Protocol                 | -              | Liaison de données |
| -       | Frame Relay | Frame Relay Protocol             | -              | Liaison de données |
| -       | RJ45, Wi-Fi, Fibre optique | Physical Network Interfaces | - | Physique |



🔹 **TCP** est utilisé pour les communications nécessitant une connexion fiable.
🔹 **UDP** est préféré pour les services en temps réel et les communications rapides.

---

## 6. Conclusion

Les **ports réseau** sont essentiels pour identifier et gérer les communications entre applications. Leur utilisation permet le **traitement simultané de plusieurs connexions** sur un même appareil.

Les **interfaces de connexion** permettent de différencier les requêtes et de s’assurer que chaque réponse retourne vers la bonne application cliente.

