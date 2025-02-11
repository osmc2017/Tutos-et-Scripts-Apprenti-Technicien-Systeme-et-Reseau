# RADIUS - Remote Authentication Dial-In User Service

## **Sommaire**

1. Le contexte
2. Le fonctionnement
3. Les protocoles d'authentification
4. Traçabilité

---

## **1 - Le contexte**

### **Définition**

RADIUS (**Remote Authentication Dial-In User Service**) est un protocole AAA (**Authentication, Authorization, Accounting**) permettant la gestion centralisée de l’authentification et de l’autorisation d’accès aux ressources réseau.

- **Authentification** : Vérification de l'identité des utilisateurs.
- **Authorization** : Gestion des droits d'accès.
- **Accounting** : Suivi et journalisation des connexions.

### **Caractéristiques**

✅ Développé par Livingston en **1991**, standardisé par **RFC 2865 et 2866**.
✅ Fonctionne principalement sur **UDP 1812 (authentification) et 1813 (traçabilité)**.
✅ Initialement conçu pour l’accès distant via modem, aujourd’hui utilisé pour **WiFi, VPN, Ethernet 802.1x**.
✅ **Modèle client-serveur** :

- **Client RADIUS** : Équipements d’accès réseau (NAS, switchs, AP WiFi, VPN).
- **Serveur RADIUS** : Valide les requêtes d’authentification et applique les politiques d’accès.

### **Implémentations**

- **Serveurs RADIUS** :
  - **FreeRADIUS** (Open-source, le plus utilisé).
  - **Network Policy Server (NPS - Microsoft)**.
  - **Cisco Identity Services Engine (ISE)**.
- **Clients RADIUS** :
  - Points d’accès WiFi (mode EBSS).
  - Serveurs VPN.
  - Commutateurs Ethernet 802.1x.
  - Serveurs web (Apache).

---

## **2 - Le fonctionnement**

### **Principe général**

📌 Un **client RADIUS** (NAS) demande une authentification utilisateur.
📌 Il transmet les informations d’identification au **serveur RADIUS** via un message `Access-Request`.
📌 Le serveur consulte sa base de données et répond par :

- **Access-Accept** : Connexion autorisée.
- **Access-Reject** : Connexion refusée.
- **Access-Challenge** : Demande d’informations supplémentaires.
  📌 Possibilité de proxy RADIUS pour déléguer l’authentification à un autre serveur.

### **Format des paquets RADIUS**

| Champ                | Description                                                  |
| -------------------- | ------------------------------------------------------------ |
| **Code**             | Type de message (Access-Request, Access-Accept…).            |
| **Identifiant**      | Détection des paquets dupliqués.                             |
| **Taille**           | Longueur du paquet.                                          |
| **Authentificateur** | Valeur de 128 bits pour vérifier l’intégrité.                |
| **Attributs**        | Informations spécifiques (nom d’utilisateur, mot de passe…). |

### **Sécurité**

📌 **Secret partagé** entre le NAS et le serveur.
📌 Chiffrement **uniquement du mot de passe**, le reste des données est en clair.
📌 **Recommandation** : Utiliser IPsec ou TLS pour sécuriser les échanges.

---

## **3 - Les protocoles d'authentification**

### **PAP (Password Authentication Protocol)**

❌ **Transmission du mot de passe en clair** → Peu sécurisé.
✅ Mot de passe chiffré lors de la communication entre le NAS et le serveur RADIUS.

### **CHAP (Challenge Handshake Authentication Protocol)**

✅ Mécanisme de **challenge-réponse** basé sur un secret partagé.
✅ Le serveur envoie un **nombre aléatoire** (`Access-Challenge`).
✅ Le client répond avec un **hash du challenge + mot de passe**.
✅ Le serveur compare avec son propre calcul.
❌ Vulnérable à des attaques de force brute.

### **MS-CHAP (Microsoft CHAP)**

📌 Version améliorée de CHAP (MS-CHAPv1 - RFC 2433, MS-CHAPv2 - RFC 2749).
📌 Utilisé pour l'authentification Windows et VPN.
📌 S’appuie sur **DES** (cryptographie obsolète).

### **EAP (Extensible Authentication Protocol)**

✅ Protocole extensible permettant plusieurs méthodes d’authentification :

| Type EAP     | Description                                                      |
| ------------ | ---------------------------------------------------------------- |
| **EAP-MD5**  | Challenge MD5 (obsolète).                                        |
| **EAP-POTP** | Protected One Time Password.                                     |
| **EAP-PSK**  | Pre-Shared Key.                                                  |
| **EAP-TLS**  | Authentification par certificats (fortement recommandé).         |
| **EAP-TTLS** | Tunneled TLS (authentification sécurisée via un tunnel chiffré). |
| **EAP-SIM**  | Basé sur les cartes SIM.                                         |

📌 **EAP-TLS et EAP-TTLS sont les plus sécurisés**.
📌 **EAP est couramment utilisé dans les réseaux WiFi entreprise avec WPA2-Enterprise.**

---

## **4 - Traçabilité**

### **Pourquoi la traçabilité ?**

📌 RADIUS permet de conserver **un historique des connexions et activités réseau**.
📌 Indispensable pour **les fournisseurs d’accès, entreprises et institutions**.
📌 Permet :
✅ **Le suivi des sessions utilisateurs**.
✅ **La facturation basée sur l’usage** (FAI, hotspots WiFi).
✅ **La détection d’anomalies et incidents de sécurité**.

### **Messages RADIUS dédiés à la traçabilité**

| Message                 | Fonction                                  |
| ----------------------- | ----------------------------------------- |
| **Accounting-Request**  | Envoi des données d’activité.             |
| **Accounting-Response** | Confirmation de réception par le serveur. |

### **Stockage des logs**

📌 Deux bases de données séparées :
✅ **Base des utilisateurs** (informations d’authentification, droits d’accès).
✅ **Base comptable** (historique des connexions et ressources utilisées).
📌 Modes de stockage :

- **Fichier local** (logs).
- **Base de données SQL**.
- **Annuaire LDAP**.

---

## **5 - Considérations supplémentaires**

### **Fonctionnalités avancées**

✅ Transmission d’informations de configuration (QoS, VLAN).
✅ **Proxy RADIUS** pour déléguer les requêtes.
✅ **Redondance et haute disponibilité** (serveurs multiples).

### **Sécurisation de RADIUS**

✅ **Encapsulation avec IPsec/TLS** pour protéger les échanges.
✅ **Utilisation de clés secrètes complexes** pour éviter le rejet de paquets falsifiés.
✅ **Audit des logs** pour surveiller les connexions suspectes.

### **Concurrents de RADIUS**

| Protocole               | Description                                        |
| ----------------------- | -------------------------------------------------- |
| **Diameter (RFC 6733)** | Évolution de RADIUS, utilisé pour les réseaux LTE. |
| **TACACS+ (Cisco)**     | Plus sécurisé, gère indépendamment AAA.            |

---

## **Conclusion**

📌 **RADIUS est un protocole essentiel pour l’authentification et le contrôle d’accès réseau.**
📌 **Il prend en charge plusieurs méthodes d’authentification (PAP, CHAP, EAP).**
📌 **Il offre un mécanisme de traçabilité indispensable pour la gestion des connexions.**
📌 **Sécuriser RADIUS est essentiel, notamment en encapsulant les échanges avec IPsec ou TLS.**



