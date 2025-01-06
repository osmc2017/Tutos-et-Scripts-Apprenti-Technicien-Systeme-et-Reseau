### Tutoriel : Configurer une Sauvegarde Différentielle (Differential) avec Bareos

Ce tutoriel vous guide étape par étape pour configurer une sauvegarde différentielle (Differential) dans Bareos en utilisant les fichiers de configuration pour créer un nouveau pool et l'intégrer dans une stratégie de sauvegarde. Une sauvegarde différentielle copie uniquement les fichiers modifiés depuis la dernière sauvegarde complète (Full).

---

## **1. Créer un Pool pour les sauvegardes différentielles**

### 1.1 Accéder au répertoire de configuration
1. Ouvrez un terminal et accédez au répertoire des configurations des pools de Bareos Director :
   ```bash
   cd /etc/bareos/bareos-dir.d/pool/
   ```

### 1.2 Créer un fichier de configuration pour le Pool
2. Créez un fichier nommé `Differential.conf` :
   ```bash
   nano Differential.conf
   ```

3. Ajoutez la configuration suivante :
   ```plaintext
   Pool {
       Name = Differential
       Pool Type = Backup
       Recycle = yes
       AutoPrune = yes
       Volume Retention = 60 days
       Maximum Volume Bytes = 50G
       Maximum Volumes = 20
       Label Format = "Differential-"
   }
   ```

4. Sauvegardez et quittez l'éditeur :
   - Appuyez sur `Ctrl + O`, puis `Entrée`.
   - Appuyez sur `Ctrl + X`.

### 1.3 Tester et recharger la configuration
5. Vérifiez que la configuration est correcte :
   ```bash
   bareos-dir -t
   ```
   - **Résultat attendu** : Aucun message d'erreur.

6. Redémarrez le service Bareos Director :
   ```bash
   systemctl restart bareos-dir
   ```

7. Vérifiez que le Pool est bien créé :
   ```bash
   bconsole
   *list pools
   ```

---

## **2. Créer un Volume dans le Pool**

1. Utilisez la commande `label` dans `bconsole` pour créer un volume :
   ```bash
   bconsole
   *label
   ```

2. Suivez les invites :
   - **Storage resource** : Sélectionnez le stockage configuré (par exemple, `RAID1-Storage`).
   - **Volume Name** : Donnez un nom au volume (exemple : `Differential-001`).
   - **Pool** : Sélectionnez le pool `Differential`.

3. Vérifiez que le volume est bien créé dans le Pool :
   ```bash
   *list volumes pool=Differential
   ```

---

## **3. Créer un horaire intermédiaire**

1. Accédez au répertoire des configurations des horaires :
   ```bash
   cd /etc/bareos/bareos-dir.d/schedule/
   ```

2. Créez un fichier nommé `MidWeekDifferential.conf` :
   ```bash
   nano MidWeekDifferential.conf
   ```

3. Ajoutez la configuration suivante :
   ```plaintext
   Schedule {
       Name = MidWeekDifferential
       Run = Differential on Tuesday, Thursday at 02:00
   }
   ```

4. Sauvegardez et quittez l'éditeur.

5. Testez et rechargez la configuration :
   ```bash
   bareos-dir -t
   systemctl restart bareos-dir
   ```

6. Vérifiez le Schedule créé dans `bconsole` :
   ```bash
   bconsole
   *show schedules
   ```

---

## **4. Créer un FileSet pour définir les données à sauvegarder**

Un FileSet permet de définir les fichiers ou répertoires à sauvegarder. Pour un client Windows :

1. Accédez au répertoire des configurations des FileSets :
   ```bash
   cd /etc/bareos/bareos-dir.d/fileset/
   ```

2. Créez un fichier nommé `WindowsDifferentialFileSet.conf` :
   ```bash
   nano WindowsDifferentialFileSet.conf
   ```

3. Ajoutez la configuration suivante :
   ```plaintext
   FileSet {
       Name = WindowsDifferentialFileSet
       Enable VSS = Yes
       Include {
           Options {
               compression = GZIP
           }
           File = "C:/Users"
           File = "D:/Data"
       }
       Exclude {
           File = "C:/Users/TemporaryFiles"
       }
   }
   ```

4. Sauvegardez et quittez l'éditeur.

5. Testez et rechargez la configuration :
   ```bash
   bareos-dir -t
   systemctl restart bareos-dir
   ```

---

## **5. Créer un Job de sauvegarde différentielle**

1. Accédez au répertoire des configurations des Jobs :
   ```bash
   cd /etc/bareos/bareos-dir.d/job/
   ```

2. Créez un fichier nommé `DifferentialBackup.conf` :
   ```bash
   nano DifferentialBackup.conf
   ```

3. Ajoutez la configuration suivante :
   ```plaintext
   Job {
       Name = DifferentialBackup
       Type = Backup
       Level = Differential
       Client = WindowsClient-fd
       FileSet = WindowsDifferentialFileSet
       Schedule = MidWeekDifferential
       Storage = RAID1-Storage
       Pool = Differential
       Messages = Standard
   }
   ```

4. Sauvegardez et quittez l'éditeur.

5. Testez et rechargez la configuration :
   ```bash
   bareos-dir -t
   systemctl restart bareos-dir
   ```

6. Vérifiez le Job créé dans `bconsole` :
   ```bash
   bconsole
   *show jobs
   ```

---

## **6. Lancer un test manuel**

1. Lancez une sauvegarde différentielle pour tester la configuration :
   ```bash
   bconsole
   *run job=DifferentialBackup
   ```

2. Suivez l'exécution du Job :
   ```bash
   *status dir
   ```

3. Une fois terminé, listez les fichiers sauvegardés :
   ```bash
   *list files jobid=JOB_ID
   ```

---

## **7. Vérifications finales**

1. Consultez les Jobs planifiés pour vérifier que la sauvegarde différentielle sera automatisée :
   ```bash
   bconsole
   *list jobs
   ```

2. Vérifiez physiquement sur le stockage que les volumes sont bien créés :
   ```bash
   ls -l /mnt/raid1
   ```

---

## **Conclusion**

En suivant ce tutoriel, vous avez configuré une sauvegarde différentielle deux fois par semaine sur un client Windows à l'aide de Bareos. Voici le résultat final :

1. **Les données sauvegardées** : Tous les fichiers et dossiers modifiés depuis la dernière sauvegarde complète, spécifiés dans le FileSet (par exemple, `C:/Users` et `D:/Data`).
2. **Automatisation** : La sauvegarde différentielle s'exécute automatiquement chaque mardi et jeudi à 02:00, grâce au Schedule `MidWeekDifferential`.
3. **Gestion des volumes** : Les sauvegardes sont enregistrées dans le Pool `Differential`, utilisant des Volumes créés dans le stockage défini (par exemple, `RAID1-Storage`).
4. **Test réussi** : Vous avez testé et confirmé que la sauvegarde fonctionne correctement en exécutant un Job manuel.

Cette configuration garantit des sauvegardes différentielles régulières pour préserver vos données tout en économisant de l'espace de stockage. Si des problèmes surviennent, utilisez les journaux pour diagnostiquer :
```bash
journalctl -u bareos-dir
```

Vous pouvez désormais compter sur une solution fiable pour sauvegarder les modifications intermédiaires entre deux sauvegardes complètes. 😊

