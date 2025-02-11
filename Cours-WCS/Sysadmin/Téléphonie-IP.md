# La Téléphonie sur IP

## **Sommaire**

1. Introduction
2. Les éléments de la ToIP
3. Le protocole SIP
4. Les évolutions réseaux

---

## **1 - Introduction**

### **Téléphonie traditionnelle vs VoIP**

📌 **RTC (Réseau Téléphonique Commuté)** :

- Technologie historique basée sur le **réseau cuivre**.
- En cours d’arrêt (2023-2030).
- Utilise un **commutateur PABX** et des **lignes analogiques ou RNIS**.

📌 **VoIP (Voice over IP)** :

- Transmission de la voix via **réseaux LAN et WAN IP**.
- Peut fonctionner sur **câble, ADSL, fibre optique, Wi-Fi, satellite**.
- Permet l’interconnexion avec le RTC via un **Trunk SIP**.

📌 **ToIP (Telephony over IP)** :

- Gestion des **réseaux téléphoniques locaux** via des équipements IP.
- Intègre des services avancés : **visioconférence, messagerie vocale, SVI**.
- Remplace progressivement les PABX par **IPBX**.

### **Évolution de la téléphonie**

📌 **Historique** :

- **1854** : Charles Bourseul imagine la transmission électrique de la voix.
- **1877** : Alexander Graham Bell crée le premier téléphone.
- **1970** : Déploiement du RTC.
- **1996** : Premiers développements de la VoIP.
- **2019** : Déploiement en entreprise → 20% utilisent la VoIP.

📌 **RNIS (Réseau Numérique à Intégration de Services)** :

- Version améliorée du RTC.
- Connexion **numérique**, ajout de services (TV, Internet).
- Utilise **T0 (2 appels simultanés) et T2 (15 à 30 appels simultanés)**.
- **Remplacé par la VoIP et le Trunk SIP**.

📌 **Différences entre RTC et VoIP** :

| Critère            | RTC                  | VoIP           |
| ------------------ | -------------------- | -------------- |
| Type de réseau     | Analogique/Numérique | 100% Numérique |
| Support            | Câblage spécifique   | IP (LAN, WAN)  |
| Gestion des appels | PABX                 | IPBX           |
| Coût               | Élevé                | Réduit         |
| Flexibilité        | Limitée              | Très flexible  |

---

## **2 - Les éléments de la ToIP**

### **Équipements nécessaires**

📌 **Terminaux IP** :
✅ Téléphones IP, ordinateurs, smartphones (softphones).
✅ Remplacent les téléphones analogiques.

📌 **Switch PoE (Power Over Ethernet)** :
✅ Alimente les téléphones IP sans adaptateur secteur.
✅ Injection de courant via câble Ethernet.

📌 **Adaptateur ATA (Analog Telephone Adapter)** :
✅ Convertit un signal **RTC** en **IP**.
✅ Ports RJ11/RJ45 pour connecter les anciens téléphones.

📌 **Softphone** :
✅ Remplace un téléphone physique par un logiciel.
✅ Compatible avec PC, smartphone, tablette.

📌 **Commutateurs téléphoniques** :

| Type        | Fonction                          |
| ----------- | --------------------------------- |
| **PABX**    | Gestion des appels sur réseau RTC |
| **IPBX**    | Gestion des appels sur réseau IP  |
| **Centrex** | Solution hébergée (Cloud)         |

📌 **Passerelle VoIP** :
✅ Convertit la téléphonie analogique vers IP.
✅ Assure l’interconnexion entre RTC et VoIP.

📌 **IPBX vs PABX** :

| Critère         | PABX       | IPBX                                    |
| --------------- | ---------- | --------------------------------------- |
| Réseau          | RTC        | IP                                      |
| Câblage         | Spécifique | Ethernet                                |
| Fonctionnalités | Limitée    | Évolutive (visioconférence, messagerie) |

---

## **3 - Le protocole SIP**

### **Définition**

📌 **SIP (Session Initiation Protocol)** :
✅ **RFC 3261** – Protocole de signalisation ouvert.
✅ Gère **l’établissement, la modification et la terminaison des appels VoIP**.
✅ Fonctionne avec **TCP (v4/v6) ou UDP (ports 5060/5061)**.
✅ Utilisé pour **téléphonie, visioconférence, IoT, VR**.

📌 **SIP vs H.323**

| Critère         | SIP             | H.323           |
| --------------- | --------------- | --------------- |
| Standardisation | RFC 3261 (IETF) | UIT-T           |
| Complexité      | Simple          | Complexe        |
| Flexibilité     | Élevée          | Moins flexible  |
| Utilisation     | VoIP, ToIP, IoT | Vidéoconférence |

### **Architecture SIP**

📌 **Composants principaux** :
✅ **User Agent (UA)** : Terminal ou softphone SIP.
✅ **Registrar** : Serveur gérant l’enregistrement des UA.
✅ **Proxy SIP** : Redirige les appels en fonction de la base de données du Registrar.
✅ **B2BUA (Back to Back User Agent)** : Proxie SIP avancé gérant toute la communication.

📌 **Établissement d’un appel SIP** :

1. **User Agent envoie une requête ****`INVITE`**** au Proxy SIP**.
2. **Le Proxy SIP interroge le Registrar pour retrouver l’IP du destinataire**.
3. **L’appel est acheminé et signalé par un ****`180 Ringing`**.
4. **Le destinataire décroche (****`200 OK`****), l’appel est établi (****`ACK`****)**.
5. **Fin de l’appel (****`BYE`**** et ****`200 OK`****)**.

📌 **Messages SIP courants** :

| Message       | Fonction                               |
| ------------- | -------------------------------------- |
| `INVITE`      | Demande d’appel                        |
| `100 Trying`  | L’appel est en cours de traitement     |
| `180 Ringing` | Le destinataire est en train de sonner |
| `200 OK`      | Connexion établie                      |
| `BYE`         | Fin d’appel                            |

---

## **4 - Les évolutions réseaux**

### **Trunk SIP**

📌 **Remplace les T0/T2 du RNIS**.
✅ Permet à un **IPBX** de communiquer avec un opérateur VoIP.
✅ Aucun **nombre fixe de canaux** (évolutif selon besoin).
✅ Utilise **Internet** au lieu de lignes dédiées.

📌 **Schéma Trunk SIP**

```
Internet  ----->  IPBX  ----->  Téléphones IP
```

### **Centrex IP**

📌 Solution **cloud** pour la téléphonie d’entreprise.
✅ Centralise les services de téléphonie.
✅ Élimine la gestion d’un **PABX/IPBX en local**.
✅ Moins coûteux, mais dépendant du fournisseur.

📌 **Schéma Centrex**

```
Internet  ----->  Centrex Cloud  ----->  Téléphones IP
```

### **Fin du RTC et passage à la VoIP**

📌 **Arrêt progressif du RTC d’ici 2030** (ARCEP).
📌 **Migration massive des entreprises vers la VoIP**.
📌 **Essor du cloud et du Centrex**.

---

## **Conclusion**

📌 **ToIP remplace progressivement le RTC grâce à la VoIP et SIP.**
📌 **IPBX et Trunk SIP permettent une flexibilité accrue.**
📌 **Les entreprises doivent migrer avant 2025 pour éviter les coupures du RTC.**
📌 **Le cloud (Centrex IP) offre une solution évolutive et économique.**



