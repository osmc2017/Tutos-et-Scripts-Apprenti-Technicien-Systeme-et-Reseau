### Tutoriel : Configurer une sauvegarde incrémentale quotidienne avec Bareos

Ce tutoriel vous guide étape par étape pour configurer une sauvegarde incrémentale quotidienne dans Bareos en utilisant exclusivement `bconsole`. Nous partons du principe que Bareos est déjà installé et fonctionnel et que le client est une machine Windows.

---

## **1. Créer un Pool pour les sauvegardes incrémentales**

### 1.1 Accéder à `bconsole`
1. Ouvrez `bconsole` :
   ```bash
   bconsole
   ```

### 1.2 Créer un Pool
2. Utilisez la commande `create pool` :
   ```bash
   *create pool
   ```

3. Remplissez les informations demandées :
   - **Nom du Pool** : `Incremental`
   - **Pool Type** : `Backup`
   - **Recycle** : `yes`
   - **AutoPrune** : `yes`
   - **Volume Retention** : `30 days`
   - **Maximum Volume Bytes** : `50G`
   - **Label Format** : `Incremental-`

4. Vérifiez le Pool créé :
   ```bash
   *list pools
   ```

---

## **2. Créer un Volume dans le Pool**

1. Utilisez la commande `label` pour créer un volume :
   ```bash
   *label
   ```

2. Suivez les invites :
   - **Storage resource** : Sélectionnez le stockage configuré (par exemple, `RAID1-Storage`).
   - **Volume Name** : Donnez un nom au volume (exemple : `Incremental-001`).
   - **Pool** : Sélectionnez le pool `Incremental`.

3. Vérifiez que le volume est bien créé dans le Pool :
   ```bash
   *list volumes pool=Incremental
   ```

---

## **3. Créer un horaire quotidien**

1. Utilisez la commande `create schedule` :
   ```bash
   *create schedule
   ```

2. Remplissez les informations demandées :
   - **Nom du Schedule** : `DailyIncremental`
   - **Run Statement** : `Incremental daily at 20:00`

3. Vérifiez le Schedule créé :
   ```bash
   *show schedules
   ```

---

## **4. Créer un FileSet pour définir les données à sauvegarder**

Un FileSet permet de définir les fichiers ou répertoires à sauvegarder. Pour un client Windows :

1. Utilisez la commande `create fileset` :
   ```bash
   *create fileset
   ```

2. Remplissez les informations demandées :
   - **Nom du FileSet** : `WindowsIncrementalFileSet`
   - **Include** : Indiquez les répertoires ou disques à sauvegarder. Par exemple :
     ```plaintext
     "C:/Users"  
     "D:/Data"
     ```
   - **Exclude** (optionnel) : Spécifiez les fichiers ou répertoires à exclure. Par exemple :
     ```plaintext
     "C:/Users/TemporaryFiles"
     ```

3. Vérifiez le FileSet créé :
   ```bash
   *show filesets
   ```

---

## **5. Créer un Job de sauvegarde incrémentale**

1. Utilisez la commande `create job` :
   ```bash
   *create job
   ```

2. Remplissez les informations demandées :
   - **Nom du Job** : `IncrementalBackup`
   - **Job Type** : `Backup`
   - **Level** : `Incremental`
   - **Client** : Indiquez le nom du client Windows (par exemple, `WindowsClient-fd`).
   - **FileSet** : `WindowsIncrementalFileSet`
   - **Schedule** : `DailyIncremental`
   - **Storage** : Sélectionnez le stockage configuré (par exemple, `RAID1-Storage`).
   - **Pool** : `Incremental`
   - **Messages** : `Standard`

3. Vérifiez le Job créé :
   ```bash
   *show jobs
   ```

---

## **6. Créer un Volume supplémentaire si nécessaire**

Si votre Pool nécessite plusieurs Volumes pour gérer les sauvegardes :

1. Utilisez à nouveau la commande `label` pour ajouter un Volume :
   ```bash
   *label
   ```

2. Suivez les invites pour ajouter un nouveau Volume (exemple : `Incremental-002`).

3. Vérifiez que le Volume est ajouté au Pool :
   ```bash
   *list volumes pool=Incremental
   ```

---

## **7. Lancer un test manuel**

1. Lancez une sauvegarde incrémentale pour tester la configuration :
   ```bash
   *run job=IncrementalBackup
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

## **8. Vérifications finales**

1. Consultez les Jobs planifiés pour vérifier que la sauvegarde incrémentale sera automatisée :
   ```bash
   *list jobs
   ```

2. Vérifiez physiquement sur le stockage que les volumes sont bien créés :
   ```bash
   ls -l /mnt/raid1
   ```

---

## **Conclusion**

En suivant ce tutoriel, vous avez configuré une sauvegarde incrémentale quotidienne sur un client Windows à l'aide de Bareos. Voici le résultat final :

1. **Les données sauvegardées** : Tous les fichiers et dossiers spécifiés dans le FileSet (par exemple, `C:/Users` et `D:/Data`).
2. **Automatisation** : La sauvegarde s'exécute automatiquement chaque jour à 20h, grâce au Schedule `DailyIncremental`.
3. **Gestion des volumes** : Les sauvegardes sont enregistrées dans le Pool `Incremental`, utilisant des Volumes créés dans le stockage défini (par exemple, `RAID1-Storage`).
4. **Test réussi** : Vous avez testé et confirmé que la sauvegarde fonctionne correctement en exécutant un Job manuel.

Si des problèmes surviennent, utilisez les journaux pour diagnostiquer :
```bash
journalctl -u bareos-dir
```

Vous pouvez désormais compter sur une solution fiable pour sauvegarder automatiquement vos données critiques chaque jour. 

