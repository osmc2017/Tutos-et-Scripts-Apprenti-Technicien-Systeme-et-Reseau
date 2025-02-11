# La supervision

## **Plan**
1. Introduction
2. Les protocoles
3. En entreprise

---

## **1 - Introduction**

### **Définition générale**
La **supervision** est la surveillance du bon fonctionnement d’un **système** ou d’une **activité**.

Dans une organisation, plusieurs **systèmes de supervision** peuvent coexister et communiquer entre eux. Ils **collectent les informations**, signalent des événements et facilitent le **maintien en condition opérationnelle (MCO)**.

### **Pourquoi faire de la supervision ?**
La supervision permet :
- **Détection** : Identification des pannes et incidents
- **Modification** : Mise à jour des configurations
- **Disponibilité** : Suivi de l’utilisation des ressources
- **Optimisation des performances** : Analyse des tendances et statistiques
- **Sécurité** : Détection des activités suspectes

### **L'hypervision**
L’**hypervision** est une **centralisation** des outils de supervision d’infrastructure, d’applications et de référentiels.
- Un seul **système** collecte toutes les **informations**.
- Permet une **vision consolidée** de l’état du SI.

---

## **2 - Les protocoles**

### **SNMP (Simple Network Management Protocol)**
Protocole standard utilisé pour superviser les équipements réseau.

**Opérations de base :**
- **GET** : Demande d’informations à un agent SNMP
- **SET** : Modification de la configuration d’un équipement
- **TRAP** : Notification d’un événement spécial

📌 **Sécurité améliorée avec SNMPv3**.

### **MIB (Management Information Base)**
- Base de données stockée sur chaque équipement.
- Organisée sous forme d’**arborescence** contenant des **OID (Object Identifier)** uniques.
- Interrogée par les serveurs de supervision.

### **NetFlow (Protocole propriétaire - Cisco)**
- Collecte des informations sur le **trafic IP**.
- Utilisé pour **l’analyse des flux réseau**.

### **Autres protocoles utilisés**
- **ICMP** (Ping, vérification de connectivité)
- **WMI** (Windows Management Instrumentation, pour Windows)
- **Syslog** (Journalisation centralisée des événements)

---

## **3 - En entreprise**

### **Types de supervision**
1. **Analyse de flux** 📊
2. **Supervision réseau et système** 🌐
3. **Supervision applicative** 🖥️

### **Analyse de flux**
- Permet d’**identifier les saturations** réseau.
- Objectifs :
  - Repérer les **liaisons congestionnées**
  - Identifier l’**origine** de la consommation excessive
- Utilisation de **sondes/sniffeurs** pour collecter les données.

### **Supervision réseau et système**
- Surveillance des équipements **physiques et logiques**
- Fonctionne via **SNMP et agents**
- Collecte des **indicateurs de performance** :
  - **Température**
  - **Utilisation CPU/RAM**
  - **État des interfaces réseau**
- Affichage en **temps réel** via une interface graphique.

### **Supervision applicative**
- Se place **du point de vue de l’utilisateur final**.
- Vérifie la **disponibilité des services**.
- Complète la supervision réseau car **un service peut être indisponible même si l’infrastructure fonctionne**.
- Permet de détecter les interruptions de :
  - Serveur FTP
  - Serveur web (HTTP)
  - Applications métiers

### **Outils de supervision**

#### **Solutions propriétaires**
- **Solarwinds**
- **PRTG**
- **NextThink**

#### **Solutions Open Source**
- **Nagios**
- **Zabbix**

---

## **Conclusion**
- La **supervision** est essentielle pour **anticiper les incidents et assurer le bon fonctionnement** du SI.
- Différents **protocoles** (SNMP, NetFlow, ICMP…) sont utilisés pour **collecter les données**.
- En entreprise, elle se divise en **analyse de flux, supervision réseau et supervision applicative**.
- L’**hypervision** permet de **centraliser** toutes ces informations pour une gestion plus efficace.

🎯 **Objectif final : Garantir une infrastructure performante, disponible et sécurisée !**

