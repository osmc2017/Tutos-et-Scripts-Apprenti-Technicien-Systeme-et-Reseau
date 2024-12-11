# Comprendre les ports UDP et TCP

## Introduction aux ports TCP et UDP

Les ports TCP et UDP sont des points d'extrémité numériques utilisés pour identifier des services ou des applications spécifiques dans les communications réseau. Ils permettent aux ordinateurs de différencier les différentes connexions ou services en cours d'utilisation.

### Différences entre TCP et UDP

#### TCP (Transmission Control Protocol)
- **Fiable** : Assure que les données sont livrées dans l'ordre et sans perte.
- **Connexion orientée** : Une connexion est établie avant l'envoi des données.
- **Vérification des erreurs** : Inclut des mécanismes pour garantir l'intégrité des données.
- **Applications typiques** : Transfert de fichiers (FTP), navigation web (HTTP/HTTPS), messagerie.

#### UDP (User Datagram Protocol)
- **Moins fiable** : Ne garantit pas la livraison des données ni leur ordre.
- **Sans connexion** : Les données sont envoyées sans établir de connexion préalable.
- **Faible latence** : Plus rapide, car il n'y a pas de vérification des erreurs.
- **Applications typiques** : Streaming vidéo/audio, jeux en ligne, DNS.

---

## Fonctionnement des ports

### Ports bien connus
- Les ports sont identifiés par des numéros allant de **0** à **65535**.
- Les **ports bien connus** (0-1023) sont réservés à des services standards (HTTP, SSH, DNS, etc.).

### Communication via les ports
1. Lorsqu'une application souhaite communiquer sur un réseau, elle s'ouvre un **port local**.
2. Les données sont envoyées à une **adresse IP cible** associée à un **port distant**.
3. Le protocole (TCP ou UDP) détermine le mode de transfert des données.

### Exemple de fonctionnement :
1. Un client web envoie une requête à un serveur web sur le port **80** (HTTP).
2. Le serveur écoute sur le port **80**, reçoit la requête, et répond au client.

---

## Tableau des ports les plus utilisés

| Port(s)       | Protocole                 | Description                              |
|---------------|---------------------------|------------------------------------------|
| 20, 21        | **FTP**                   | File Transfer Protocol                  |
| 22            | **SSH**                   | Secure Shell                            |
| 23            | **Telnet**                | Telnet Protocol                         |
| 25            | **SMTP**                  | Simple Mail Transfer Protocol           |
| 53            | **DNS**                   | Domain Name System                      |
| 63            | **Kerberos**              | Authentication Protocol                 |
| 80            | **HTTP**                  | HyperText Transfer Protocol             |
| 88            | **Kerberos**              | Authentication Protocol                 |
| 110           | **POP3**                  | Post Office Protocol                    |
| 143           | **IMAP**                  | Internet Message Access Protocol        |
| 161, 162      | **SNMP**                  | Simple Network Management Protocol      |
| 443           | **HTTPS**                 | HTTP Secure (TLS/SSL)                   |
| 443           | **DNS over HTTPS**        | DNS Secure (over HTTPS)                 |
| 465           | **SMTPS**                 | SMTP Secure                             |
| 489           | **SIP**                   | Session Initiation Protocol             |
| 5432          | **PostgreSQL**            | PostgreSQL Database Service             |
| 5900          | **VNC**                   | Virtual Network Computing               |
| 6379          | **Redis**                 | Redis Database Service                  |
| 6881-6889     | **BitTorrent**            | Peer-to-peer File Sharing               |
| 8006          | **RDP**                   | Remote Desktop Protocol                 |
| 989, 990      | **FTPS**                  | FTP Secure                              |
| 1194          | **OpenVPN**               | OpenVPN Protocol                        |
| 3306          | **MySQL**                 | MySQL Database Service                  |
| 636           | **LDAPS**                 | LDAP Secure                             |
---

## Points clés
- Les **ports TCP** sont utilisés lorsque la fiabilité est cruciale.
- Les **ports UDP** sont préférés pour des applications en temps réel ou sensibles à la latence.
- Bien connaître les ports permet de mieux configurer les pare-feu et les services réseau.
