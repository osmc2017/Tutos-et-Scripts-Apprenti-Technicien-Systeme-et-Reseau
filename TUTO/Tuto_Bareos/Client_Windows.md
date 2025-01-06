# Tutoriel : Installation et Configuration d'un Client Bareos sur Windows (Interface Graphique)

Ce guide détaille les étapes pour installer et configurer un client Bareos sur un système Windows en utilisant l'interface graphique.

## Prérequis

- Un serveur Bareos opérationnel.
- Accès à un système Windows avec droits administratifs.
- Le fichier d'installation du client Bareos téléchargé depuis le site officiel :
  [https://download.bareos.org/](https://download.bareos.org/).
- avoir renommé le pc ??
---

## Étape 1 : Lancer l'installation

1. **Connectez-vous en tant qu'administrateur local** :
   Assurez-vous d'avoir des droits administratifs pour effectuer l'installation correctement.

2. **Exécutez le fichier d'installation** :
   Double-cliquez sur le fichier téléchargé pour lancer l'assistant d'installation.

3. **Choisissez les composants à installer** :
   Pour une installation standard, sélectionnez uniquement :
   - **Tray-Monitor** (optionnel pour surveiller le client).
   - **Open Firewall for Client** (ouvre automatiquement le port requis dans le pare-feu Windows).

4. **Suivez les étapes de l'installation** :
   Cliquez sur **Suivant** jusqu'à atteindre l'écran de configuration du client.

---

## Étape 2 : Configurer le client

Pendant l'installation, l'assistant vous demandera de remplir les informations suivantes :

### **1. Parameters for Director Connecting to This Client**

Ces paramètres permettent au Bareos Director (le serveur) de se connecter au client Bareos File Daemon.

- **Director Name** :
  - Indiquez le nom du Bareos Director configuré sur le serveur.
  - Ce nom est défini dans le fichier `bareos-dir.conf` sur le serveur, dans la section `Director`.
  - Exemple : `bareos-dir`.

- **Password** :
  - Le mot de passe utilisé par le Bareos Director pour s'authentifier auprès de ce client.
  - Ce mot de passe sera également défini dans le fichier `bareos-dir.conf`, dans la section `Client` :
    ```plaintext
    Client {
        Name = "nom_du_client-fd"
        Address = "192.168.1.50"
        Password = "mot_de_passe_du_client"
    }
    ```
  - Si vous modifiez le mot de passe sur le client, mettez à jour la configuration sur le serveur pour qu'ils correspondent.

- **Network Address** :
  - Renseignez l'adresse IP ou le nom DNS complet (FQDN) de la machine Windows (le client).
  - Exemple : `192.168.1.50` ou `client.example.com`.

### **2. Parameters for Monitor Connecting to This Client**

Ces paramètres sont utilisés si vous avez installé le Tray Monitor pour surveiller le client Bareos.

- **Client Monitor Password** :
  - Le mot de passe utilisé par le Tray Monitor pour se connecter au File Daemon.
  - Par défaut, un mot de passe est généré automatiquement lors de l'installation.
  - Vous pouvez le modifier dans le fichier de configuration si nécessaire, mais ce n'est pas obligatoire si vous n'utilisez pas le Tray Monitor.

### **3. Configuration to Access the Bareos Director (for bconsole)**

Ces paramètres permettent au client de se connecter au Bareos Director via `bconsole`.

- **Director Network Address** :
  - L'adresse IP ou le FQDN du Bareos Director (le serveur).
  - Exemple : `192.168.1.10` ou `bareos-server.example.com`.

- **Director Password** :
  - Le mot de passe défini dans la section `Console` du fichier `bareos-dir.conf` sur le serveur.
  - Exemple :
    ```plaintext
    Console {
        Name = "bconsole"
        Password = "mot_de_passe_du_director"
    }
    ```
  - Utilisez ce mot de passe pour configurer l'accès.

---

## Étape 3 : Ajouter le client au Bareos Director

### Méthode 1 : Via `bconsole`

1. **Ouvrez `bconsole` sur le serveur** :
   ```bash
   bconsole
   ```

2. **Ajoutez une ressource client au Bareos Director** :
   ```bash
   *configure add client name=nom_du_client-fd address=192.168.1.50 password=mot_de_passe_du_client
   ```
   - **name** : Le nom unique du client, par exemple `nom_du_client-fd`.
   - **address** : L'adresse IP ou le FQDN du client Windows.
   - **password** : Le mot de passe défini dans la configuration du client.

3. **Ajoutez une ressource de Job pour le client** :
   ```bash
   *configure add job name=Backup-nom_du_client client=nom_du_client-fd schedule=WeeklyCycle jobdefs=DefaultJob
   ```
   - **name** : Nom unique du Job, par exemple `Backup-nom_du_client`.
   - **client** : Le nom du client configuré, par exemple `nom_du_client-fd`.
   - **fileset** : Jeu de fichiers à sauvegarder, par exemple `Full Set`.
   - **schedule** : Planning pour exécuter le Job, par exemple `WeeklyCycle`.
   - **jobdefs** : Utilise des paramètres par défaut définis dans `DefaultJob`.

4. **Enregistrez la configuration** :
   Une fois les modifications effectuées, elles sont automatiquement prises en compte.

### Méthode 2 : Modifier manuellement le fichier de configuration

1. **Ajoutez une ressource client dans le fichier `bareos-dir.conf`** :
   ```plaintext
   Client {
       Name = "nom_du_client-fd"
       Address = "192.168.1.50"
       Password = "VOTRE_MOT_DE_PASSE"
   }
   ```

   - **Name** : Doit correspondre au nom du client configuré sur Windows.
   - **Address** : L'adresse IP ou FQDN du client Windows.
   - **Password** : Le mot de passe défini lors de la configuration.

2. **Créez une ressource de Job dans le fichier `bareos-dir.conf`** :
   ```plaintext
   Job {
       Name = "Backup-nom_du_client"
       JobDefs = "DefaultJob"
       Client = "nom_du_client-fd"
       FileSet = "Full Set"
       Schedule = "WeeklyCycle"
   }
   ```

3. **Redémarrez le Bareos Director** :
   Appliquez les modifications en redémarrant le service :
   ```bash
   systemctl restart bareos-dir
   ```

---

## Étape 4 : Vérifier la connexion

1. **Depuis le serveur Bareos** :
   Ouvrez `bconsole` et vérifiez que le client est en ligne :
   ```bash
   *status client=nom_du_client-fd
   ```

2. **Si le client n'est pas joignable** :
   - Vérifiez que le pare-feu Windows autorise le port 9102 (si l'option "Open Firewall for Client" n'a pas été sélectionnée).
   - Assurez-vous que le service Bareos File Daemon est en cours d'exécution sur le client Windows.

---

## Étape 5 : Effectuer une sauvegarde

1. **Exécutez manuellement une sauvegarde** :
   Lancez le Job depuis `bconsole` :
   ```bash
   *run job=Backup-nom_du_client
   ```

2. **Vérifiez l'état du Job** :
   Suivez l'exécution avec :
   ```bash
   *status dir
   ```

3. **Consultez les journaux** :
   Une fois terminé, affichez les journaux pour vérifier le succès de la sauvegarde :
   ```bash
   *messages
   ```

---

Votre client Bareos sur Windows est maintenant configuré et prêt à être sauvegardé par le serveur Bareos.