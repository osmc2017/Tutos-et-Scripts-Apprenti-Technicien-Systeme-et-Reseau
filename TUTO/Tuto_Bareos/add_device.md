### Tutoriel : Ajouter un RAID 1 comme périphérique de stockage dans Bareos

Ce tutoriel vous guide étape par étape pour configurer un RAID 1 comme périphérique de stockage dans Bareos. Nous partons du principe que le RAID 1 est déjà configuré, monté sur le système (par exemple, sur `/mnt/raid1`), et que les permissions sont correctes.

---

## 1. Déclarer le périphérique RAID 1 dans Bareos Storage Daemon

### 1.1 Accéder au répertoire des périphériques
1. Ouvrez un terminal et accédez au répertoire de configuration des périphériques :
   ```bash
   cd /etc/bareos/bareos-sd.d/device/
   ```

### 1.2 Créer un fichier de configuration pour le RAID 1
2. Créez un fichier nommé `RAID1Storage.conf` :
   ```bash
   nano RAID1Storage.conf
   ```

3. Ajoutez la configuration suivante :
   ```plaintext
   Device {
       Name = RAID1-Storage
       Media Type = File
       Archive Device = /mnt/raid1
       LabelMedia = yes
       Random Access = Yes
       AutomaticMount = yes
       RemovableMedia = no
       AlwaysOpen = YES
   }
   ```

4. Sauvegardez et quittez :
   - Appuyez sur `Ctrl + O`, puis `Entrée` pour sauvegarder.
   - Appuyez sur `Ctrl + X` pour quitter.

### 1.3 Tester la configuration
5. Vérifiez que la configuration est correcte :
   ```bash
   bareos-sd -t
   ```
   - **Résultat attendu :** Aucun message d'erreur.

6. Redémarrez le service Bareos Storage Daemon :
   ```bash
   systemctl restart bareos-sd
   ```

---

## 2. Récupérer le mot de passe du Storage Daemon

### 2.1 Vérifier le fichier de configuration du Storage Daemon
1. Ouvrez le fichier de configuration du Storage Daemon pour trouver le mot de passe associé au Director :
   ```bash
   nano /etc/bareos/bareos-sd.d/director/bareos-dir.conf
   ```

2. Localisez la ligne contenant **`Password`** dans la ressource Director :
   ```plaintext
   Director {
       Name = bareos-dir
       Password = "VotreMotDePasseIci"
   }
   ```

3. Notez ce mot de passe, il sera utilisé dans la prochaine étape.

4. Quittez l'éditeur avec `Ctrl + X`.

---

## 3. Déclarer le périphérique dans Bareos Director

### 3.1 Accéder au répertoire des configurations de stockage
1. Allez dans le répertoire des configurations de stockage :
   ```bash
   cd /etc/bareos/bareos-dir.d/storage/
   ```

### 3.2 Créer un fichier pour le stockage RAID 1
2. Créez un fichier nommé `RAID1-Storage.conf` :
   ```bash
   nano RAID1-Storage.conf
   ```

3. Ajoutez la configuration suivante :
   ```plaintext
   Storage {
       Name = RAID1-Storage
       Address = 127.0.0.1        # Adresse du Bareos Storage Daemon
       SDPort = 9103              # Port par défaut pour le Storage Daemon
       Device = RAID1-Storage     # Le périphérique configuré dans bareos-sd.d
       Media Type = File          # Doit correspondre à Media Type dans le Device
       Password = "VotreMotDePasseIci"  # Remplacez par le mot de passe noté précédemment
   }
   ```

4. Sauvegardez et quittez.

### 3.3 Tester la configuration
5. Testez la configuration du Bareos Director :
   ```bash
   bareos-dir -t
   ```
   - **Résultat attendu :** Aucun message d'erreur.

6. Redémarrez le Bareos Director :
   ```bash
   systemctl restart bareos-dir
   ```

---

## 4. Associer le périphérique RAID 1 à un Pool

### 4.1 Accéder au répertoire des Pools
1. Accédez au répertoire des configurations des Pools :
   ```bash
   cd /etc/bareos/bareos-dir.d/pool/
   ```

2. Identifiez le fichier de Pool à modifier (par exemple, `Full.conf`).

### 4.2 Modifier le fichier de Pool
3. Ouvrez le fichier du Pool, par exemple `Full.conf` :
   ```bash
   nano Full.conf
   ```

4. Ajoutez ou modifiez la ligne suivante dans le fichier :
   ```plaintext
   Storage = RAID1-Storage
   ```

   Le fichier devrait ressembler à ceci :
   ```plaintext
   Pool {
       Name = Full
       Pool Type = Backup
       Recycle = yes                       # Bareos can automatically recycle Volumes
       AutoPrune = yes                     # Prune expired volumes
       Volume Retention = 365 days         # How long should the Full Backups be kept?
       Maximum Volume Bytes = 50G          # Limit Volume size to something reasonable
       Maximum Volumes = 100               # Limit number of Volumes in Pool
       Label Format = "Full-"              # Volumes will be labeled "Full-<volume-id>"
       Storage = RAID1-Storage             # Use the RAID1-Storage device
   }
   ```

5. Sauvegardez et quittez.

### 4.3 Tester la configuration
6. Testez à nouveau la configuration du Bareos Director :
   ```bash
   bareos-dir -t
   ```

7. Redémarrez le service :
   ```bash
   systemctl restart bareos-dir
   ```

---

## 5. Créer un volume avec la commande `label`

### 5.1 Accéder à `bconsole`
1. Lancez `bconsole` :
   ```bash
   bconsole
   ```

2. Utilisez la commande `label` pour créer un volume :
   ```bash
   *label
   ```

### 5.2 Suivre les invites
3. Suivez les étapes interactives :
   - **Storage resource** : Choisissez le stockage configuré (exemple : `RAID1-Storage`).
   - **Volume Name** : Donnez un nom à votre volume (exemple : `test-backup`).
   - **Pool** : Sélectionnez le pool associé (exemple : `Full`).

   Exemple de sortie :
   ```plaintext
   Automatically selected Catalog: MyCatalog
   Using Catalog "MyCatalog"
   The defined Storage resources are:
   1: File
   2: RAID1-Storage
   Select Storage resource (1-2): 2
   Enter new Volume name: test-backup
   Defined Pools:
   1: Scratch
   2: Incremental
   3: Full
   4: Differential
   Select the Pool (1-4): 3
   Connecting to Storage daemon RAID1-Storage at 127.0.0.1:9103 ...
   Sending label command for Volume "test-backup" Slot 0 ...
   Volume successfully created.
   ```

4. Si une erreur survient, vérifiez les permissions ou le montage du répertoire de stockage.

---

## 6. Vérification dans `bconsole`

1. Connectez-vous à `bconsole` :
   ```bash
   bconsole
   ```

2. Vérifiez que le Storage est bien reconnu :
   ```bash
   *show storage
   ```

3. Vérifiez le statut du Storage Daemon :
   ```bash
   *status storage=RAID1-Storage
   ```

4. Testez une sauvegarde en utilisant le Pool configuré (par exemple, `Full`) :
   ```bash
   *run job=BackupClient1 pool=Full
   ```

---

## 7. Vérification finale

1. Consultez les Jobs terminés :
   ```bash
   *list jobs
   ```

2. Vérifiez les fichiers sauvegardés :
   ```bash
   *list files jobid=JOB_ID
   ```

3. Vérifiez physiquement sur le RAID 1 que les volumes sont créés :
   ```bash
   ls -l /mnt/raid1
   ```

---

Avec ces étapes, votre RAID 1 est correctement configuré et utilisé comme périphérique de stockage dans Bareos.

