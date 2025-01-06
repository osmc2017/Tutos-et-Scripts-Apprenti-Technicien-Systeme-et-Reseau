### Tutoriel : Ajouter un RAID 1 comme périphérique de stockage dans Bareos

Ce tutoriel vous guide étape par étape pour configurer un RAID 1 comme périphérique de stockage dans Bareos. Nous partons du principe que le RAID 1 est déjà configuré, monté sur le système (par exemple, sur `/mnt/raid1`), et que les permissions sont correctes.

---

## 1. Préparer le périphérique RAID 1

### 1.1 Vérifier que le RAID 1 est monté et accessible
1. Assurez-vous que le RAID 1 est monté sur `/mnt/raid1` :
   ```bash
   ls -ld /mnt/raid1
   ```
   - **Résultat attendu** : Le répertoire doit être accessible avec les permissions correctes.

2. Si le répertoire n'existe pas ou n'est pas monté, montez-le manuellement :
   ```bash
   sudo mount /dev/mdX /mnt/raid1
   ```
   - Remplacez `/dev/mdX` par le nom de votre volume RAID 1.

3. Ajoutez cette configuration au fichier `/etc/fstab` pour un montage automatique à chaque démarrage.

---

## 2. Déclarer le RAID 1 dans Bareos Storage Daemon

### 2.1 Accéder au répertoire des périphériques
1. Ouvrez un terminal et accédez au répertoire de configuration des périphériques :
   ```bash
   cd /etc/bareos/bareos-sd.d/device/
   ```

### 2.2 Créer un fichier de configuration pour le RAID 1
2. Créez un fichier nommé `RAID1Storage.conf` :
   ```bash
   sudo nano RAID1Storage.conf
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
       AlwaysOpen = yes
   }
   ```

4. Sauvegardez et quittez l'éditeur :
   - Appuyez sur `Ctrl + O`, puis `Entrée` pour sauvegarder.
   - Appuyez sur `Ctrl + X` pour quitter.

### 2.3 Tester la configuration
5. Vérifiez que la configuration est correcte :
   ```bash
   bareos-sd -t
   ```
   - **Résultat attendu** : Aucun message d'erreur.

6. Redémarrez le service Bareos Storage Daemon :
   ```bash
   sudo systemctl restart bareos-sd
   ```

---

## 3. Associer le RAID 1 aux pools existants

### 3.1 Accéder au répertoire des configurations de stockage
1. Allez dans le répertoire des configurations de stockage :
   ```bash
   cd /etc/bareos/bareos-dir.d/storage/
   ```

### 3.2 Modifier ou créer un fichier de stockage pour les pools existants
2. Ouvrez ou créez un fichier nommé `RAID1-Storage.conf` :
   ```bash
   sudo nano RAID1-Storage.conf
   ```

3. Ajoutez la configuration suivante pour chaque pool existant :
   ```plaintext
   Storage {
       Name = Full-Storage
       Address = 127.0.0.1        # Adresse du Bareos Storage Daemon
       SDPort = 9103              # Port par défaut pour le Storage Daemon
       Device = RAID1-Storage     # Le périphérique configuré dans bareos-sd.d
       Media Type = File          # Doit correspondre à Media Type dans le Device
       Password = "VotreMotDePasseIci"  # Remplacez par le mot de passe du Storage Daemon
   }

   Storage {
       Name = Incremental-Storage
       Address = 127.0.0.1        # Adresse du Bareos Storage Daemon
       SDPort = 9103              # Port par défaut pour le Storage Daemon
       Device = RAID1-Storage     # Le périphérique configuré dans bareos-sd.d
       Media Type = File          # Doit correspondre à Media Type dans le Device
       Password = "VotreMotDePasseIci"  # Remplacez par le mot de passe du Storage Daemon
   }

   Storage {
       Name = Differential-Storage
       Address = 127.0.0.1        # Adresse du Bareos Storage Daemon
       SDPort = 9103              # Port par défaut pour le Storage Daemon
       Device = RAID1-Storage     # Le périphérique configuré dans bareos-sd.d
       Media Type = File          # Doit correspondre à Media Type dans le Device
       Password = "VotreMotDePasseIci"  # Remplacez par le mot de passe du Storage Daemon
   }
   ```

4. Sauvegardez et quittez l'éditeur.

### 3.3 Tester la configuration
5. Testez la configuration du Bareos Director :
   ```bash
   bareos-dir -t
   ```
   - **Résultat attendu** : Aucun message d'erreur.

6. Redémarrez le Bareos Director :
   ```bash
   sudo systemctl restart bareos-dir
   ```

---

## 4. Associer les pools existants au RAID 1

### 4.1 Accéder au répertoire des Pools
1. Accédez au répertoire des configurations des Pools :
   ```bash
   cd /etc/bareos/bareos-dir.d/pool/
   ```

### 4.2 Modifier les fichiers de Pools existants
2. Ouvrez les fichiers des Pools existants (par exemple, `Full.conf`, `Incremental.conf`, `Differential.conf`) et associez-les au stockage configuré :
   ```bash
   sudo nano Full.conf
   ```

3. Modifiez ou ajoutez la ligne suivante pour associer le pool au stockage RAID 1 :
   ```plaintext
   Storage = Full-Storage
   ```

   Exemple pour `Full.conf` :
   ```plaintext
   Pool {
       Name = Full
       Pool Type = Backup
       Recycle = yes                       # Bareos peut recycler automatiquement les Volumes
       AutoPrune = yes                     # Prune les volumes expirés
       Volume Retention = 365 days         # Durée de rétention des sauvegardes complètes
       Maximum Volume Bytes = 50G          # Limite la taille des volumes
       Maximum Volumes = 100               # Limite le nombre de volumes dans le pool
       Label Format = "Full-"              # Les volumes seront nommés "Full-<volume-id>"
       Storage = Full-Storage              # Utilise le stockage RAID1-Storage
   }
   ```

   Faites de même pour `Incremental.conf` et `Differential.conf` en remplaçant par les noms appropriés.

4. Sauvegardez et quittez chaque fichier.

### 4.3 Tester la configuration
5. Testez à nouveau la configuration du Bareos Director :
   ```bash
   bareos-dir -t
   ```

6. Redémarrez le service :
   ```bash
   sudo systemctl restart bareos-dir
   ```

---

## 5. Créer des volumes pour les Pools existants avec `bconsole`

### 5.1 Accéder à `bconsole`
1. Lancez `bconsole` :
   ```bash
   bconsole
   ```

2. Utilisez la commande `label` pour créer un volume :
   ```plaintext
   *label
   ```

### 5.2 Suivre les invites pour chaque Pool
3. Suivez les étapes interactives pour chaque Pool :
   - **Storage resource** : Choisissez le stockage configuré (exemple : `Full-Storage`, `Incremental-Storage`, ou `Differential-Storage`).
   - **Volume Name** : Donnez un nom à votre volume (exemple : `Full-01`, `Incremental-01`, ou `Differential-01`).
   - **Pool** : Sélectionnez le pool associé (exemple : `Full`, `Incremental`, ou `Differential`).

4. Vérifiez que les volumes ont été créés avec succès :
   ```plaintext
   *list volumes
   ```

---

### **Conclusion**

Avec ce tutoriel, vous avez configuré votre RAID 1 pour être utilisé par les pools existants dans Bareos. En cas de problème, consultez les journaux pour dépanner :
```bash
journalctl -u bareos-sd
journalctl -u bareos-dir
```

