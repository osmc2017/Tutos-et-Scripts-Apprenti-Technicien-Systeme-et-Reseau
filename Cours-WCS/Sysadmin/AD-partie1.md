# Active Directory - Partie 1

## **Sommaire**

1. Introduction
2. Arborescence AD
3. Composants AD

---

## **1 - Introduction**

### **Qu'est-ce qu'Active Directory ?**

Active Directory (AD) est une implémentation par **Microsoft** des **services d'annuaire LDAP** pour les systèmes Windows.

📌 **Objectifs principaux** :
✅ Fournir des services centralisés **d'identification, d'authentification et de gestion des politiques**.
✅ Répertorier et gérer **les comptes utilisateurs, serveurs, postes de travail, imprimantes, etc.**

### **Origine et évolution**

- **1996** : Introduction sous le nom **NTDS (NT Directory Services)**.
- **1999** : Déploiement massif avec **Windows 2000 Server**.
- Évolution depuis **SAM (Security Account Manager)** vers un **stockage AD sur ESENT**.

📌 **Avant AD :**
🔹 **SAM (Security Account Manager)** stockait localement les comptes d’utilisateurs et groupes.
🔹 **Limité pour les grands réseaux** → nécessité d’un **annuaire centralisé et évolutif**.

### **Définition selon Microsoft**

Un **répertoire** est une **structure hiérarchique** qui stocke des informations sur les objets du réseau.
**Active Directory Domain Services (AD DS)** est un service d'annuaire permettant aux **utilisateurs et administrateurs** d’accéder et de gérer ces données.

### **AD DS : Un chef d’orchestre**

✅ Stocke et gère une **base de données hiérarchique** d’objets.
✅ Utilise **LDAP (Lightweight Directory Access Protocol)** pour interroger l'annuaire.
✅ Administrable via **GUI (Console AD) ou CLI (PowerShell)**.

📌 **Chiffres clés :**

- **Nombre max d’objets AD** : **+2 milliards**.
- **Nombre max de GPO par objet** : **999**.
- **Nombre max d’appartenances à des groupes** : **1015**.

### **LDAP : Le protocole sous-jacent**

✅ **Protocole standardisé** permettant d’accéder et de manipuler les annuaires AD.
✅ Compatible avec **GNU/Linux, OpenLDAP, SSO…**.
✅ Fonctionne comme une **BDD hiérarchique**, contrairement aux bases de données relationnelles.

📌 **Comparaison :**

| **Type**              | **Exemple**                                       |
| --------------------- | ------------------------------------------------- |
| **BDD relationnelle** | Table `Utilisateurs` avec `ID`, `Nom`, `Email`... |
| **Annuaire LDAP**     | `cn=User1,ou=users,dc=example,dc=com`             |

### **Les rôles Active Directory**

| **Rôle**   | **Fonction**                                        |
| ---------- | --------------------------------------------------- |
| **AD DS**  | Domaine, gestion des objets, authentification, GPO. |
| **AD CS**  | Gestion des certificats.                            |
| **AD FS**  | Portail SSO (Single Sign-On).                       |
| **AD RMS** | Protection et gestion des droits sur les fichiers.  |
| **AD LDS** | Service d'annuaire léger (pas de domaine).          |

---

## **2 - Arborescence AD**

📌 **Structure logique d’AD** : **Organisation indépendante des sites physiques**.

### **Objets AD**

Un objet AD est une **unité de base** dans la BDD AD. Il représente :
✅ **Utilisateurs**
✅ **Ordinateurs**
✅ **Groupes**
✅ **Services**

### **Unité d’Organisation (OU)**

- **Conteneur logique** pour organiser les objets AD.
- Permet une **gestion administrative fine**.
- Applique des **GPO (Group Policy Object)** pour centraliser la gestion des utilisateurs et ordinateurs.

📌 **Commandes PowerShell utiles** :

```powershell
Get-ADObject -Filter {Name -like "*server*"}
Get-ADOrganizationalUnit -Filter {Name -like "*serveurs*"}
```

### **Domaine AD**

- **Unité administrative et de sécurité**.
- Gère les **comptes utilisateurs, politiques de sécurité et ressources partagées**.
- **Authentification centralisée** et **contrôle d’accès**.

📌 **Avantages d’un domaine AD :**
✅ **Gestion centralisée des ressources et des utilisateurs**.
✅ **Authentification unique (SSO)** pour tous les utilisateurs du domaine.
✅ **Réplication des données** entre contrôleurs de domaine (DC).

📌 **Commandes PowerShell pour le domaine** :

```powershell
Get-ADDomain | Select-Object Name, DomainSID, DomainControllersContainer
```

### **Arbre et Forêt AD**

📌 **Arbre** : Ensemble de **domaines partageant un même espace de noms**.
📌 **Forêt** : Regroupement de **plusieurs arbres avec un schéma commun**.

✅ **Catalogue Global** :

- Référence les objets de **toute la forêt**.
- Permet de **localiser rapidement des ressources**.

📌 **Commandes PowerShell pour la forêt** :

```powershell
Get-ADForest | Select-Object Name, ForestMode, RootDomain
```

### **Workgroup vs Domaine AD**

| **Caractéristique**          | **Workgroup**                          | **Domaine AD**                         |
| ---------------------------- | -------------------------------------- | -------------------------------------- |
| **Connexion**                | Locale                                 | Centralisée                            |
| **Gestion des utilisateurs** | Manuelle                               | Centralisée via DC                     |
| **Taille**                   | Limité à quelques dizaines de machines | Scalabilité illimitée                  |
| **Sécurité**                 | Faible                                 | Élevée, via GPO et authentification AD |

📌 **DMZ et segmentation réseau** :

- **Les domaines AD peuvent être segmentés** pour renforcer la sécurité.
- Une **forêt peut contenir plusieurs domaines indépendants**.

---

## **3 - Composants AD**

### **Contrôleur de domaine (DC)**

✅ Serveur gérant **l’annuaire et l’authentification**.
✅ Indispensable au bon fonctionnement d’AD.

📌 **Commandes PowerShell pour afficher les DCs** :

```powershell
Get-ADDomainController -Filter *
```

### **RODC (Read-Only Domain Controller)**

✅ Version **en lecture seule** d’un DC.
✅ Utilisé pour **sites distants à faible connectivité**.
✅ Sécurise AD contre **les compromissions locales**.

### **Catalogue Global (GC)**

✅ Contient un **répertoire global** des objets de la forêt AD.
✅ Permet la **recherche et l’authentification inter-domaines**.

📌 **Commandes PowerShell pour le GC** :

```powershell
Get-ADForest | Select-Object GlobalCatalogs
```

---

## **Conclusion**

📌 **Active Directory est essentiel** pour la gestion des identités et des accès en entreprise.
📌 **LDAP** est le protocole fondamental pour manipuler les données AD.
📌 **L’arborescence AD** inclut **domaines, arbres et forêts** pour une gestion centralisée.
📌 **Les contrôleurs de domaine** et **catalogues globaux** assurent **l’authentification et la réplication des données**.



