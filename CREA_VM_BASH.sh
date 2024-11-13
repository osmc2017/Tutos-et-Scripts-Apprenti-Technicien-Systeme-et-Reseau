#!/bin/bash

##################################################
#ADAPTER LES CHEMINS AVANT UTILISATION
#####################################################

# Création et configuration d'une VM dans VirtualBox à partir d'une ISO
# Arguments :
# - nom de la VM
# - taille de la RAM
# - Emplacement fichier ISO

# Check arguments
if [ $# -ne 3 ]
then
    echo "Il manque les données suivantes à mettre en arguments de ce script :"
    echo "- Nom de la VM"
    echo "- Taille de la RAM (en Mo)"
    echo "- Emplacement du fichier ISO d'installation"
    exit 1
fi

# Création des variables
vm_name=$1
vm_ram=$2
iso_path=$3

# Création de la VM vide
vboxmanage createvm --name $vm_name --ostype "Ubuntu_64" --register

# Configuration de la mémoire RAM, de la mémoire vidéo, et du contrôleur graphique
vboxmanage modifyvm $vm_name --memory $vm_ram --vram 16 --graphicscontroller VMSVGA

# Création du contrôleur SATA
vboxmanage storagectl $vm_name --name "SATA Controller" --add sata --controller IntelAhci
# Création du disque dur
vboxmanage createmedium disk --filename ~/VirtualBox\ VMs/$vm_name/$vm_name.vmdk --size 30000 --format VMDK
# Attachement du disque dur crée à la VM
vboxmanage storageattach $vm_name --storagectl "SATA Controller" --port 0 --device 0 --type hdd --medium ~/VirtualBox\ VMs/$vm_name/$vm_name.vmdk

# Ajout d'un lecteur CDrom
vboxmanage storagectl $vm_name --name "IDE Controller" --add ide
# Insertion de l'image d'installation dans le lecteur CDrom
vboxmanage storageattach $vm_name --storagectl "IDE Controller" --port 1 --device 0 --type dvddrive --medium $iso_path

# # Configuration de la carte réseau en NAT
vboxmanage modifyvm $vm_name --nic1 nat

# Démarrage de la VM
vboxmanage startvm "$vm_name" --type gui