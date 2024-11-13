#!/bin/bash

##################################################
#ADAPTER LES CHEMINS AVANT UTILISATION
#####################################################

# Création d'une ou plusieurs VM Ubuntu VirtualBox à partir d'un template de disque dur
# Arguments :
# - nom de la VM
# - taille de la RAM
# - nombre de VMs à créer (optionnel)

# Vérification des arguments
if [ $# -lt 2 ]
then
    echo "Arguments requis pour ce script :"
    echo "- Nom de la VM"
    echo "- Taille de la RAM (en Mo)"
    echo "Optionnel :"
    echo "- Nombre de VMs à créer (par défaut 1)"
    exit 1
fi

# Variables depuis les arguments
vm_name=$1
vm_ram=$2
num_vms=${3:-1}

# Emplacement du disque dur template
template_disk_path="/home/wilder/VirtualBox VMs/Template/TemplateUbuntu-22.04LTS/TemplateUbuntu-22.04LTS_1.vmdk"

for i in $(seq -w 1 $num_vms)
do
    if [ $num_vms -eq 1 ]
    then
        final_vm_name=$vm_name
    else
        final_vm_name="${vm_name}_${i}"
    fi

    # Emplacement du nouveau disque dur cloné
    new_disk_path="/home/wilder/VirtualBox VMs/${final_vm_name}/${final_vm_name}_1.vmdk"

    # Création du dossier pour la nouvelle VM
    mkdir -p "/home/wilder/VirtualBox VMs/${final_vm_name}"

    # Création de la VM vide
    vboxmanage createvm --name $final_vm_name --ostype "Ubuntu_64" --register

    # Configuration de la mémoire RAM et du contrôleur graphique
    vboxmanage modifyvm $final_vm_name --memory $vm_ram --graphicscontroller VMSVGA --vram 16

    # Création du contrôleur SATA
    vboxmanage storagectl $final_vm_name --name "SATA Controller" --add sata --controller IntelAhci

    # Création du contrôleur IDE
    vboxmanage storagectl $final_vm_name --name "IDE Controller" --add ide

    # Attachement du lecteur CD-ROM au contrôleur IDE
    vboxmanage storageattach $final_vm_name --storagectl "IDE Controller" --port 0 --device 0 --type dvddrive --medium emptydrive

    # Clonage du disque dur template
    vboxmanage clonemedium disk "$template_disk_path" "$new_disk_path" --format VMDK

    # Attachement du disque dur cloné à la VM
    vboxmanage storageattach $final_vm_name --storagectl "SATA Controller" --port 0 --device 0 --type hdd --medium "$new_disk_path"

    # Configuration de la carte réseau en NAT
    vboxmanage modifyvm $final_vm_name --nic1 nat
done