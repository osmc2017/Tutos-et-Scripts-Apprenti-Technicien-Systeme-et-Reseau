# Journalisation

## **Sommaire**

1. Introduction
2. Journalisation sous GNU/Linux
3. Journalisation sous Windows

---

## **1 - Introduction**

### **Définition des journaux**

Les applications et les systèmes d’exploitation enregistrent des traces de leur activité, appelées **journaux d’événements** ou **logs**. Ces journaux :
✅ Peuvent être **des fichiers texte, des bases de données** ou d’autres formats.
✅ Ont des formats variés, choisis par les développeurs.

### **Utilité des journaux**

📌 **Pour les développeurs** : Débogage des erreurs.
📌 **Pour les administrateurs** : Compréhension des dysfonctionnements.
📌 **Pour la cybersécurité** : Détection des intrusions.

### **Historique et conservation**

✅ Idéalement, **tous les journaux devraient être analysés en temps réel**.
✅ Nécessité de conserver un **historique** pour :

- **Analyser des événements passés**.
- **Faire des corrélations entre plusieurs événements**.

### **Quelle information journaliser ?**

📌 Dépend du contexte :
✅ **Cybersécurité** : Échecs de connexion, requêtes suspectes…
✅ **Administration système** : Anomalies, erreurs critiques…
✅ **Besoin d’un niveau de journalisation ajusté** pour ne pas générer trop de données inutiles.

### **Stockage et archivage**

📌 L’enregistrement massif des journaux peut saturer le stockage.
✅ Solution : **Rotation et compression des logs**.
✅ Nécessité de **concilier conservation et espace disque**.

### **Centralisation et standardisation**

📌 Problèmes courants :

- **Emplacement dispersé des journaux**.
- **Formats différents selon les logiciels**.
  ✅ Solutions : **Centralisation des logs** et **utilisation de formats standards**.

---

## **2 - Journalisation sous GNU/Linux**

### **Syslog : Le standard UNIX**

📌 Développé pour **Sendmail** dans les années 80.
✅ **Séparation des responsabilités** :

- Génération des messages.
- Stockage et traitement.
  ✅ **Protocole IETF RFC 5424**
  ✅ Ports standards : **514/UDP, 6514/TCP (syslog sécurisé TLS)**.

### **Format des logs Syslog**

✅ Contient :

- Date
- Hôte émetteur
- Service/Processus concerné
- Identifiant de processus
- **Catégorie & Niveau de sévérité**
- Message textuel

### **Catégories Syslog**

📌 Syslog définit **24 catégories**, numérotées de **0 à 23**.
✅ **8 dernières catégories (16-23) sont réservées à un usage local**.

### **Niveaux de gravité Syslog**

| Niveau | Signification                     |
| ------ | --------------------------------- |
| 0      | Urgence (systeme inutilisable)    |
| 1      | Alerte (action immédiate requise) |
| 2      | Critique                          |
| 3      | Erreur                            |
| 4      | Avertissement                     |
| 5      | Notification                      |
| 6      | Information                       |
| 7      | Débogage                          |

### **Stockage et consultation des logs**

✅ **Stockage par défaut** : `/var/log/*`
✅ **Exemples :**

- **auth.log** → Événements d’authentification.
- **kern.log** → Messages du noyau.
  ✅ **Consultation des logs :**

```bash
cat /var/log/syslog | grep error
journalctl -xe
```

### **Rotation et archivage des logs**

✅ **`logrotate`** permet de :

- **Archiver et compresser** automatiquement les anciens logs.
- **Les supprimer après une durée définie**.

```bash
man logrotate
```

### **Systemd et ****`journalctl`**

📌 **Systemd inclut son propre mécanisme de journalisation**
✅ Stockage binaire (`/run/systemd/journal`).
✅ **Consultation avec ****`journalctl`** :

```bash
journalctl -u sshd --since "yesterday"
```

✅ Compatible avec **Syslog**.

### **Outils d’analyse des logs**

📌 **Automatisation possible** avec :
✅ **logwatch** : Rapports quotidiens.
✅ **Graylog, ELK (Elasticsearch, Logstash, Kibana)** : Analyse avancée.
✅ **SIEM (Security Information and Event Management)** : Sécurité.

---

## **3 - Journalisation sous Windows**

### **L’Observateur d’événements (Event Viewer)**

📌 **Journal centralisé de Windows**.
✅ Contient des **informations système, erreurs, alertes**.
✅ Fichiers logs stockés dans : `C:\Windows\System32\winevt\Logs`

### **Accès à l’Event Viewer**

📌 Différentes méthodes :
✅ `eventvwr.msc` via `Exécuter`.
✅ **Outils d’administration Windows**.
✅ **Server Manager** (Windows Server).

### **Types de journaux**

✅ **Affichages personnalisés** : Filtres sur les événements.
✅ **Journaux Windows** : Logs liés au système.
✅ **Journaux d’applications et services** : Logs spécifiques aux logiciels.
✅ **Abonnements** : **Centralisation des logs de plusieurs machines**.

### **Niveau de criticité et Event ID**

📌 **Trois niveaux de criticité** :
✅ **High (Élevé)** : Événements critiques nécessitant une action immédiate.
✅ **Medium (Moyen)** : Événements importants mais non bloquants.
✅ **Low (Faible)** : Informations générales.

### **Exemples d’Event ID utiles**

| **Event ID** | **Description**                           |
| ------------ | ----------------------------------------- |
| 4624         | Connexion réussie                         |
| 4625         | Échec de connexion                        |
| 4740         | Compte verrouillé                         |
| 4728         | Ajout d’un utilisateur à un groupe global |
| 4663         | Tentative d’accès à des objets            |
| 1102         | Suppression des journaux                  |

### **Parsing et analyse des logs**

✅ **Regex pour filtrer les événements**.
✅ **Automatisation avec PowerShell** :

```powershell
Get-EventLog -LogName Security -Newest 10
```

✅ **Outils avancés** : SIEM (Splunk, Microsoft Sentinel).

---

## **Conclusion**

📌 **Les journaux sont indispensables pour l'administration système et la cybersécurité.**
📌 **La journalisation sous Linux repose sur Syslog et Systemd, tandis que Windows utilise l'Observateur d’événements.**
📌 **L’analyse des logs peut être automatisée avec des outils comme Logwatch, Graylog ou des SIEM.**



