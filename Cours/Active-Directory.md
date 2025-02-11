# Cours Complet sur Active Directory

## Introduction à Active Directory

### 1. Qu'est-ce qu'un Annuaire Active Directory ?
Un **annuaire Active Directory** est une base de données centralisée utilisée pour gérer et organiser les objets (utilisateurs, groupes, ordinateurs, imprimantes, etc.) au sein d'un réseau informatique. Il permet aux administrateurs système de **contrôler l'accès aux ressources**, d’**appliquer des stratégies de sécurité** et d’**organiser les objets** selon une hiérarchie logique.

Active Directory repose sur plusieurs protocoles, dont **LDAP (Lightweight Directory Access Protocol)**, **DNS (Domain Name System)** et **Kerberos**, pour assurer la communication, la gestion et l’authentification des utilisateurs et des machines du réseau.

---

## 2. Architecture et Organisation d'Active Directory

Active Directory est structuré en plusieurs niveaux hiérarchiques : **Forêt, Arbre, Domaine, Unités Organisationnelles (OU)**.

### a) La Forêt (Forest)
Une **forêt** est l’ensemble le plus large d’Active Directory. Elle regroupe plusieurs **arbres** qui peuvent avoir des noms de domaine distincts.

**Caractéristiques d’une forêt :**

- Possède un **catalogue global (Global Catalog - GC)** qui stocke des informations sur tous les objets AD.
- Peut inclure plusieurs **arbres** ayant des espaces de noms distincts.
- Établit des **relations de confiance** entre ses domaines.

```
Forêt: entreprise.local
├── Arbre 1: entreprise.local
│   ├── Domaine racine : entreprise.local
│   ├── Domaine enfant : paris.entreprise.local
│   ├── Domaine enfant : lyon.entreprise.local
│
├── Arbre 2: filiale.com
│   ├── Domaine racine : filiale.com
│   ├── Domaine enfant : support.filiale.com
│   ├── Domaine enfant : dev.filiale.com
```

### b) L'Arbre (Tree)
Un **arbre** est un ensemble de **domaines** partageant un même espace de noms DNS et étant reliés par des relations de confiance implicites.

**Caractéristiques d’un arbre :**
- Tous les domaines d’un même arbre partagent un **espace de noms DNS commun**.
- Chaque domaine d’un arbre peut avoir plusieurs sous-domaines.
- Les relations de confiance entre domaines d’un même arbre sont **automatiques et transitives**.

**Exemple :**
```
Arbre: entreprise.local
├── Domaine racine : entreprise.local
├── Domaine enfant : ventes.entreprise.local
├── Domaine enfant : support.entreprise.local
```

### c) Le Domaine (Domain)
Un **domaine** est une unité d’administration qui regroupe des utilisateurs, ordinateurs et ressources sous un même **nom de domaine DNS**.

Chaque domaine possède :
- **Une base de données AD propre** gérée par un ou plusieurs contrôleurs de domaine (DC).
- **Des règles et des stratégies de sécurité spécifiques**.
- **Des objets comme les utilisateurs, les groupes et les ordinateurs**.

### d) Les Unités Organisationnelles (OU - Organizational Units)
Les **Unités Organisationnelles (OU)** permettent de structurer les objets d’un domaine et d’appliquer des stratégies de groupe. Elles facilitent la délégation des droits et l’administration des comptes utilisateurs et des machines.

**Exemple d’organisation avec des OU :**
```
Domaine: entreprise.local
├── OU Utilisateurs
│   ├── Utilisateur1
│   ├── Utilisateur2
│
├── OU Ordinateurs
│   ├── PC-001
│   ├── PC-002
```

---

## 3. Les Composants d’un Domaine Active Directory

### a) **Nom d’utilisateur unique (sAMAccountName)**
Chaque utilisateur possède un **nom d’utilisateur unique**, aussi appelé **sAMAccountName**, qui sert d’identifiant pour la connexion.

- Il ne peut pas être dupliqué dans un même domaine.
- Il est utilisé par LDAP pour identifier un utilisateur.
- Exemple : `jdoe`, `admin`, `mdupont`.

### b) **Identifiant Sécurisé (SID - Security Identifier)**
Le **SID** est un identifiant unique attribué à chaque objet Active Directory (utilisateur, groupe, ordinateur). Il est utilisé pour gérer les permissions et les accès aux ressources.

- Chaque objet a un **SID unique** qui ne peut pas être réutilisé.
- Un utilisateur supprimé et recréé avec le même nom n'aura pas le même SID.
- Windows utilise les SID pour attribuer des autorisations.

### c) **Les Rôles FSMO (Flexible Single Master Operations)**
Active Directory repose sur **5 rôles FSMO** qui assurent la gestion centralisée de certains aspects critiques du réseau.

1. **Schema Master** : Responsable des modifications du schéma AD.
2. **Domain Naming Master** : Gère l'ajout et la suppression des domaines.
3. **RID Master** : Attribue des identifiants uniques aux objets créés.
4. **PDC Emulator** :
   - Synchronise les mots de passe.
   - Gère les mises à jour des GPO.
   - Assure la compatibilité avec les anciens systèmes NT.
5. **Infrastructure Master** : Met à jour les références inter-domaines.

### d) **Le Protocole Kerberos**
Kerberos est le **protocole d’authentification principal** utilisé par Active Directory.

- Il repose sur un **système de tickets** pour sécuriser l'accès aux ressources.
- Fonctionnement :
  1. L’utilisateur saisit ses identifiants.
  2. Un **Ticket Granting Ticket (TGT)** est délivré par le contrôleur de domaine.
  3. Ce ticket est utilisé pour obtenir des **Service Tickets** permettant l’accès aux ressources.
  4. Lorsqu'un utilisateur accède à une ressource réseau, il présente son Service Ticket, sans avoir à ressaisir son mot de passe.
- Kerberos empêche l'envoi répété de mots de passe sur le réseau, réduisant ainsi les risques de compromission.

### e) **Les Stratégies de Groupe (GPO - Group Policy Objects)**
Les **GPO** permettent d’appliquer des **règles et configurations** aux utilisateurs et ordinateurs du domaine de manière centralisée.

**Types de GPO :**
- **GPO locales** : Appliquées à un seul ordinateur.
- **GPO de domaine** : Appliquées à tous les objets d’un domaine.
- **GPO d’OU** : Appliquées aux objets contenus dans une unité organisationnelle spécifique.

---

## 6. Conclusion
Active Directory est un **système clé** pour la gestion des identités et des ressources réseau. Il repose sur une hiérarchie bien définie (**Forêt → Arbre → Domaine → OU**) et sur des **protocoles robustes (LDAP, DNS, Kerberos)**.

Grâce aux **attributs utilisateurs, aux groupes, aux GPO, aux rôles FSMO, aux SID** et aux mécanismes d’authentification comme **Kerberos**, Active Directory garantit une gestion centralisée, sécurisée et efficace des utilisateurs et ressources d’un réseau Windows.

