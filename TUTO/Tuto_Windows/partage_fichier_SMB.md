# Tutoriel : Installation du rôle File Server sur Windows Server

## Prérequis
- Avoir un serveur Windows Server (2012, 2016, 2019, ou 2022).
- Accès administrateur sur le serveur.

## Étapes d'installation

### 1. Ouvrir le Server Manager
- Ouvrez le **Server Manager** (via la barre des tâches ou le menu Démarrer).

### 2. Add Roles and Features
- Dans le **Server Manager**, cliquez sur **Manage** dans le coin supérieur droit.
- Sélectionnez **Add Roles and Features**.

### 3. Démarrer l'Assistant d'installation
- Cliquez sur **Next** pour avancer dans l'assistant.
- Sélectionnez **Role-based or feature-based installation** et cliquez sur **Next**.

### 4. Sélectionner le rôle File Server
- Aller dans **File and Storage Services** et dérouler.
- Dérouler également **File and iSCSI Services.
- Cochez **File Server** dans la liste des rôles puis sur **Next**.
- Cliquez sur **Next** jusqu'à la page de confirmation, puis cliquez sur **Installer**.
- L'installation prendra quelques minutes. Une fois terminée, cliquez sur **Fermer**.

---

## Création du partage SMB

## Prérequis

- se rendre à la racine c:\ et créer un dossier **Documents_Entreprise** avec les 3 sous dossiers:
    - RH
    - Comptabilité
    - Direction

### 1. Etapes start the New Share Wizard
- Dans le **server manager** aller dans **Fle and Storage Services** puis dans **shares** et enfin selectionner **To create a file share, start the New Share Wizard**

### 2. Configurations
- Dans notre cas on choisi **SMB Share - Quick** puis on clique sur **Next**.
- On choisi la localisation de notre dossier créé précédemment dans **Type a custom path** puis **Next**.
- On nomme notre partage (Docs pour l'exercice), on vérifie que les chemins sont correct puis **Next**.
- On configure les options de partage: on choisi **Enable access-based enumeration** dans notre cas afin que les utilisateurs n'est accés que aux dossier auxquels ils ont droit.dans le dossier partager, puis on clique sur **Next**.
- On configurera cette partie plus tard et on clique sur **next**.
- et maintenant on clique sur **Create** afin de créer otre partage puis **close**.

### 3. Configuration des droits de partage

Maintenant que notre dossier de partage est operationnel on retourne sur nos sous dossier pour définir les règle de partage:

#### A. Dossiser RH
- On clique droit sur le dossier RH puis **Properties** et l'onglet **Security**.
- Dans la partie **Group or user names:** il faut sélectionner le groupe **RH** puis dans **Permissions for RH** donner les droits **Read** et **Write**
- Dans la partie **Group or user names:** il faut sélectionner le groupe **Direction** puis dans **Permissions for Comptabilité** donner les droits **Read** et **Write**

#### A. Dossiser Comptabilité
- On clique droit sur le dossier Comptabilité puis **Properties** et l'onglet **Security**.
- Dans la partie **Group or user names:** il faut sélectionner le groupe **Comptabilité** puis dans **Permissions for Comptabilité** donner les droits **Read** et **Write**
- Dans la partie **Group or user names:** il faut sélectionner le groupe **Direction** puis dans **Permissions for Comptabilité** donner les droits **Read** et **Write**

#### A. Dossiser Comptabilité
- On clique droit sur le dossier Direction puis **Properties** et l'onglet **Security**.
- Dans la partie **Group or user names:** il faut sélectionner le groupe **Direction** puis dans **Permissions for Comptabilité** donner les droits **Read** et **Write**

### 4. Vérification avec PowerShell

Pour vérifier les partages on utilise la commande 'Get-SmbShare' dans PowerShell et on peut voir que nos dossiers sont bien partagé.

---

## Configuration des lecteurs réseau sur les clients

### 1. Méthode CLI

- Ouvrir l'Explorateur de fichiers.
- Clique droit sur **Ce PC** puis **Connecter un lecteur réseau**.
- Choisir une lettre de lecteur.
- Entrer le chemin du partage (ex:\\nom_serveur\Docs).
- Cocher **Se reconnecter à l'ouverture de session** si désiré
- Cliquer sur **Terminer**.

### 2. Méthode PowerShell

- Pour mapper un lecteur il faut taper la commande suivante:
'New-PSDrive -Name "Z" -PSProvider FileSystem -Root "\\NOM_DU_SERVEUR\Docs" -Persist'.
- Vous devriez maintenant voir votre dossier partager dans **l'explorateur de fichier** sous la forme **Docs(\\NOM_DU_SERVEUR)

