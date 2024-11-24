# Configurer un disque sur Proxmox

## **Préparation du disque**

1. **Lister les disques disponibles** :
    ```
    lsblk
    ```

2. **Partitionner le disque choisi avec `fdisk`** :
    - Exécuter la commande `fdisk /dev/sdX` où `X` représente la lettre du disque que vous voulez partitionner.
    - Créer une nouvelle partition avec `n`.
    - Choisir le type de partition :
        - `p` pour une partition primaire.
        - `e` pour une partition étendue.
    - Choisir le numéro de partition (le plus petit par défaut).
    - Définir le début de la partition (laissez par défaut).
    - Spécifier la taille de la partition (ex. `+XG` pour un volume de X gigaoctets ou `+XT` pour X téraoctets).
    - Une fois la partition terminée, tapez `w` pour écrire les modifications et quitter.

3. **Vérification** :
    - Vérifiez la configuration du disque avec `lsblk`.

4. **Formater la partition** (par exemple, en `ext4`) :
    ```
    mkfs.ext4 /dev/sdb1
    ```

5. **Créer le point de montage et monter la partition** :
    - Créer le répertoire de montage :
      ```
      mkdir /mnt/achoisir
      ```
    - Monter la partition :
      ```
      mount /dev/sdb1 /mnt/achoisir
      ```

6. **Vérification** :
    - Vérifiez le montage avec `lsblk`.

---

## **Récupération de l'UUID et édition de `fstab`**

1. **Récupérer l'UUID du disque** :
    - Utilisez `blkid` pour récupérer l'UUID du disque.
    - Exemple de sortie :
      ```
      /dev/sdb1: UUID="1234-ABCD" TYPE="ext4"
      ```

2. **Édition de `fstab` pour montage automatique** :
    - Ouvrez le fichier `/etc/fstab` avec un éditeur de texte :
      ```
      nano /etc/fstab
      ```
    - Ajoutez la ligne suivante avec l'UUID récupéré :
      ```
      UUID=1234-ABCD /mnt/achoisir ext4 defaults 0 2
      ```
    - Sauvegardez et fermez le fichier.

---

## **Vérification et montage**

1. **Tester le montage avec `mount -a`** :
    - Cette commande monte tous les systèmes de fichiers définis dans `/etc/fstab` sans avoir besoin de redémarrer. Si tout est correct, aucune erreur ne sera affichée.

2. **Vérification du montage** :
    - Vérifiez l'espace disque et les points de montage avec `df -h`.

3. **Redémarrer le serveur** :
    ```
    reboot now
    ```

4. **Vérifier après redémarrage** :
    - Vérifiez le montage avec `lsblk` et assurez-vous que tout est en ordre en vérifiant à nouveau `/etc/fstab`.

---

## **Ajouter le disque à Proxmox**

1. **Accéder à l'interface web de Proxmox** :
    - Ouvrir le navigateur et se connecter à l'interface web de Proxmox.

2. **Ajouter un nouveau stockage** :
    - Aller dans **Datacenter > Storage**.
    - Cliquez sur **Add > Directory** (pour un stockage basé sur un système de fichiers).
    - Donnez un nom au stockage (par exemple, le nom du répertoire de montage).
    - Indiquez le chemin du montage (par exemple, `/mnt/achoisir`).
    - Sélectionnez les types de contenu que vous souhaitez associer au stockage, tels que **Disk image**, **ISO image**, etc.

3. **Appliquer et vérifier** :
    - Appliquez les modifications et vérifiez dans l'interface Proxmox que le disque est bien ajouté et disponible pour être utilisé.

---

Avec ce guide, vous pouvez ajouter et configurer un disque sur Proxmox, le formater, le monter, et le rendre accessible pour un stockage local.
