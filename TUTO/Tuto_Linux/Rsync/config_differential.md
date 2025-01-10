# Tutoriel Complet : Sauvegarde Différentielle avec Rsync

## **Introduction**
Ce tutoriel explique comment configurer une sauvegarde différentielle avec **rsync** sur un serveur Linux Debian. Une sauvegarde différentielle consiste à copier uniquement les fichiers modifiés ou ajoutés depuis la dernière sauvegarde complète. Ce type de sauvegarde permet de gagner du temps et de l’espace disque par rapport à une sauvegarde complète tout en conservant un historique des modifications.

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
1. Créez un répertoire pour stocker les sauvegardes différentielles :
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

## **4. Configuration de la sauvegarde différentielle**

### 4.1 Structure des sauvegardes
Pour conserver des sauvegardes différentielles, nous allons utiliser des répertoires datés. Chaque sauvegarde différentielle sera stockée dans un répertoire portant la date d’exécution.

### 4.2 Commande manuelle
1. Exécutez la commande suivante pour effectuer une sauvegarde différentielle :
   ```bash
   rsync -avz --compare-dest=/mnt/backup/windows-client/last/ /mnt/windows-share/ /mnt/backup/windows-client/$(date +%Y-%m-%d)/
   ```
   - L’option `--compare-dest` indique à rsync de comparer les fichiers avec le répertoire de référence (`/last/` dans cet exemple).
   - Les nouveaux fichiers et ceux modifiés seront copiés dans un répertoire daté.

2. Après chaque sauvegarde, mettez à jour le répertoire `last` pour qu’il reflète la sauvegarde actuelle :
   ```bash
   rm -rf /mnt/backup/windows-client/last
   cp -al /mnt/backup/windows-client/$(date +%Y-%m-%d) /mnt/backup/windows-client/last
   ```

### 4.3 Script de sauvegarde
1. Créez un script pour automatiser la sauvegarde différentielle :
   ```bash
   nano /usr/local/bin/differential_backup.sh
   ```
2. Ajoutez le contenu suivant :
   ```bash
   #!/bin/bash

   # Dossiers source et destination
   SRC_DIR="/mnt/windows-share/"
   BASE_DIR="/mnt/backup/windows-client/"
   TODAY_DIR="$BASE_DIR$(date +%Y-%m-%d)/"

   # Exécuter rsync pour une sauvegarde différentielle
   rsync -avz --compare-dest=${BASE_DIR}last/ "$SRC_DIR" "$TODAY_DIR"

   # Mettre à jour le répertoire de référence
   rm -rf ${BASE_DIR}last
   cp -al "$TODAY_DIR" ${BASE_DIR}last

   # Ajouter un log de l'exécution
   echo "Sauvegarde différentielle effectuée le $(date)" >> /var/log/differential_backup.log
   ```
3. Rendez le script exécutable :
   ```bash
   chmod +x /usr/local/bin/differential_backup.sh
   ```
4. Testez le script :
   ```bash
   /usr/local/bin/differential_backup.sh
   ```

---

## **5. Automatisation avec Cron**

### 5.1 Configuration de cron
1. Ouvrez crontab :
   ```bash
   crontab -e
   ```
2. Ajoutez une tâche planifiée pour la sauvegarde différentielle, par exemple :
   - Tous les jours à minuit :
     ```plaintext
     0 0 * * * /usr/local/bin/differential_backup.sh
     ```
   - Tous les lundis, mercredis et vendredis à 2h du matin :
     ```plaintext
     0 2 * * 1,3,5 /usr/local/bin/differential_backup.sh
     ```

### 5.2 Vérification
1. Assurez-vous que la tâche est ajoutée :
   ```bash
   crontab -l
   ```
2. Consultez les logs pour vérifier l’exécution :
   ```bash
   cat /var/log/differential_backup.log
   ```

---

## **6. Restaurer une sauvegarde**
Pour restaurer une sauvegarde différentielle, combinez la dernière sauvegarde complète avec la sauvegarde différentielle souhaitée :

1. Montez le partage Windows cible.
2. Exécutez rsync pour restaurer les fichiers depuis la sauvegarde différentielle :
   ```bash
   rsync -avz /mnt/backup/windows-client/2025-01-01/ /mnt/windows-share/
   ```
3. Ajoutez les fichiers des sauvegardes complémentaires si nécessaire.

---

## **Conclusion**
Vous avez configuré une sauvegarde différentielle avec rsync, qui offre un bon compromis entre vitesse et conservation de l’historique. Cette solution est idéale pour des sauvegardes régulières sans répliquer inutilement les mêmes fichiers. Vous pouvez ajuster la fréquence et les options selon vos besoins.

