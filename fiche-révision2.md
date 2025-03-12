# Fiche de Révision - Réseau, Sécurité, Linux et Active Directory

## **1. Attaques et Sécurité Réseau**

### **1.1 Attaque par Déni de Service Distribué (DDoS)**
- Un attaquant utilise un **botnet** (réseau de machines infectées) pour **inonder un serveur** de requêtes.
- Objectif : **rendre un service inaccessible**.
- Contre-mesures : **Pare-feu, anti-DDoS, limitation du trafic**.

### **1.2 ARP Spoofing**
- Technique qui consiste à **usurper une adresse MAC** pour intercepter du trafic réseau.
- Utilisée dans les attaques **Man-in-the-Middle (MITM)**.
- Protection : **Filtrage ARP, VPN, sécurisation des connexions**.

### **1.3 Attaque Brute Force**
- Essai de **toutes les combinaisons possibles** pour deviner un mot de passe.
- Protection : **Mots de passe complexes, limitation des tentatives, 2FA**.

## **2. Protocoles de Sécurité et Chiffrement**

### **2.1 Chiffrement Symétrique vs Asymétrique**
| Type          | Fonctionnement |
|--------------|----------------|
| **Symétrique** | Une seule clé est utilisée pour chiffrer et déchiffrer. |
| **Asymétrique** | Utilise une clé publique pour chiffrer et une clé privée pour déchiffrer. |

- Exemples :
  - **Symétrique** : AES, DES
  - **Asymétrique** : RSA, ECC

### **2.2 Certificat SSL/TLS**
- Utilisé pour **chiffrer les communications** entre un client et un serveur.
- Basé sur **une paire de clés publique/privée**.
- Exemples : HTTPS utilise **SSL/TLS**.

## **3. Supervision et Sécurité des Systèmes**

### **3.1 Outils de Supervision**
| Outil       | Fonction |
|------------|----------|
| Nagios     | Supervision réseau et systèmes |
| Zabbix     | Collecte et visualisation de données système |
| SIEM       | Analyse et corrélation des logs de sécurité |
| Wireshark  | Analyse des paquets réseau |

### **3.2 Fonctionnement d'un SIEM**
- **Centralise et analyse** les logs en temps réel.
- Détecte des **comportements suspects**.
- Exemples : **Splunk, Wazuh, ELK Stack**.

## **4. Commandes Linux Essentielles**

### **4.1 Gestion des Utilisateurs et Permissions**
- `adduser utilisateur` : Créer un utilisateur.
- `chown user:group fichier` : Modifier le propriétaire d'un fichier.
- `chmod 755 fichier` : Modifier les permissions.

### **4.2 Gestion des Processus**
- `ps aux` : Afficher les processus en cours.
- `top` ou `htop` : Suivi des processus en temps réel.
- `kill PID` : Terminer un processus.

### **4.3 Supervision et Logs**
- `df -h` : Vérifier l’espace disque.
- `journalctl -xe` : Voir les logs système.
- `cat /var/log/auth.log` : Vérifier les logs d’authentification.

## **5. Active Directory et Sécurité Windows**

### **5.1 Rôles d’Active Directory**
| Rôle AD  | Fonction |
|---------|----------|
| DC      | Contrôleur de domaine, authentifie les utilisateurs |
| FSMO    | Rôles essentiels à la gestion AD (RID, PDC Emulator, etc.) |
| OU      | Conteneur permettant d’organiser les objets AD |
| GPO     | Stratégies appliquées aux utilisateurs et ordinateurs |
| LDAP    | Protocole utilisé pour interroger l'annuaire AD |

### **5.2 Commandes AD à connaître**
- `netdom join NomMachine /domain:NomDomaine` : Ajouter une machine au domaine.
- `gpupdate /force` : Forcer l'application des GPO.
- `Get-ADUser -Filter *` : Lister les utilisateurs AD.

## **6. Réseau et Pare-feu**

### **6.1 Fonctionnement d’un Pare-feu**
- Filtre **le trafic réseau entrant et sortant**.
- Peut être basé sur **des règles de ports, adresses IP ou protocoles**.
- Exemples : IPTables, pfSense, Fortinet.

### **6.2 Fonctionnement du Load Balancing**
- **Répartit les requêtes** entre plusieurs serveurs pour optimiser la charge.
- Permet **la haute disponibilité**.
- Exemples : **HAProxy, Nginx, F5**.

## **7. VPN et Isolation Réseau**

### **7.1 Fonctionnement d’un VPN**
- Crée **un tunnel sécurisé** entre un client et un serveur.
- Exemples : **IPSec, OpenVPN, WireGuard**.
- Ports : **1194 (OpenVPN), 500/4500 (IPSec), 51820 (WireGuard)**.

### **7.2 Importance des VLAN**
- Segmente un réseau pour **isoler les flux sensibles**.
- Utilisé pour **différencier les services (administration, utilisateurs, invités, etc.)**.

---

🎯 **Résumé des points à réviser :**
- **Attaques réseau : DDoS, ARP Spoofing, Brute Force.**
- **Sécurité et chiffrement : SSL/TLS, asymétrique vs symétrique.**
- **Supervision et outils de monitoring : Nagios, SIEM, Wireshark.**
- **Commandes Linux essentielles : gestion des utilisateurs, logs, permissions.**
- **Active Directory : rôles, commandes, authentification.**
- **VPN, VLAN et pare-feu : gestion de la sécurité et isolation des réseaux.**

📌 **Bonne révision !**

