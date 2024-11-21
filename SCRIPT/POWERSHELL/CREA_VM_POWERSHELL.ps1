##################################################
#ADAPTER LES CHEMINS AVANT UTILISATION
#####################################################

# Chemin vers VBoxManage
$vboxmanage = "C:\Program Files\Oracle\VirtualBox\VBoxManage.exe"

# Vérification des arguments
if ($args.Count -ne 3) {
    Write-Output "Il manque les données suivantes à mettre en arguments de ce script :"
    Write-Output "- Nom de la VM"
    Write-Output "- Taille de la RAM (en Mo)"
    Write-Output "- Emplacement du fichier ISO d'installation"
    exit 1
}

# Création des variables
$vm_name = $args[0]
$vm_ram = $args[1]
$iso_path = $args[2]

# Création de la VM vide
& "$vboxmanage" createvm --name $vm_name --ostype "Ubuntu_64" --register

# Configuration de la mémoire RAM, de la mémoire vidéo, et du contrôleur graphique
& "$vboxmanage" modifyvm $vm_name --memory $vm_ram --vram 16 --graphicscontroller VMSVGA

# Création du contrôleur SATA
& "$vboxmanage" storagectl $vm_name --name "SATA Controller" --add sata --controller IntelAhci

# Création du disque dur
$disk_path = "D:\VMs\$vm_name\$vm_name.vmdk"
New-Item -ItemType Directory -Path "D:\VMs\$vm_name" -Force | Out-Null
& "$vboxmanage" createmedium disk --filename $disk_path --size 30000 --format VMDK

# Attachement du disque dur créé à la VM
& "$vboxmanage" storageattach $vm_name --storagectl "SATA Controller" --port 0 --device 0 --type hdd --medium $disk_path

# Ajout d'un lecteur CDrom
& "$vboxmanage" storagectl $vm_name --name "IDE Controller" --add ide

# Insertion de l'image d'installation dans le lecteur CDrom
& "$vboxmanage" storageattach $vm_name --storagectl "IDE Controller" --port 1 --device 0 --type dvddrive --medium $iso_path

# Configuration de la carte réseau en NAT
& "$vboxmanage" modifyvm $vm_name --nic1 nat

# Démarrage de la VM
& "$vboxmanage" startvm $vm_name --type gui