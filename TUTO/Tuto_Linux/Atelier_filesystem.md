# Atelier Filesystem sur Debian

## **Configuration**

1. **Ajouter un deuxième disque** :
    - Ajoutez un disque de 8 Go (par exemple).
    - Configurez ce disque en **pont** (passerelle).

---

## **Exercice**

### **Objectif** : 
Créer une partition pour une **SVG** et une **SWAP** sur un deuxième disque.

1. **Se connecter en root** :
    - Utilisez la commande `su` pour devenir root ou `sudo -i` si vous êtes un utilisateur privilégié.

2. **Lister les disques disponibles** :
    - Utilisez la commande `blkid` ou `lsblk -f` pour obtenir les informations sur les disques, y compris les UUID.

---

## **Étapes à suivre**

### 1. **Vérification du partitionnement** :
   - Utilisez `lsblk` pour vérifier le partitionnement du disque.
   - Vous devriez voir :
     - Le disque principal (`/dev/sda`) avec trois partitions, dont une déjà utilisée comme **SWAP**.
     - Le disque `/dev/sdb` non partitionné.

### 2. **Partitionnement du disque secondaire** :

   - Exécutez la commande `cfdisk /dev/sdb` pour partitionner le disque secondaire.
   - Choisissez **DOS** pour le type de partitionnement (MBR).
   - Créez deux partitions :
     - La première partition (6 Go) en **primaire**.
     - La deuxième partition avec l'espace restant en **primaire**.
   - Une fois la partition terminée, tapez **Write** pour enregistrer et **Quitter** pour sortir.

### 3. **Vérification après partitionnement** :
   - Vérifiez que le partitionnement a bien été effectué avec `lsblk`.

### 4. **Formatage des partitions** :

   - Formatez la première partition en **ext4** et donnez-lui un label (par exemple "BACKUP") :
     ```
     mkfs.ext4 -L BACKUP /dev/sdb1
     ```
   - Formatez la deuxième partition en **SWAP** et donnez-lui un label (par exemple "SWAP") :
     ```
     mkswap -L SWAP /dev/sdb2
     ```

### 5. **Vérification des UUID** :
   - Utilisez la commande `lsblk -f` pour vérifier les UUID des partitions.
   - Vous pouvez aussi utiliser `blkid` pour obtenir les UUID.

### 6. **Désactiver l'ancienne partition SWAP et activer la nouvelle** :

   - Désactivez la partition **SWAP** existante (ex. `/dev/sda5`) :
     ```
     swapoff /dev/sda5
     ```
     - Vérifiez que le swap a bien été désactivé avec `swapon -s`.
   - Activez la nouvelle partition **SWAP** (ex. `/dev/sdb2`) :
     ```
     swapon /dev/sdb2
     ```
     - Vérifiez que la partition SWAP est maintenant activée avec `swapon -s`.

### 7. **Créer un répertoire de montage pour les données** :

   - Créez un répertoire pour le montage de la partition de sauvegarde :
     ```
     mkdir /mnt/backup
     ```
   - Montez la première partition (`/dev/sdb1`) dans ce répertoire :
     ```
     mount /dev/sdb1 /mnt/backup
     ```

### 8. **Vérification du montage** :
   - Vérifiez que le disque est monté correctement avec `lsblk` et `df -h`.

---

## **Configurer les points de montage au démarrage**

### 1. **Éditer le fichier `/etc/fstab`** :
   - Ouvrez le fichier `/etc/fstab` pour ajouter les entrées de montage permanentes :
     ```
     nano /etc/fstab
     ```
   - Utilisez la commande `blkid` pour obtenir les UUID des partitions, ou `lsblk -f`.
   - Ajoutez les lignes correspondantes pour la partition **BACKUP** et **SWAP** en utilisant les UUID récupérés :

     - Pour la partition **BACKUP** :
       ```
       UUID=<UUID_sdb1> /mnt/backup ext4 defaults 0 0
       ```
     - Pour la partition **SWAP** :
       ```
       UUID=<UUID_sdb2> none swap sw 0 0
       ```

### 2. **Désactiver la partition SWAP de l'ancien disque** :
   - Commentez la ligne correspondant à `/dev/sda5` dans le fichier `/etc/fstab` si elle existe.

### 3. **Appliquer les modifications** :
   - Appliquez les modifications en utilisant la commande `mount -a` :
     ```
     mount -a
     ```
   - Vérifiez que tout fonctionne correctement avec `lsblk`.

---

## **Redémarrer et vérifier les montages**

1. **Redémarrer la machine** : `reboot`


2. **Vérifier après le redémarrage** :
- Vérifiez que les partitions sont correctement montées et que le swap est activé avec `lsblk` et `swapon -s`.
- Vous pouvez aussi vérifier le fichier `/etc/fstab` pour vous assurer que les modifications sont permanentes.

---

Ce guide vous permettra de partitionner et configurer correctement un deuxième disque sur Debian, d'ajouter des partitions **BACKUP** et **SWAP**, de les formater, de les monter et de configurer un montage automatique au démarrage.

