## Étape 1 : Créer une nouvelle VM sur Proxmox

- Général : Donnez un nom à la VM (ex: GNS3).
- OS : Choisissez "Do not use any media".
- Système : passer SCSI Controler à `VirtlO SCSI`.
- Disque : Supprimez le disque par défaut.
- CPU : passer sur 4 coeurs et mettre le type `host`.
- Mémoire : Spécifiez la quantité de RAM (4Go c'est le mieux)
- Réseau : Laissez les paramètres par défaut.
- Confirmation : Décochez l'option "Start after creation" avant de finaliser.

## Étape 2 : Télécharger et exporter la Vm depuis un pc local

- Télécharger GNS3 depuis ce lien https://gns3.com/software/download-vm et choisir VMware ESXi
- extraire la Vm du dossier zip et la placer dans un dossier (ex Documents)
- exporter la Vm vers votre proxmox avec la commande `scp "C:\Users\nomuser\Documents\GNS3 VM.ova" root@[IP_du_Proxmox]:/var/lib/vz/template/iso/`

## Étape 3 : Décompression et importation IMG disques

- Depuis votre le shell de votre proxmox on décompresse la Vm: 
```
cd /var/lib/vz/template/iso
tar -xvf "GNS3 VM.ova"
```

- On importe les images des deux disques extraits:
```
qm importdisk 100 GNS3_VM-disk1.vmdk local-lvm -format qcow2
qm importdisk 100 GNS3_VM-disk2.vmdk local-lvm -format qcow2
```

- Aprés l'exportation retournez sur la Vm créé au début et ajouter les nouveaux disques 
![ajout disques](https://github.com/user-attachments/assets/50d1f9a0-90c5-4ff8-ad40-0d70f001afdb)



- Il faut maintenant choisir l'ordre de 'boot'

- Il n'y a plus qu'à démarrer la vm et vérifier que tout fonctionne bien.
