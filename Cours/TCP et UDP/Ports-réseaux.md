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

| **Port** | **Service/Protocole** | **Protocole de Transport** |
|---------|----------------------|---------------------------|
| 20      | FTP (Données)        | TCP |
| 21      | FTP (Contrôle)       | TCP |
| 22      | SSH                  | TCP |
| 23      | Telnet               | TCP |
| 25      | SMTP (Email)         | TCP |
| 53      | DNS                  | UDP/TCP |
| 67      | DHCP (Serveur)       | UDP |
| 68      | DHCP (Client)        | UDP |
| 80      | HTTP                 | TCP |
| 110     | POP3 (Email)         | TCP |
| 119     | NNTP (Usenet)        | TCP |
| 123     | NTP (Synchronisation) | UDP |
| 143     | IMAP (Email)         | TCP |
| 161     | SNMP                 | UDP |
| 194     | IRC                  | TCP |
| 443     | HTTPS                | TCP |
| 465     | SMTPS                | TCP |
| 514     | Syslog               | UDP |
| 993     | IMAPS                | TCP |
| 995     | POP3S                | TCP |
| 3306    | MySQL                | TCP |
| 3389    | RDP (Bureau à distance) | TCP |
| 5060    | SIP (VoIP)           | UDP/TCP |
| 5432    | PostgreSQL           | TCP |
| 5900    | VNC                  | TCP |
| 8080    | HTTP alternatif      | TCP |

🔹 **TCP** est utilisé pour les communications nécessitant une connexion fiable.
🔹 **UDP** est préféré pour les services en temps réel et les communications rapides.

---

## 6. Conclusion

Les **ports réseau** sont essentiels pour identifier et gérer les communications entre applications. Leur utilisation permet le **traitement simultané de plusieurs connexions** sur un même appareil.

Les **interfaces de connexion** permettent de différencier les requêtes et de s’assurer que chaque réponse retourne vers la bonne application cliente.

