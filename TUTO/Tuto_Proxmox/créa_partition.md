# Configurer un disque sur Proxmox

## Préparation du disque
- On liste les disque avec `lsblk`

- on partionne le disque choisi avec `fdisk /dev/sdX` puis 
    - on créé une nouvelle partition avec `n`
    - On choisi le type de partition `p`pour primaire ou `e` pour extended
    - On choisi le numéro de port (le plus petit par défaut) puis le début de partition (on laisse par défaut)
    - On choisi le volume de notre partition `+XG` ou `+XT` X étant le volume;
    - Une fois nos partition terminé on tape `w` pour écrire et enfin on quitte.

- On verifie avec `lsblk` que tout est ok

- On formate notre partition (ex pour ext4):
	- `mkfs.ext4 /dev/sdb/sdX..`

- On créé notre point de montage et on monte:
	- `mkdir /mnt/achoisir`
	- `mount /dev/sdX.. /mnt/achoisir`

- On vérifie avec `lsblk`

- Récupération de l'ID et édition de fstab:
    - avec `blkid` on récupère les ID des disk (copié/collé fonctionne via interface graphique proxmox);
    - On édite avec `nano /etc/fstab` de cette façon:
        - `UUID=1234-ABCD /mnt/achoisir ext4 defaults 0 2` (Paramètre basique et classique)

## Vérification et montage

- On test le montage avec `mount -a` Si tout est correct, aucune erreur ne sera affichée;

- Vérifiez que le disque est monté avec `df -h`

- On redémarre avec `reboot now`;

- On vérifie avec `lsblk`et on peut également retourné vérfier `fstab`que tout soit OK;

## Ajouter le disque à Proxmox

- Aller dans l'interface web Proxmox :
    - Allez dans Datacenter > Storage;
    - Ajouter un nouveau stockage :
        - Cliquez sur Add > Directory (pour un stockage basé sur un système de fichiers);
        - Donnez un nom au stockage (Nom du dossier de montage peut être bien);
        - Renseignez le chemin du montage (par exemple, /mnt/achoisir);
        - Sélectionnez les types de contenu (par exemple, Disk image, ISO image);

- Appliquer et vérifier :

