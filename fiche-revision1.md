# Cours : Révision des Points Clés en Réseau, Linux, Supervision et Active Directory

## **1. Protocole Réseau : BGP, NAT, DNS**

### **1.1 BGP (Border Gateway Protocol)**
- BGP est un protocole de routage utilisé sur Internet.
- Il échange les routes entre **différents systèmes autonomes (AS)**.
- Fonctionne avec un **système de priorité** pour sélectionner le meilleur chemin.
- Utilisé principalement par les **fournisseurs d’accès à Internet (FAI)**.

### **1.2 NAT (Network Address Translation)**
- Permet de **convertir des adresses IP privées** en **une seule adresse IP publique**.
- Évite la **pénurie d’adresses IPv4**.
- Trois types :
  - **NAT statique** : associe une IP privée à une IP publique.
  - **NAT dynamique** : attribue une IP publique temporaire parmi un pool.
  - **PAT (Port Address Translation)** : plusieurs IP privées partagent une seule IP publique via des ports.

### **1.3 DNS (Domain Name System)**
- Sert à **traduire les noms de domaine** en adresses IP.
- Fonctionne via une **hiérarchie de serveurs DNS**.
- Ports utilisés :
  - **53 TCP/UDP** pour les requêtes DNS.
  - **853 TCP** pour DNS sécurisé (DoT - DNS over TLS).

## **2. Commandes Linux Fondamentales**

### **2.1 Affichage de l’espace disque**
- `df -h` : Affiche l’espace disque utilisé par les partitions.
- `du -sh /dossier` : Affiche l’espace utilisé par un répertoire.

### **2.2 Processus Linux**
- `ps aux` : Liste les processus en cours.
- `top` ou `htop` : Affiche les processus actifs en temps réel.
- `kill PID` : Termine un processus via son identifiant (PID).

### **2.3 Analyse des logs Linux**
- `cat /var/log/syslog` : Affiche les logs du système.
- `journalctl -xe` : Affiche les événements récents.
- `less /var/log/auth.log` : Consulte les logs d’authentification.

### **2.4 Gestion des fichiers et permissions**
- `chmod 755 fichier` : Définit les permissions en **lecture, écriture et exécution**.
- `chown user:group fichier` : Change le propriétaire d’un fichier.
- `ln -s fichier lien` : Crée un lien symbolique vers un fichier.

## **3. Supervision et Sécurité**

### **3.1 IDS (Intrusion Detection System)**
- Un **IDS** analyse le trafic réseau et **détecte des comportements suspects**.
- **Exemples :** Snort, Suricata.

### **3.2 Honeypot**
- Un **honeypot** est un faux serveur conçu pour **attirer les attaquants**.
- Permet d’**analyser les attaques** sans compromettre le réseau réel.
- Exemples : **Cowrie, Honeyd**.

### **3.3 SIEM (Security Information and Event Management)**
- Un **SIEM** collecte, stocke et analyse les logs de sécurité.
- Aide à **détecter des menaces en temps réel**.
- Exemples : **Splunk, Wazuh, ELK (Elasticsearch, Logstash, Kibana)**.

### **3.4 Fail2Ban**
- **Fail2Ban** surveille les **tentatives de connexion infructueuses**.
- Bloque les adresses IP suspectes temporairement.
- Configuration du fichier `/etc/fail2ban/jail.conf` pour ajuster les règles.

## **4. Active Directory et Sécurité Windows**

### **4.1 Commandes de gestion Active Directory**
- `netdom join NomMachine /domain:NomDomaine` : Ajoute un ordinateur au domaine.
- `gpupdate /force` : Force l’application des GPO.
- `Get-ADUser -Filter *` : Liste tous les utilisateurs du domaine.

### **4.2 Sécurisation des accès Windows**
- **UAC (User Account Control)** : Demande une validation pour exécuter des actions sensibles.
- **GPO (Group Policy Object)** : Permet de **restreindre l’accès à certaines fonctionnalités**.
- **Kerberos** : Système d’authentification sécurisée utilisé dans Active Directory.

## **5. VPN et SSH**

### **5.1 Fonctionnement d’un VPN**
- Un **VPN (Virtual Private Network)** crée un **tunnel sécurisé** entre un utilisateur et un réseau.
- **Avantages** :
  - Chiffrement du trafic.
  - Accès distant sécurisé.
  - Contournement des restrictions géographiques.
- Protocoles VPN courants :
  - **OpenVPN** (UDP/TCP 1194).
  - **IPSec** (UDP 500, ESP 50, AH 51).
  - **WireGuard** (UDP 51820).

### **5.2 SSH et Sécurisation**
- **SSH (Secure Shell)** permet une connexion distante sécurisée.
- Ports : **22 TCP** (par défaut).
- Sécurisation :
  - Désactiver l’accès root : `PermitRootLogin no` dans `/etc/ssh/sshd_config`.
  - Utiliser une **authentification par clé** au lieu des mots de passe.
  - Changer le port SSH (`Port XXXX`).

---

🎯 **Ce cours couvre les points essentiels à réviser pour améliorer tes connaissances en Réseau, Linux, Sécurité et Active Directory.**

💡 **À faire :**
- Revoir la configuration et le rôle des **protocoles réseau (BGP, NAT, DNS, VPN, SSH)**.
- Maîtriser les **commandes Linux** pour la gestion du système et des logs.
- Comprendre les outils de **supervision (IDS, SIEM, Fail2Ban, Honeypots)**.
- Approfondir **Active Directory** et la gestion des accès.

📌 **Bonne révision !**