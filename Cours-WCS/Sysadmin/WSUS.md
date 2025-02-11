# WSUS (Windows Server Update Services)

## **Sommaire**

1. Introduction
2. Stratégies de déploiement
3. Surveillance et rapport
4. Configuration
5. Scénarios avancés

---

## **1 - Introduction**

### **Définition**

📌 **WSUS (Windows Server Update Services)** est un rôle intégré à Windows Server permettant la gestion centralisée des mises à jour Microsoft sur les postes et serveurs d'un réseau.
✅ **Solution gratuite** (nécessite une licence Windows Server).
✅ **Évite que chaque machine télécharge individuellement les mises à jour Microsoft**.
✅ **Permet le contrôle du déploiement des mises à jour**.

### **Pourquoi utiliser WSUS en entreprise ?**

📌 **Problèmes sans WSUS** :
❌ Machines gérant leurs mises à jour de manière autonome.
❌ Risques de redémarrages inopinés.
❌ Risque d’installation non contrôlée de mises à jour bloquant des applications critiques.

📌 **Avantages de WSUS** :
✅ Contrôle des mises à jour appliquées.
✅ Gestion des redémarrages des machines clientes.
✅ Cloisonnement des groupes de machines pour un déploiement progressif.
✅ Optimisation de la bande passante en téléchargeant les mises à jour une seule fois.

### **Historique et versions**

📌 Évolution de WSUS :

- **2002** : **SUS (Software Update Service)**
- **2005** : **WSUS v2** remplace SUS
- **2006** : **WSUS 3**
- **2012** : **WSUS 4** (Windows Server 2012, support de Windows 10)
- **2016** : **WSUS 5** (Windows Server 2016)
- **2019** : **WSUS 10** (Windows Server 2019)
- **2021** : **WSUS 10** (Windows Server 2022)

### **Alternatives à WSUS**

✅ **WSUS Offline Update** (solution libre)
✅ **WAPT** (solution propriétaire)

---

## **2 - Stratégies de déploiement**

### **Bonnes pratiques**

📌 **Patch Tuesday** :
✅ Microsoft publie les mises à jour **chaque 2ᵉ mardi du mois**.
✅ Priorité aux **mises à jour de sécurité et critiques**.
✅ **Exploit Wednesday** : Certains pirates exploitent rapidement les vulnérabilités corrigées par Microsoft, d’où l’intérêt d’un **déploiement rapide**.

### **Groupes d’ordinateurs et planification**

📌 **Cloisonnement des mises à jour** :
✅ Séparation des groupes par **OS, lieu, service, fonctionnalité**.
✅ Création de groupes spécifiques comme **TEST1, TEST2, PROD**.
✅ Planification décalée :

- **Serveurs critiques** : MAJ mensuelles.
- **Serveurs standards** : MAJ hebdomadaires.
- **Postes clients** : MAJ immédiates après validation.

---

## **3 - Surveillance et rapport**

### **Suivi des déploiements**

📌 **Tableaux de bord intégrés à WSUS** pour suivre l’état des mises à jour.
📌 Possibilité de générer des rapports détaillés :
✅ Nombre de machines mises à jour.
✅ Machines en erreur ou nécessitant une intervention.

### **Statuts des mises à jour**

📌 **Depuis le serveur WSUS** :
✅ **Non-approuvée (Unapproved)** : Disponible mais pas validée.
✅ **Approuvée (Approved)** : Prête à être installée.
✅ **Refusée (Declined)** : Exclue du déploiement.

📌 **Statuts côté client** :
✅ **Needed** : La mise à jour est requise.
✅ **Installed/Not Applicable** : Mise à jour déjà appliquée ou non concernée.
✅ **Failed** : Erreur lors de l’installation.

---

## **4 - Configuration**

### **Pré-requis matériel et logiciel**

📌 **Spécifications recommandées** :
✅ **2 CPU**
✅ **16 Go de RAM minimum**
✅ **Stockage** : 128 Go (système) + 256 Go (stockage des MAJ)
✅ **Windows Server 2016/2019/2022**

### **Configuration du serveur WSUS**

📌 **Installation du rôle** :

```powershell
Install-WindowsFeature -Name UpdateServices -IncludeManagementTools
```

✅ **Configuration via l’assistant WSUS**.
✅ **Choix des produits Microsoft à mettre à jour**.
✅ **Planification de la synchronisation avec Microsoft** (ex : 2 fois par jour).

### **Configuration des clients**

📌 **Sans Active Directory** (via stratégie locale) :
✅ Modifier `gpedit.msc` :

```
Configuration ordinateur → Modèles d'administration → Composants Windows → Windows Update
```

✅ Activer `Spécifier l’emplacement intranet du service de mise à jour Microsoft`.
✅ Définir `http://wsus:8530`.

📌 **Sans AD (via le registre)** :
✅ Modifier la clé :

```
HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate
```

✅ Ajouter :

```
WUServer (String) → http://wsus:8530
WUStatusServer (String) → http://wsus:8530
UseWUServer (DWord) → 1
```

📌 **Avec Active Directory (via GPO)** :
✅ Ouvrir la console de gestion des GPO (`gpmc.msc`).
✅ Naviguer dans :

```
Computer Configuration → Administrative Templates → Windows Components → Windows Update
```

✅ Activer `Specify Intranet Microsoft update service location`.
✅ Définir `http://wsus:8530`.
✅ Possibilité d’interdire le redémarrage automatique.

### **Maintenance du serveur WSUS**

📌 **Nettoyage régulier** avec `Server Cleanup Wizard`.
📌 **Vérification hebdomadaire** du bon téléchargement des mises à jour.
📌 **Programmation de la synchronisation automatique** (ex : 2 fois par jour).

---

## **5 - Scénarios avancés**

### **Intégration avec SCCM**

✅ **Avantages de l’intégration WSUS + SCCM** :

- Mise à jour de Windows **et** d’applications tierces.
- Meilleur contrôle sur le déploiement des MAJ.
- Surveillance avancée de l’état des systèmes.
  ✅ **WSUS devient un serveur amont**, les mises à jour étant gérées via SCCM.

### **Gestion via PowerShell**

✅ **Utilisation du module ****`UpdateServices`**.
✅ Gestion des clients (ajout, suppression d’un groupe).
✅ Gestion des mises à jour (approbation, refus, nettoyage).

### **Infrastructure multi-serveurs**

📌 **Utilisation de WSUS en mode distribué** :
✅ Serveurs WSUS locaux pour optimiser la bande passante.
✅ Hiérarchie **amont-aval** pour synchroniser les mises à jour entre plusieurs sites.

---

## **Conclusion**

📌 **WSUS est un outil puissant pour gérer les mises à jour Windows en entreprise.**
📌 **Il permet un contrôle total sur les MAJ tout en optimisant l’infrastructure.**
📌 **Une bonne planification et un suivi rigoureux sont essentiels pour garantir la sécurité et la stabilité du parc informatique.**



