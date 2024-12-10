
# Création d'un nouveau domaine Active Directory avec Hello-My-Dir (Mode Interface Graphique)

## Introduction

Ce tutoriel explique comment configurer un nouveau domaine Active Directory (AD) à l'aide de **Hello-My-Dir**, en utilisant un serveur Windows Server avec une interface graphique.

### Prérequis

Avant de commencer :
1. **Nommer la machine** : Accédez à *Paramètres système > Informations système* et définissez un nom pour le serveur.
2. **Configurer un IPv4 statique** : Via *Centre Réseau et partage > Modifier les paramètres de la carte*, configurez une adresse IP fixe.
3. **Installer les mises à jour Windows** : Utilisez *Paramètres > Windows Update* pour effectuer les mises à jour.
4. **Compte Administrateur** : Utilisez un compte Administrateur local.

## Étape 1 : Télécharger Hello-My-Dir

1. **Créez un répertoire pour les scripts** :
   - Ouvrez l'Explorateur de fichiers.
   - Accédez à `C:\`, cliquez droit, puis créez un dossier nommé **Scripts**.

2. **Téléchargez l'archive ZIP de l'outil** :
   - Rendez-vous sur la [page GitHub de Hello-My-Dir](https://github.com/LoicVeirman/Hello-My-Dir).
   - Téléchargez la dernière version de l'archive ZIP.
   - Déplacez l'archive dans le dossier `C:\Scripts`.

3. **Décompressez l'archive** :
   - Cliquez droit sur le fichier ZIP et choisissez *Extraire tout*.
   - Placez le contenu extrait dans le dossier `C:\Scripts\HelloMyDir`.

## Étape 2 : Préparer la configuration

1. **Exécutez le script principal** :
   - Ouvrez PowerShell en tant qu'administrateur (*Cliquez droit > Exécuter en tant qu’administrateur*).
   - Naviguez dans le répertoire de l'outil :
     ```powershell
     cd C:\Scripts\HelloMyDir\Hello-My-Dir-1.1.2\
     ```
   - Lancez le script :
     ```powershell
     .\Invoke-HelloMyDir.ps1
     ```

2. **Répondez aux questions** :
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

1. Relancez le script pour installer le rôle et configurer le domaine :
   ```powershell
   .\Invoke-HelloMyDir.ps1
   ```

2. Suivez le processus :
   - Installation du rôle **ADDS**.
   - Création de la forêt et du domaine AD.
   - Affichage du mot de passe **DSRM** à sauvegarder impérativement.

3. Redémarrez le serveur lorsque demandé.

## Étape 4 : Durcir la configuration

Après redémarrage, sécurisez la configuration :
```powershell
.\Invoke-HelloMyDir.ps1
```

Sauvegardez la **passphrase** du compte `DLGUSER01`.

## Étape 5 : Vérification et dépannage

- Vérifiez les journaux via PowerShell :
  ```powershell
  Get-EventLog -LogName "HelloMyDir" | fl
  ```

- Ou utilisez l'Observateur d’événements (*Démarrer > Observateur d’événements > Journaux Windows > HelloMyDir*).

## Conclusion

Le domaine Active Directory est maintenant opérationnel et sécurisé. Vous pouvez utiliser les outils graphiques (comme *Gestion Active Directory* ou *DNS*) pour administrer votre environnement.

# Ajout d'un second contrôleur de domaine avec Hello-My-Dir (Mode Interface Graphique)

## Introduction

Ce tutoriel explique comment ajouter un second contrôleur de domaine (DC) dans un domaine Active Directory existant à l'aide d'outils graphiques et de Hello-My-Dir.

---

## Prérequis

1. **Préparer le serveur cible** :
   - Nommez la machine.
   - Configurez une adresse IP statique.
   - Définissez le serveur DNS pour qu’il pointe vers le 1er contrôleur de domaine (DC).
   - Installez les dernières mises à jour Windows.

2. **Copier le fichier de configuration** :
   - Récupérez le fichier `RunSetup.xml` situé dans le dossier `Configuration` sur le 1er DC.
   - Copiez ce fichier dans le même dossier sur le second serveur.

---

## Étape 1 : Intégrer le serveur au domaine via l’interface graphique

1. **Rejoindre le domaine** :
   - Ouvrez **Paramètres > Système > Informations système**.
   - Cliquez sur **Modifier les paramètres** dans la section *Paramètres de nom d’ordinateur, de domaine et de groupe de travail*.
   - Cliquez sur **Modifier** dans l'onglet **Nom de l'ordinateur**.
   - Sélectionnez **Domaine** et entrez le nom de domaine, par exemple `test.local`.
   - Lorsque vous y êtes invité, entrez les informations d’identification du compte `DLGUSER01`.

2. **Redémarrez le serveur** lorsque demandé.

---

## Étape 2 : Promouvoir le serveur en tant que contrôleur de domaine

1. **Lancer le Gestionnaire de serveur** :
   - Cliquez sur **Démarrer > Gestionnaire de serveur**.

2. **Ajouter des rôles et fonctionnalités** :
   - Dans le Gestionnaire de serveur, cliquez sur **Ajouter des rôles et fonctionnalités**.
   - Suivez l’assistant :
     - **Type d’installation** : Sélectionnez *Installation basée sur un rôle ou une fonctionnalité*.
     - **Serveur de destination** : Choisissez le second serveur.
     - **Rôle serveur** : Sélectionnez **Services de domaine Active Directory (AD DS)**.

3. **Configurer le contrôleur de domaine** :
   - Une fois le rôle installé, cliquez sur la notification dans le Gestionnaire de serveur qui indique **Promouvoir ce serveur en contrôleur de domaine**.
   - Dans l'assistant :
     - **Configuration de déploiement** : Choisissez *Ajouter un contrôleur de domaine à un domaine existant*.
     - **Domaine** : Entrez le nom du domaine existant (`test.local`).
     - **Informations d'identification** : Utilisez les identifiants du compte `DLGUSER01`.
     - **Options supplémentaires** : Laissez les options par défaut ou ajustez selon vos besoins (par exemple, serveurs DNS ou catalogue global).
     - **Chemins d'accès** : Conservez les emplacements par défaut.

4. **Terminez l'installation et redémarrez** lorsque demandé.

---

## Étape 3 : Vérifications et tests

1. **Vérifiez la réplication AD** :
   - Ouvrez **Outils > Sites et services Active Directory**.
   - Vérifiez que les connexions entre le 1er DC et le 2e DC sont établies.

2. **Vérifiez les zones DNS** :
   - Ouvrez **Outils > DNS**.
   - Assurez-vous que les zones DNS du domaine sont synchronisées.

3. **Testez la connectivité** :
   - Dans un terminal PowerShell, exécutez :
     ```powershell
     Resolve-DnsName test.local
     ```

---

## Étape 4 : Vérifications supplémentaires avec Hello-My-Dir

- Ouvrez PowerShell et consultez les journaux Hello-My-Dir :
  ```powershell
  Get-EventLog -LogName "HelloMyDir" | fl
