### Tutoriel : Configuration d'un Job dans Bareos

Ce tutoriel vous guide pour configurer un **Job de sauvegarde** dans Bareos, incluant la configuration du niveau de sauvegarde (Full, Incremental, Differential), le FileSet, le planning, et l'exécution via `bconsole`.

---

## 1. Création ou modification d'un Job

### 1.1 Accéder au répertoire des Jobs
Tous les fichiers de configuration des jobs se trouvent dans le répertoire suivant :
```bash
cd /etc/bareos/bareos-dir.d/job/
```

### 1.2 Créer ou modifier un fichier de Job
Si le fichier de job n'existe pas, créez-en un pour votre client. Par exemple :
```bash
nano Ubuntu-Backup.conf
```

Ajoutez ou modifiez la configuration suivante :
```plaintext
Job {
    Name = "Ubuntu-Backup"           # Nom du Job
    JobDefs = "DefaultJob"           # Utilise une configuration par défaut
    Client = "ubuntu-fd"             # Nom du File Daemon configuré pour le client
    FileSet = "Standard"             # Ensemble de fichiers à sauvegarder
    Schedule = "WeeklyCycle"         # Planning des sauvegardes
    Level = Full                      # Niveau de sauvegarde par défaut
    Pool = Full                       # Pool utilisé pour la sauvegarde
    Storage = Full-Storage            # Stockage associé
    Enable VSS = yes                  # Active la sauvegarde via VSS (Windows uniquement)
    Messages = Standard               # Gestion des messages
}
```
- **Name** : Nom unique du job.
- **Client** : Nom du File Daemon configuré pour le client.
- **FileSet** : Référence au FileSet contenant les fichiers/dossiers à sauvegarder.
- **Schedule** : Planning définissant quand exécuter les sauvegardes.
- **Level** : Niveau de sauvegarde (Full, Incremental, Differential).
- **Enable VSS** : Active la prise en charge des snapshots VSS pour les clients Windows (optionnel pour Linux).

Sauvegardez et quittez l'éditeur :
- `Ctrl + O`, puis `Entrée` pour sauvegarder.
- `Ctrl + X` pour quitter.

### 1.3 Tester la configuration
Avant de redémarrer Bareos Director, testez la configuration :
```bash
bareos-dir -t
```
- Si des erreurs sont affichées, corrigez-les avant de continuer.

### 1.4 Redémarrer Bareos Director
Redémarrez le service Bareos Director pour appliquer les modifications :
```bash
systemctl restart bareos-dir
```

---

## 2. Créer ou vérifier un FileSet

### 2.1 Accéder au répertoire des FileSets
Tous les FileSets se trouvent dans le répertoire suivant :
```bash
cd /etc/bareos/bareos-dir.d/fileset/
```

### 2.2 Créer ou modifier un FileSet
Si le FileSet n'existe pas, créez-le. Par exemple :
```bash
nano Standard.conf
```

Ajoutez ou modifiez la configuration suivante :
```plaintext
FileSet {
    Name = "Standard"                # Nom du FileSet
    Include {
        Options {
            signature = MD5          # Utilise des signatures MD5 pour validation
        }
        File = /etc                  # Exemple : Sauvegarde du répertoire /etc
        File = /home                 # Exemple : Sauvegarde du répertoire /home
    }
    Exclude {
        File = /tmp                  # Exemple : Exclut le répertoire /tmp
        File = /var/tmp
    }
}
```
- **Include** : Liste des fichiers ou répertoires à sauvegarder.
- **Exclude** : Liste des fichiers ou répertoires à exclure.

Sauvegardez et quittez l'éditeur, puis testez la configuration comme à l'étape 1.3.

---

## 3. Configurer un planning (Schedule)

### 3.1 Accéder au répertoire des plannings
Les plannings se trouvent dans le répertoire suivant :
```bash
cd /etc/bareos/bareos-dir.d/schedule/
```

### 3.2 Créer ou modifier un Schedule
Créez ou modifiez un planning, par exemple :
```bash
nano WeeklyCycle.conf
```

Ajoutez ou modifiez la configuration suivante :
```plaintext
Schedule {
    Name = "WeeklyCycle"            # Nom du planning
    Run = Full 1st sun at 00:00     # Sauvegarde complète le premier dimanche du mois
    Run = Incremental mon-sat at 00:00  # Sauvegardes incrémentales les autres jours
}
```
- **Full** : Niveau Full (sauvegarde complète).
- **Incremental** : Niveau Incremental (seuls les fichiers modifiés sont sauvegardés).

Sauvegardez, testez, et redémarrez Bareos Director.

---

## 4. Lancer un job de sauvegarde dans `bconsole`

### 4.1 Connectez-vous à `bconsole`
```bash
bconsole
```

### 4.2 Lancer un job
1. Listez les jobs disponibles :
   ```plaintext
   *list jobs
   ```

2. Lancez un job :
   ```plaintext
   *run
   ```

3. Suivez les invites :
   - **JobName** : Sélectionnez le job (ég. `Ubuntu-Backup`).
   - **Level** : Par défaut, `Incremental`. Si vous voulez une sauvegarde complète, choisissez `mod` (modifier) et changez le niveau en `Full`.
   - **Storage** : Choisissez le stockage (ég. `Full-Storage`).
   - **Pool** : Choisissez le pool (ég. `Full`).

4. Confirmez et exécutez le job.

---

## 5. Vérifier les sauvegardes

### 5.1 Suivre l’état du job
Pendant ou après l’exécution, vérifiez l’état des jobs :
```plaintext
*status director
```

### 5.2 Vérifier les volumes
Vérifiez que les données sont bien écrites sur les volumes :
```plaintext
*list volumes
```

---

### **Conclusion**

Avec ce tutoriel, vous avez configuré un job de sauvegarde complet dans Bareos, incluant le FileSet, le planning, et le lancement des sauvegardes. Si des problèmes surviennent, consultez les journaux pour identifier et résoudre les erreurs :
- **Director** :
  ```bash
  journalctl -u bareos-dir
  ```
- **Storage Daemon** :
  ```bash
  journalctl -u bareos-sd
  ```
- **File Daemon (Client)** :
  ```bash
  cat /var/log/bareos/bareos-fd.log
  ```

