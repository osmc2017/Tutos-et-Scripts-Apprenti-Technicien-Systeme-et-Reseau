### Tutoriel : Configurer une Sauvegarde Différentielle (Differential) avec Bareos

Ce tutoriel vous guide étape par étape pour configurer une sauvegarde différentielle (Differential) dans Bareos en utilisant exclusivement `bconsole`. Une sauvegarde différentielle copie uniquement les fichiers modifiés depuis la dernière sauvegarde complète (Full).

---

## **1. Créer un Pool pour les sauvegardes différentielles**

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
   - **Nom du Pool** : `Differential`
   - **Pool Type** : `Backup`
   - **Recycle** : `yes`
   - **AutoPrune** : `yes`
   - **Volume Retention** : `60 days`
   - **Maximum Volume Bytes** : `50G`
   - **Label Format** : `Differential-`

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
   - **Volume Name** : Donnez un nom au volume (exemple : `Differential-001`).
   - **Pool** : Sélectionnez le pool `Differential`.

3. Vérifiez que le volume est bien créé dans le Pool :
   ```bash
   *list volumes pool=Differential
   ```

---

## **3. Créer un horaire intermédiaire**

1. Utilisez la commande `create schedule` :
   ```bash
   *create schedule
   ```

2. Remplissez les informations demandées :
   - **Nom du Schedule** : `MidWeekDifferential`
   - **Run Statement** : `Differential on Tuesday, Thursday at 02:00`

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
   - **Nom du FileSet** : `WindowsDifferentialFileSet`
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

## **5. Créer un Job de sauvegarde différentielle**

1. Utilisez la commande `create job` :
   ```bash
   *create job
   ```

2. Remplissez les informations demandées :
   - **Nom du Job** : `DifferentialBackup`
   - **Job Type** : `Backup`
   - **Level** : `Differential`
   - **Client** : Indiquez le nom du client Windows (par exemple, `WindowsClient-fd`).
   - **FileSet** : `WindowsDifferentialFileSet`
   - **Schedule** : `MidWeekDifferential`
   - **Storage** : Sélectionnez le stockage configuré (par exemple, `RAID1-Storage`).
   - **Pool** : `Differential`
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

2. Suivez les invites pour ajouter un nouveau Volume (exemple : `Differential-002`).

3. Vérifiez que le Volume est ajouté au Pool :
   ```bash
   *list volumes pool=Differential
   ```

---

## **7. Lancer un test manuel**

1. Lancez une sauvegarde différentielle pour tester la configuration :
   ```bash
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

## **8. Vérifications finales**

1. Consultez les Jobs planifiés pour vérifier que la sauvegarde différentielle sera automatisée :
   ```bash
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

Vous pouvez désormais compter sur une solution fiable pour sauvegarder les modifications intermédiaires entre deux sauvegardes complètes.

