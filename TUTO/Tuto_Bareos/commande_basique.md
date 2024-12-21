# Tutoriel et Récapitulatif des Commandes BConsole pour Bareos Server

## Introduction
BConsole est l'interface en ligne de commande pour gérer et interagir avec un serveur Bareos. Ce guide couvre les commandes les plus utiles avec des explications détaillées, des exemples, et des conseils pour effectuer des opérations courantes comme la gestion des sauvegardes, des restaurations et des volumes.

---

## Connexion à BConsole
Pour accéder à BConsole :
```bash
bconsole
```
- Assurez-vous que le service Bareos Director est en cours d'exécution.
- Vous serez connecté à une interface interactive.
- Si vous avez une configuration personnalisée, vérifiez les permissions des fichiers de configuration.

---

## Commandes Utiles

### 1. **Gestion des Tâches de Sauvegarde**

#### Exécuter une sauvegarde immédiate
Utilisez la commande suivante pour lancer une sauvegarde :
```bash
run
```
- Un menu s’affiche :
  - Sélectionnez le `Job` que vous souhaitez exécuter (par exemple, "BackupClient1").
  - Spécifiez le niveau de sauvegarde (Full, Incremental, ou Differential).
  - Confirmez les options avant de commencer.

**Exemple :**
```
JobName: BackupClient1
Level: Incremental
Client: client1-fd
Storage: FileStorage
```

#### Vérifier l'état des tâches actives
Pour surveiller les tâches en cours :
```bash
status dir
```
- Cela affiche les informations sur les jobs actifs et leur progression.

#### Annuler une tâche active
Pour annuler une sauvegarde en cours :
```bash
cancel <JobId>
```
- Remplacez `<JobId>` par l’identifiant du job.
- Vous pouvez trouver l’ID dans les résultats de `status dir`.

---

### 2. **Gestion des Restaurations**

#### Démarrer une restauration
Pour restaurer des fichiers :
```bash
restore
```
1. Une série de questions s’affiche :
   - Choisissez le type de restauration (par exemple, dernier job ou fichier spécifique).
   - Sélectionnez les fichiers à restaurer via une liste ou une recherche.
2. Précisez le chemin de destination (par exemple, écraser les fichiers existants ou choisir un dossier temporaire).

**Exemple :**
```
Option: Restore most recent backup for Client
Where: /tmp/restore-test/
```

#### Lister les jobs disponibles pour restauration
Pour voir les sauvegardes disponibles :
```bash
list jobs
```
- Cette commande permet de voir tous les jobs terminés.
- Recherchez l’identifiant du job que vous souhaitez restaurer.

#### Lister les fichiers d’un job
Pour lister les fichiers inclus dans une sauvegarde :
```bash
list files jobid=<JobId>
```
- Remplacez `<JobId>` par l’identifiant d’un job.

---

### 3. **Gestion des Volumes**

#### Lister les volumes disponibles
Pour consulter les volumes enregistrés dans le pool :
```bash
list volumes
```
- Cela affiche le nom, la taille, et l’état des volumes.

#### Vérifier l’état des volumes
Pour afficher les informations des volumes sur un stockage :
```bash
status storage
```
- Cela inclut des détails sur les volumes utilisés et disponibles.

#### Effacer un volume
Pour marquer un volume comme utilisable :
```bash
purge volume=<NomDuVolume>
```
- Remplacez `<NomDuVolume>` par le nom du volume.

#### Supprimer un volume
Pour supprimer complètement un volume :
```bash
delete volume=<NomDuVolume>
```
- Cette commande est irréversible.

#### Ajouter un nouveau volume
L’ajout de nouveaux volumes est une étape importante dans la gestion des sauvegardes. Voici les étapes détaillées pour créer un nouveau volume :

1. **Utilisez la commande `label` :**
   ```bash
   label
   ```
2. **Suivez les invites affichées :**
   - **Label Volume** : Donnez un nom unique au volume (par exemple, "BackupVol1").
   - **Pool** : Indiquez le pool auquel le volume sera associé (par exemple, "Default").
   - **Storage** : Spécifiez le stockage associé au volume (par exemple, "FileStorage").

**Exemple :**
```
Label Volume: BackupVol1
Pool: Default
Storage: FileStorage
```

3. **Vérifiez que le volume a été ajouté :**
   Une fois créé, utilisez `list volumes` pour vérifier que le volume apparaît dans la liste.

4. **Conseil pratique :**
   - Prévoyez des pools séparés pour différents types de sauvegarde (par exemple, "Daily", "Weekly", "Monthly") afin de mieux organiser vos volumes.
   - Utilisez des noms de volumes descriptifs pour faciliter leur identification.

---

### 4. **Gestion des Pools**

#### Qu’est-ce qu’un pool ?
Un pool est un regroupement logique de volumes qui partagent un même objectif ou type d’utilisation. Par exemple, vous pouvez créer des pools pour des sauvegardes quotidiennes, hebdomadaires ou mensuelles.

#### Créer un nouveau pool
1. **Ouvrir le fichier de configuration du Director :**
   Le fichier se trouve généralement dans `/etc/bareos/bareos-dir.conf`.

2. **Ajouter une nouvelle définition de pool :**
   ```
   Pool {
     Name = DailyPool
     Pool Type = Backup
     Recycle = Yes
     AutoPrune = Yes
     Volume Retention = 7 days
     Maximum Volumes = 10
   }
   ```
   - **Name** : Donnez un nom unique au pool (par exemple, "DailyPool").
   - **Pool Type** : Définit le type d’utilisation du pool (`Backup`, `Archive`, ou `Cloned`).
   - **Recycle** : Indique si les volumes peuvent être réutilisés.
   - **AutoPrune** : Active la suppression automatique des volumes expirés.
   - **Volume Retention** : Spécifie la durée pendant laquelle les volumes doivent être conservés.
   - **Maximum Volumes** : Limite le nombre de volumes dans le pool.

3. **Enregistrer et redémarrer le service Bareos Director :**
   ```bash
   systemctl restart bareos-dir
   ```

#### Associer un pool à un job
Lors de la configuration d’un job de sauvegarde dans `bareos-dir.conf`, spécifiez le pool dans la section du job :
   ```
   Job {
     Name = "BackupClient1"
     Client = client1-fd
     Pool = DailyPool
     Schedule = "DailyCycle"
   }
   ```
   Cela garantit que les sauvegardes du job seront stockées dans le pool défini.

#### Vérifier les pools configurés
Pour voir la liste des pools disponibles :
```bash
list pools
```

---

### 5. **Ajout et Utilisation d’un Nouveau Disque**

#### Étape 1 : Ajouter un disque physique ou virtuel
1. **Ajoutez le disque à votre serveur :**
   - Si c’est un disque physique, connectez-le au serveur.
   - Si c’est un disque virtuel (dans une VM), ajoutez-le via l’interface de votre hyperviseur.

2. **Identifier le disque :**
   ```bash
   lsblk
   ```
   Vous verrez une liste des disques. Notez le nom du nouveau disque (par exemple, `/dev/sdb`).

#### Étape 2 : Formater et monter le disque
1. **Créer une partition :**
   ```bash
   fdisk /dev/sdb
   ```
   Suivez les étapes pour créer une nouvelle partition principale.

2. **Formater le disque :**
   ```bash
   mkfs.ext4 /dev/sdb1
   ```
   Remplacez `/dev/sdb1` par la partition créée.

3. **Créer un point de montage :**
   ```bash
   mkdir /mnt/bareos-storage
   ```

4. **Monter le disque :**
   ```bash
   mount /dev/sdb1 /mnt/bareos-storage
   ```

5. **Ajouter au fichier fstab pour montage automatique :**
   ```bash
   echo "/dev/sdb1 /mnt/bareos-storage ext4 defaults 0 2" >> /etc/fstab
   ```

#### Étape 3 : Configurer Bareos pour utiliser le disque
1. **Modifier le fichier de configuration `bareos-sd.conf` :**
   ```
   Device {
     Name = NewStorage
     Media Type = File
     Archive Device = /mnt/bareos-storage
     Label Media = Yes
     Random Access = Yes
     Automatic Mount = Yes
   }
   ```
   - **Name** : Nom du périphérique de stockage.
   - **Archive Device** : Chemin du point de montage du disque.

2. **Redémarrer le service Storage Daemon :**
   ```bash
   systemctl restart bareos-sd
   ```

3. **Vérifier la configuration :**
   ```bash
   status storage
   ```
   Assurez-vous que le nouveau stockage est listé et opérationnel.

#### Étape 4 : Associer le disque à un pool
Lors de la configuration d’un pool, ajoutez le nouveau stockage :
   ```
   Pool {
     Name = NewPool
     Storage = NewStorage
   }
   ```

---

### 6. **Rapports et Logs**

#### Consulter les logs récents
Pour afficher les derniers messages d’erreur ou d’information :
```bash
messages
```
- Idéal pour diagnostiquer les problèmes.

#### Rapport d’un job précis
Pour consulter le détail d'un job :
```bash
list jobid=<JobId>
```

#### Historique des statistiques
Pour afficher des statistiques globales :
```bash
list stats
```

---

### 7. **Gestion des Répertoires et Configurations**

#### Recharger la configuration
Après modification des fichiers de configuration Bareos, rechargez-les :
```bash
reload
```
- Cela évite de redémarrer le service Bareos Director.

#### Vérifier la communication entre composants
Pour vous assurer que le Director communique correctement avec les autres démons :
```bash
status dir
```

---

## Conseils Pratiques

1. **Automatisation** : Utilisez des scripts pour les tâches répétitives comme les sauvegardes ou les vérifications d’état.
2. **Gestion des logs** : Configurez une rotation des logs pour éviter qu’ils n’occupent trop d’espace disque.
3. **Planification des sauvegardes** : Mettez en place des schedules pour automatiser les sauvegardes (éditez le fichier de configuration du `Job`).
4. **Tests réguliers** : Testez périodiquement vos restaurations pour garantir que les sauvegardes sont valides.
5. **Documentation** : Maintenez à jour une documentation interne sur votre configuration Bareos.

---

## Commandes Fréquemment Utilisées

| **Commande**          | **Description**                                      |
|------------------------|------------------------------------------------------|
| `run`                 | Lancer une sauvegarde immédiate.                   |
| `restore`             | Démarrer une restauration.                         |
| `status dir`          | Consulter l'état des tâches actives.              |
| `list volumes`        | Lister les volumes disponibles.                     |
| `purge volume=<Nom>`  | Effacer un volume.                                  |
| `delete volume=<Nom>` | Supprimer un volume.                                |
| `list pools`          | Lister les pools configurés.                        |
| `messages`            | Afficher les logs récents.                         |
| `reload`              | Recharger la configuration.                        |

---

Pour plus de détails, référez-vous à la [documentation officielle Bareos](https://www.bareos.org/documentation.html).
