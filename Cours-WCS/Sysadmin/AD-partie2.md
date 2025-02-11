# Active Directory - Partie 2

## **Sommaire**

1. Protocoles réseaux associés
2. Fonctionnalités avancées
3. Les objets AD
4. Bonnes pratiques d’administration

---

## **1 - Protocoles réseaux associés**

### **Liste des protocoles utilisés par AD**

✅ **DNS** → Résolution de noms et de services.
✅ **SNTP (Simple Network Time Protocol)** → Synchronisation des horloges.
✅ **LDAP/LDIF** → Communication et gestion d’annuaire.
✅ **Kerberos** → Authentification centralisée.
✅ **X.509** → Gestion des certificats.
✅ **NTFS** → Gestion des droits et permissions sur les fichiers.
✅ **SMB/CIFS** → Partage de fichiers en réseau.

### **DNS et Active Directory**

📌 **Obligatoire pour AD**.
📌 Gère la **résolution des noms** et la **localisation des services**.
📌 **Problèmes de DNS** → Risques de dysfonctionnements d’AD (authentification, réplication).

### **SNTP - La gestion du temps**

📌 **Stocke l’heure en UTC, affichée en fonction du fuseau horaire**.
📌 **Indispensable pour Kerberos** → Une mauvaise synchronisation peut causer :
✅ **Échecs d’authentification Kerberos**.
✅ **Problèmes de réplication AD**.
✅ **Échecs de connexion aux ressources**.
✅ **Problèmes de journalisation et d’audit**.

### **LDAP (Lightweight Directory Access Protocol)**

📌 **Colonne vertébrale d’AD**.
📌 Permet :
✅ **Authentification et gestion des objets AD**.
✅ **Requêtes LDAP de base** (`bind, search, add, delete, modify`).
✅ **Interopérabilité avec d’autres annuaires**.

### **LDIF (LDAP Data Interchange Format)**

📌 **Fichiers texte permettant d’interagir avec AD**.
📌 Utilisation pour **importer/exporter** des données AD.
📌 Exemple : Gestion des comptes utilisateurs via une BDD RH.

### **Kerberos - Le protocole d’authentification d’AD**

📌 **Remplace LM/NTLM depuis Windows 2000**.
📌 **Authentification mutuelle client/serveur**.
📌 Intégration avec DNS pour identifier le serveur Kerberos.

### **X.509 - Certificats et sécurité**

📌 Microsoft propose des **services de certificats compatibles X.509**.
📌 Renforce la sécurité avec :
✅ **Authentification par carte à puce**.
✅ **Chiffrement des fichiers (EFS)**.
✅ **Chiffrement réseau (IPSec)**.

---

## **2 - Fonctionnalités avancées**

### **Le niveau fonctionnel**

📌 Défini lors de la création du domaine.
📌 Dépend de la version de Windows Server utilisée.
📌 **Montée en niveau fonctionnel** :
✅ Permet d’accéder aux **nouvelles fonctionnalités**.
✅ **Prend en charge les nouveaux OS**.
❌ **Impossible de revenir en arrière**.

📌 **Exemple :**

- Un domaine avec **3 DC en Windows Server 2012 R2** et **2 DC en Windows Server 2019** aura un **niveau fonctionnel 2012 R2**.

### **Le schéma AD**

📌 **Définit les types d’objets et leurs attributs**.
📌 Équivalent des **tables et champs d’une BDD**.
📌 Exemple d’attributs pour un utilisateur :
✅ **Identifiants** : SID, GUID, nom.
✅ **Informations système** : Dernière connexion (`last-logon`).

### **La réplication AD**

📌 **Synchronisation des données entre contrôleurs de domaine (DC)**.
📌 Gère :
✅ **Base d’annuaire AD**.
✅ **GPO**.
✅ **Scripts**.
✅ **Entrées DNS**.

📌 **Processus de réplication** :

1. **DC1 modifie un objet**.
2. **Contacte le KCC (Knowledge Consistency Checker)**.
3. **KCC identifie d’autres DCs**.
4. **DC1 informe DC2 des modifications**.
5. **DC2 met à jour sa base AD**.

### **Les 5 rôles FSMO (Flexible Single Master Operation)**

📌 **Forêt** :
✅ **Maître de schéma** → Gère les mises à jour du schéma AD.
✅ **Maître d’attribution de noms** → Gère la création et suppression de domaines.

📌 **Domaine** :
✅ **Maître RID** → Gère les identifiants uniques (RID/SID).
✅ **Maître d’infrastructure** → Gère les relations entre objets.
✅ **Émulateur PDC** → Gère l’horloge, les verrouillages de comptes.

📌 **Bonnes pratiques FSMO** :
✅ **Ne pas stocker tous les rôles sur un seul DC**.
✅ **Avoir plusieurs DCs pour assurer la redondance**.
✅ **Utiliser des DC dédiés pour les rôles critiques**.

---

## **3 - Les objets AD**

### **Définition**

📌 **Un objet AD est une instance d’une classe définie dans le schéma**.
📌 **Trois types principaux d’objets** :
✅ **Ressources** (PC, dossiers partagés, imprimantes).
✅ **Utilisateurs** (comptes individuels, groupes).
✅ **Services** (serveurs, applications).

### **Les identifiants uniques d’AD**

📌 **GUID (Globally Unique Identifier)** → Identifiant unique par objet, **ne change jamais**.
📌 **SID (Security Identifier)** → Identifiant de sécurité, **change si l’objet est déplacé**.
📌 **DN (Distinguished Name)** → Chemin LDAP de l’objet AD.

### **Exemple PowerShell pour afficher les objets**

```powershell
Get-ADUser -Filter * -Properties * | Where-Object {$_.Name -eq "User1"}
```

---

## **4 - Bonnes pratiques d’administration**

### **Gestion des identités et des accès**

✅ **Principe du moindre privilège** → Attribuer **uniquement les droits nécessaires**.
✅ **Utiliser des comptes administratifs distincts**.
✅ **Sécuriser les comptes locaux avec LAPS (Local Admin Password Solution)**.

### **Sécurité et contrôle d’accès**

✅ **Renforcer la politique des mots de passe**.
✅ **Utiliser des groupes de sécurité plutôt que des permissions individuelles**.
✅ **Sécuriser les DCs** → VLAN dédié, mise à jour régulière.
✅ **Activer LDAPS (LDAP sécurisé avec SSL/TLS)**.

### **Microsoft Tiering Model** (Séparation des privilèges)

📌 **Tier 0** : DCs, PKI, ADFS (accès critique).
📌 **Tier 1** : Serveurs applicatifs.
📌 **Tier 2** : Postes de travail utilisateurs.

✅ **Un administrateur ne doit gérer que sa couche**.
✅ **Limite la propagation des attaques**.

### **JIT & JEA (Just-In-Time & Just Enough Administration)**

📌 **JIT** → Attribue les privilèges **temporairement**.
📌 **JEA** → Limite les privilèges aux **tâches spécifiques**.
📌 **Éviter les comptes à privilèges permanents**.

---

## **Conclusion**

📌 **AD repose sur plusieurs protocoles essentiels (LDAP, Kerberos, DNS)**.
📌 **Les FSMO assurent la gestion centralisée des opérations critiques**.
📌 **Les bonnes pratiques d’administration garantissent la sécurité et la robustesse d’AD**.



