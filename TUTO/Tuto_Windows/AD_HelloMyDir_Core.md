# Création d'un nouveau domaine Active Directory avec Hello-My-Dir en mode Core

## Introduction

Ce tutoriel explique comment configurer un nouveau domaine Active Directory (AD) à l'aide de l'outil **Hello-My-Dir**. 
L'exemple utilise Windows Server 2022 en mode Core (sans interface graphique).

### Prérequis

Avant de commencer :
1. **Nommer la machine** : Définir un nom pour le système.
2. **Configurer un IPv4 statique** : Définir une adresse IP fixe.
3. **Installer les mises à jour Windows** : Mettre à jour le système.
4. **Compte Administrateur** : Utiliser un compte Administrateur local.

## Étape 1 : Télécharger Hello-My-Dir

1. Créez un répertoire pour les scripts :
   ```powershell
   New-Item "C:\Scripts" -ItemType Directory
   ```

2. Téléchargez l'archive ZIP de l'outil :
   ```powershell
   Invoke-WebRequest -Uri "https://github.com/LoicVeirman/Hello-My-Dir/archive/refs/tags/v1.1.2.zip" -OutFile "HelloMyDir-v1.1.2.zip"
   ```

3. Décompressez l'archive :
   ```powershell
   Expand-Archive .\HelloMyDir-v1.1.2.zip
   ```

4. Placez-vous dans le répertoire extrait :
   ```powershell
   cd .\HelloMyDir-v1.1.2\Hello-My-Dir-1.1.2\
   ```

## Étape 2 : Préparer la configuration

1. Exécutez le script principal pour générer les fichiers de configuration :
   ```powershell
   .\Invoke-HelloMyDir.ps1
   ```

2. Répondez aux questions :
   - **Créer un nouveau domaine dans une nouvelle forêt ?** Répondez "Y".
   - **Nom de domaine complet (DNS)** : Exemple : `test.local`.
   - **Nom NetBIOS** : Exemple : `TEST`.
   - **Niveau fonctionnel de la forêt et du domaine** : Entrez `7` pour le plus récent.
   - **Activer la corbeille AD ?** Répondez "Y".
   - **Activer PAM ?** Répondez "N".
   - **Répertoire SYSVOL et NTDS** : Conservez les valeurs par défaut.
   - **Nom du compte de service** : `DLGUSER01` par défaut.
   - **Nom du groupe de délégation** : `LS-DLG-DomainJoin-Extended` par défaut.

Les fichiers de configuration générés se trouvent dans le dossier `Configuration`.

## Étape 3 : Créer le domaine Active Directory

1. Exécutez à nouveau le script :
   ```powershell
   .\Invoke-HelloMyDir.ps1
   ```

2. Le script :
   - Installe le rôle **ADDS**.
   - Configure les outils d'administration (AD, DNS, GPO).
   - Crée le domaine et la forêt AD.

3. À la fin, sauvegardez le mot de passe **DSRM** affiché. **Important** : Ce mot de passe est indispensable pour la restauration AD.

4. Redémarrez le serveur lorsque demandé.

## Étape 4 : Durcir la configuration

Après redémarrage, sécurisez la configuration en relançant le script :
```powershell
.\Invoke-HelloMyDir.ps1
```

Sauvegardez la **passphrase** du compte `DLGUSER01`.

## Étape 5 : Vérification et dépannage

- Utilisez l'Observateur d'événements ou PowerShell pour vérifier les journaux :
  ```powershell
  Get-EventLog -LogName "HelloMyDir" | fl
  ```

## Conclusion

Le domaine Active Directory est maintenant opérationnel. Vous pouvez gérer votre AD via les outils fournis et personnaliser la configuration selon vos besoins.

# Ajout d'un second contrôleur de domaine avec Hello-My-Dir

## Introduction

Ce tutoriel explique comment ajouter un second contrôleur de domaine (DC) dans un domaine Active Directory existant à l'aide de **Hello-My-Dir**.

### Prérequis

Avant de commencer :
1. **Préparez le serveur cible** :
   - Nommez la machine.
   - Configurez une adresse IP statique.
   - Configurez le serveur DNS pour qu'il pointe vers le 1er DC déployé.
   - Appliquez les mises à jour Windows.
2. **Copiez le fichier de configuration** :
   - Transférez le fichier `RunSetup.xml` du 1er DC vers le répertoire `Configuration` sur le nouveau serveur.
3. **Comptez sur le compte `DLGUSER01`** :
   - Ce compte doit être utilisé pour intégrer le nouveau serveur au domaine.

## Étape 1 : Intégrer le serveur au domaine

1. Connectez-vous au nouveau serveur.
2. Ouvrez PowerShell en tant qu'administrateur.
3. Naviguez dans le répertoire de Hello-My-Dir :
   ```powershell
   cd C:\Scripts\HelloMyDir\Hello-My-Dir-1.1.2\
   ```
4. Exécutez la commande pour intégrer le serveur au domaine :
   ```powershell
   .\Invoke-HelloMyDIR.ps1 -AddDC
   ```

Cette commande utilise le fichier `RunSetup.xml` pour récupérer la configuration existante du domaine.

## Étape 2 : Promouvoir le serveur comme contrôleur de domaine

1. Après avoir intégré le serveur au domaine, relancez la commande suivante :
   ```powershell
   .\Invoke-HelloMyDIR.ps1 -AddDC
   ```
2. Cette étape :
   - Configure le rôle **ADDS** sur le nouveau serveur.
   - Synchronise les données avec le 1er DC.

## Étape 3 : Vérifications post-déploiement

1. **Vérifiez la réplication** :
   - Utilisez PowerShell pour vérifier l'état de la réplication AD :
     ```powershell
     Get-ADReplicationPartnerMetadata -Target (Get-ADDomainController).Name
     ```

2. **Vérifiez les rôles FSMO** :
   - Confirmez la liste des rôles FSMO :
     ```powershell
     Get-ADForest | Select-Object SchemaMaster, DomainNamingMaster
     Get-ADDomain | Select-Object PDCEmulator, RIDMaster, InfrastructureMaster
     ```

3. **Testez la connexion DNS** :
   - Assurez-vous que le nouveau DC peut résoudre le domaine :
     ```powershell
     Resolve-DnsName test.loc  al
     ```

## Étape 4 : Gestion et dépannage

- Vérifiez les journaux Hello-My-Dir via PowerShell :
  ```powershell
  Get-EventLog -LogName "HelloMyDir" | fl
  ```

- Utilisez les outils graphiques ou en ligne de commande pour inspecter les rôles AD.

## Conclusion

Le second contrôleur de domaine est maintenant en place. Il partage les rôles AD avec le 1er DC, offrant une haute disponibilité et une redondance accrue.
