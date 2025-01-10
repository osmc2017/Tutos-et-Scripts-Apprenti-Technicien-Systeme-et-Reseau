# Tutoriel Complet : Sauvegarde Complète (Full Backup) avec Rsync

## **Introduction**
Ce tutoriel explique comment configurer une sauvegarde complète (à chaque exécution, tous les fichiers sont re-copiés) en utilisant **rsync** sur un serveur Linux Debian. Cette configuration est idéale pour conserver une copie intégrale des données à intervalles réguliers.

---

## **1. Préparation sur le Client Windows**

### 1.1 Création et partage d’un dossier
1. Sur le client Windows, créez le dossier que vous souhaitez sauvegarder, par exemple : `C:\Partage`.
2. Faites un clic droit sur le dossier > **Propriétés** > Onglet **Partage** > **Partager…**.
3. Ajoutez un utilisateur ou choisissez "Tout le monde".
4. Donnez des droits **Lecture/\u00c9criture** à l'utilisateur.
5. Notez le chemin réseau du partage, par exemple : `\\192.168.x.x\Partage`.

### 1.2 Vérification du partage
1. Testez l'accès à partir d'un autre ordinateur avec les identifiants configurés.

---

## **2. Préparation sur le Serveur Debian**

### 2.1 Installer les outils nécessaires
1. Installez rsync et les outils pour monter les partages Windows :
   ```bash
   apt update && apt install -y cifs-utils rsync
   ```

### 2.2 Configuration du répertoire de sauvegarde
1. Créez un répertoire pour stocker les sauvegardes complètes :
   ```bash
   mkdir -p /mnt/backup/windows-client
   ```
2. Attribuez les permissions :
   ```bash
   chown root:root /mnt/backup
   chmod 755 /mnt/backup
   ```

### 2.3 Création d’un utilisateur pour la sauvegarde
1. Créez un utilisateur dédié :
   ```bash
   adduser rsyncuser
   ```
   - Définissez un mot de passe.

2. Assurez-vous que l’utilisateur a accès au répertoire de sauvegarde :
   ```bash
   chown rsyncuser:rsyncuser /mnt/backup/windows-client
   chmod 750 /mnt/backup/windows-client
   ```

---

## **3. Monter le partage Windows**

### 3.1 Monter le partage réseau
1. Créez un point de montage :
   ```bash
   mkdir -p /mnt/windows-share
   ```
2. Montez le partage Windows :
   ```bash
   mount -t cifs //192.168.x.x/Partage /mnt/windows-share -o username=VotreNomUtilisateur,password=VotreMotDePasse,uid=rsyncuser,gid=rsyncuser
   ```
   - Remplacez `192.168.x.x` et `Partage` par les valeurs appropriées.

3. Testez le montage :
   ```bash
   ls -l /mnt/windows-share
   ```

### 3.2 Automatiser le montage
Ajoutez une ligne dans `/etc/fstab` pour monter automatiquement au démarrage :
```plaintext
//192.168.x.x/Partage /mnt/windows-share cifs username=VotreNomUtilisateur,password=VotreMotDePasse,uid=rsyncuser,gid=rsyncuser 0 0
```

---

## **4. Configuration de la sauvegarde complète**

### 4.1 Commande manuelle
1. Exécutez la commande suivante pour effectuer une sauvegarde complète :
   ```bash
   rsync -avz --delete /mnt/windows-share/ /mnt/backup/windows-client/
   ```
   - L'option `--delete` supprime les fichiers obsolètes dans la destination pour correspondre à la source.

### 4.2 Script de sauvegarde
1. Créez un script pour automatiser la sauvegarde :
   ```bash
   nano /usr/local/bin/full_backup.sh
   ```
2. Ajoutez le contenu suivant :
   ```bash
   #!/bin/bash

   # Dossiers source et destination
   SRC_DIR="/mnt/windows-share/"
   DEST_DIR="/mnt/backup/windows-client/"

   # Exécuter rsync pour une sauvegarde complète
   rsync -avz --delete "$SRC_DIR" "$DEST_DIR"

   # Ajouter un log de l'exécution
   echo "Sauvegarde complète effectuée le $(date)" >> /var/log/full_backup.log
   ```
3. Rendez le script exécutable :
   ```bash
   chmod +x /usr/local/bin/full_backup.sh
   ```
4. Testez le script :
   ```bash
   /usr/local/bin/full_backup.sh
   ```

---

## **5. Automatisation avec Cron**

### 5.1 Configuration de cron
1. Ouvrez crontab :
   ```bash
   crontab -e
   ```
2. Ajoutez une tâche planifiée pour la sauvegarde complète, par exemple :
   - Tous les jours à minuit :
     ```plaintext
     0 0 * * * /usr/local/bin/full_backup.sh
     ```
   - Tous les dimanches à 3h du matin :
     ```plaintext
     0 3 * * 0 /usr/local/bin/full_backup.sh
     ```

### 5.2 Vérification
1. Assurez-vous que la tâche est ajoutée :
   ```bash
   crontab -l
   ```
2. Consultez les logs pour vérifier l’exécution :
   ```bash
   cat /var/log/full_backup.log
   ```

---

## **6. Restaurer une sauvegarde**
Pour restaurer une sauvegarde complète :
1. Montez le partage Windows cible.
2. Exécutez rsync pour restaurer les fichiers :
   ```bash
   rsync -avz /mnt/backup/windows-client/ /mnt/windows-share/
   ```

---

## **Conclusion**
Vous avez configuré une sauvegarde complète avec rsync, qui garantit une copie intégrale des données. Cette solution est idéale pour des sauvegardes régulières tout en maintenant une cohérence parfaite entre la source et la destination. Vous pouvez ajuster la fréquence et les options selon vos besoins.

