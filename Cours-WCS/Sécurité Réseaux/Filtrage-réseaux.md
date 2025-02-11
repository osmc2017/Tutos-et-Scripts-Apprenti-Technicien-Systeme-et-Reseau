# Filtrage Réseau

## **Sommaire**

1. Introduction
2. Sécurisation du réseau
3. Types de pare-feux

---

## **1 - Introduction**

### **Qu'est-ce qu'un firewall ?**

Un **pare-feu** (*firewall*, garde-barrière, coupe-feu) est un dispositif permettant de **contrôler et filtrer le trafic réseau**. Il fonctionne **au moins au niveau 4** (transport : TCP, UDP…) et est souvent associé à des fonctions de **routage**.

📌 **Objectif :** Fournir une **connectivité maîtrisée** entre réseaux de **différents niveaux de confiance**.

### **Architecture réseau**

Un pare-feu est généralement placé **entre un réseau interne et un réseau externe (Internet, autre réseau)**. Il inspecte les **paquets entrants, sortants et traversants**, et prend une **décision basée sur des règles** :

- **Accept** (autoriser)
- **Drop** (bloquer sans notification)
- **Reject** (bloquer avec notification)

### **Principe du filtrage**

- Analyse **des en-têtes protocolaires**.
- Vérification **du contenu des paquets**.
- Contrôle **des utilisateurs et de l’heure d’accès**.

---

## **2 - Sécurisation du réseau**

### **Pourquoi filtrer ?**

🔹 **Les systèmes ont des failles de sécurité**.
🔹 **Les configurations par défaut peuvent être vulnérables**.
🔹 **Des services réseau inutiles sont souvent activés**.

📌 **Le filtrage réseau limite l’exposition aux attaques !**

### **Stratégies de défense**

#### **Défense périmétrique**

✅ **Limiter le trafic entrant et sortant**.
✅ **Protéger le réseau interne des menaces extérieures**.
✅ **Implémenter un filtrage strict pour réduire les risques**.

#### **Défense en profondeur**

🔹 Ne pas faire aveuglément confiance aux pare-feux !
🔹 Ajouter plusieurs couches de sécurité :

- Antivirus, IDS/IPS, segmentation réseau, authentification renforcée.
- Surveillance et journalisation des activités.

### **Politique de filtrage**

#### **Deux approches**

| Approche                 | Principe                             | Inconvénients                        |
| ------------------------ | ------------------------------------ | ------------------------------------ |
| **Liste de blocage**     | Bloquer les paquets suspects         | Risque d’oublier certaines menaces   |
| **Liste d’autorisation** | Bloquer tout sauf le trafic légitime | Plus sécurisé mais plus contraignant |

📌 **La liste d’autorisation est fortement recommandée !**

### **Segmentation du réseau**

- Regrouper les **hôtes ayant les mêmes exigences de sécurité**.
- Appliquer un **filtrage entre les zones**.
- Associer la segmentation à des **VLANs** ou **cloisonnement physique**.

### **DMZ (DeMilitarized Zone)**

Certains services doivent être accessibles depuis l’extérieur (mail, web, DNS). Ils sont placés dans une **zone DMZ** :
✅ Surveillance et filtrage renforcé.
✅ Limite les risques d’attaques directes sur le réseau interne.

---

## **3 - Types de pare-feux**

### **1. Pare-feu sans état (*****Stateless Firewall*****)**

🔹 **Filtrage simple basé sur les en-têtes des paquets**.
🔹 Analyse :

- **Adresses source et destination**.
- **Ports TCP/UDP**.
- **Protocoles utilisés**.
  🔹 **Avantages :** Rapide, efficace.
  🔹 **Inconvénients :** Traite chaque paquet indépendamment, règles potentiellement complexes.

### **2. Pare-feu à états (*****Stateful Firewall*****)**

🔹 **Suit l’état des connexions TCP/UDP**.
🔹 **Autorisation implicite des réponses**.
🔹 **Vérification contextuelle** des paquets entrants.
🔹 **Avantages :**

- Permet un **filtrage plus précis**.
- Réduit la complexité des règles.
  🔹 **Inconvénients :**
- Nécessite plus de ressources (mémoire, CPU).

### **3. Pare-feu applicatif (*****Application Firewall*****)**

🔹 **Inspection approfondie des paquets (DPI - Deep Packet Inspection)**.
🔹 Déroule **l’intégralité de la pile protocolaire**.
🔹 Vérifie **la conformité du protocole utilisé**.
🔹 Permet le filtrage des protocoles complexes (ex : FTP).
🔹 **Inconvénients :**

- Impossible d’analyser un flux **chiffré de bout en bout**.
- Exige une **connaissance approfondie des protocoles**.

📌 **Cas spécifique :**
✅ **WAF (Web Application Firewall)** : Filtrage spécifique des applications web HTTP/HTTPS.

### **4. Pare-feux personnels**

🔹 **Filtrage logiciel** appliqué à une machine spécifique.
🔹 Permet un **filtrage interactif** des connexions entrantes et sortantes.
🔹 **Inconvénient :** Moins sécurisé qu’un pare-feu réseau.

---

## **Conclusion**

📌 **Un pare-feu est essentiel pour sécuriser un réseau**.
📌 **Différentes approches existent (stateless, stateful, applicatif).**
📌 **Une segmentation efficace et l’usage des DMZ renforcent la sécurité.**
📌 **Le choix d’une politique de filtrage stricte réduit les risques d’intrusion.**



