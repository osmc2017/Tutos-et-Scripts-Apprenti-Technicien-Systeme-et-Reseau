# Guide d'Installation et de Configuration de Bareos Community sur Debian

## Introduction

Ce guide a pour objectif de fournir une méthode claire et détaillée pour installer et configurer **Bareos Community Edition** sur une distribution Debian. Bareos est une solution de sauvegarde puissante et flexible qui utilise PostgreSQL pour sa base de données. Ce document couvre également la configuration préalable d'un RAID 1 pour sécuriser les données avant l'installation de Bareos.

---

## Configuration de RAID 1 sur Debian

Voici une méthode détaillée pour configurer deux disques en RAID 1 sur Debian.

### Étape 1 : Préparer les disques

1. **Vérifiez les disques disponibles :**
   ```bash
   lsblk
   ```
   Identifiez les deux disques à utiliser pour le RAID (par exemple, `/dev/sdb` et `/dev/sdc`).

2. **Supprimez les partitions existantes (si nécessaire) :**
   Utilisez `fdisk` ou `parted` pour nettoyer les disques.

   ```bash
   fdisk /dev/sdb
   ```
   - Tapez `d` pour supprimer les partitions existantes.
   - Répétez pour chaque partition, puis tapez `w` pour sauvegarder.

   Répétez cette opération pour le deuxième disque (`/dev/sdc`).

### Étape 2 : Installer les outils RAID

1. **Installez le package `mdadm` :**
   ```bash
   apt update && apt install mdadm -y
   ```

2. **Vérifiez que `mdadm` est installé :**
   ```bash
   mdadm --version
   ```

### Étape 3 : Configurer le RAID 1

1. **Créez le RAID 1 :**
   ```bash
   mdadm --create --verbose /dev/md0 --level=1 --raid-devices=2 /dev/sdb /dev/sdc
   ```
   - `/dev/md0` : Nom du périphérique RAID.
   - `--level=1` : Type de RAID (miroir).
   - `--raid-devices=2` : Nombre de disques.
   - `/dev/sdb /dev/sdc` : Disques à utiliser.

   **Remarque :** Si un disque doit être ajouté plus tard, remplacez le disque manquant par `missing`.

2. **Vérifiez l'état du RAID :**
   ```bash
   cat /proc/mdstat
   ```
   Cette commande affiche l'état et la progression de la synchronisation.

### Étape 4 : Créer un Système de Fichiers

1. **Formatez le RAID :**
   Une fois le RAID configuré, créez un système de fichiers (par exemple, `ext4`) :
   ```bash
   mkfs.ext4 /dev/md0
   ```

2. **Montez le RAID :**
   Créez un point de montage et montez le RAID :
   ```bash
   mkdir /mnt/raid1
   mount /dev/md0 /mnt/raid1
   ```

3. **Ajoutez l'entrée dans `/etc/fstab` :**
   Pour monter automatiquement le RAID au démarrage, ajoutez cette ligne au fichier `/etc/fstab` :
   ```plaintext
   /dev/md0    /mnt/raid1    ext4    defaults    0    0
   ```

### Étape 5 : Sauvegarder la Configuration du RAID

1. **Enregistrez la configuration actuelle :**
   ```bash
   mdadm --detail --scan >> /etc/mdadm/mdadm.conf
   ```

2. **Recréez l'initramfs :**
   ```bash
   update-initramfs -u
   ```

### Étape 6 : Tester la Configuration

1. **Simulez une panne de disque (optionnel) :**
   ```bash
   mdadm --fail /dev/md0 /dev/sdb
   mdadm --remove /dev/md0 /dev/sdb
   mdadm --add /dev/md0 /dev/sdb
   ```

2. **Surveillez le RAID :**
   Vérifiez régulièrement l'état :
   ```bash
   cat /proc/mdstat
   ```

Avec ces étapes, vous aurez configuré deux disques en RAID 1 sur Debian.

---

## Installation de PostgreSQL sur Debian

Bareos utilise **PostgreSQL** pour sa base de données. Voici comment installer et configurer PostgreSQL.

### 1.1. Installation de PostgreSQL

1. **Mettez à jour les paquets du système :**
   ```bash
   apt update && apt upgrade -y
   ```

2. **Installez PostgreSQL et ses outils supplémentaires :**
   ```bash
   apt install postgresql postgresql-contrib -y
   ```

3. **Assurez-vous que le service PostgreSQL démarre automatiquement au démarrage du système :**
   ```bash
   systemctl enable postgresql
   systemctl start postgresql
   ```

4. **Vérifiez que PostgreSQL fonctionne correctement :**
   ```bash
   systemctl status postgresql
   ```

---

## Installation de Bareos sur Debian

### 2.1. Prérequis

1. **Installation de GPG (gnupg) :**
   ```bash
   apt install gnupg -y
   ```

### 2.2. Ajouter le Dépôt Bareos et Définir les Permissions

1. **Téléchargez le script d’ajout des dépôts Bareos :**
   ```bash
   wget https://download.bareos.org/current/Debian_12/add_bareos_repositories.sh
   ```

2. **Donnez les droits d’exécution au script :**
   ```bash
   chmod +x add_bareos_repositories.sh
   ```

3. **Exécutez le script pour ajouter les dépôts Bareos :**
   ```bash
   sh ./add_bareos_repositories.sh
   ```

4. **Mettez à jour la liste des paquets :**
   ```bash
   apt update
   ```

### 2.3. Installer les Méta-Paquets Bareos

1. **Installez Bareos avec PostgreSQL :**
   ```bash
   apt install bareos bareos-database-postgresql -y
   ```
   **Composants installés :**
   - Bareos Director.
   - Bareos Storage Daemon.
   - Bareos File Daemon.
   - Outils CLI.
   - Configuration pour PostgreSQL.

### 2.4. Configurer l'authentification PostgreSQL pour Bareos

1. **Modifiez le fichier de configuration `pg_hba.conf` :**
   ```bash
   nano /etc/postgresql/XX/main/pg_hba.conf
   ```
   (Remplacez `XX` par la version de PostgreSQL installée, par exemple `15`.)

2. **Ajoutez ou modifiez les lignes suivantes :**
   ```plaintext
   # Modification pour Bareos :
   local   all             bareos                                  md5
   local   replication     all                                     md5
   ```
   Vérifiez également les autres lignes pour vous assurer qu'elles utilisent le mode d'authentification correct (`md5`).

3. **Redémarrez PostgreSQL :**
   ```bash
   systemctl restart postgresql
   ```

4. **Définissez un mot de passe pour l'utilisateur `bareos` (si nécessaire) :**
   Si vous avez cliqué sur **Non** lors de l'installation de Bareos pour configurer automatiquement la base de données, définissez manuellement un mot de passe pour `bareos` :
   ```bash
   su - postgres -c "psql -c \"ALTER USER bareos WITH PASSWORD 'Azerty1*';\""
   ```

### 2.5. Configurer les Scripts de Base de Données

1. **Donnez les permissions nécessaires aux scripts :**
   ```bash
   chmod +x /usr/lib/bareos/scripts/*
   ```

2. **Exécutez les scripts avec l’utilisateur `postgres` :**
   ```bash
   su - postgres -c "/usr/lib/bareos/scripts/create_bareos_database"
   su - postgres -c "/usr/lib/bareos/scripts/make_bareos_tables"
   su - postgres -c "/usr/lib/bareos/scripts/grant_bareos_privileges"
   ```

3. **Vérifiez la base de données :**
   ```bash
   psql -U bareos -d bareos -c '\dt'
   ```

4. **Testez la connexion avec l'utilisateur `bareos` :**
   ```bash
   psql -U bareos -d bareos -W
   ```

---

## Configuration et Démarrage de Bareos

### 3.1. Démarrer et Activer les Services

1. **Démarrez et activez les services Bareos :**
   ```bash
   systemctl enable --now bareos-director
   systemctl enable --now bareos-storage
   systemctl enable --now bareos-filedaemon
   ```

2. **Vérifiez l’état des services :**
   ```bash
   systemctl status bareos-director bareos-storage bareos-filedaemon
   ```

### 3.2. Tester avec bconsole

1. **Lancez `bconsole` :**
   ```bash
   bconsole
   ```

2. **Essayez des commandes comme :**
   ```bash
   *status director
   ```

Avec cette installation et configuration, Bareos est fonctionnel avec PostgreSQL. Vous pouvez passer à l’étape suivante pour configurer l’interface WebUI ou des sauvegardes personnalisées.

