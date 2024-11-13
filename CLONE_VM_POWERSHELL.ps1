##################################################
#ADAPTER LES CHEMINS AVANT UTILISATION
#####################################################

# Chemin vers VBoxManage
$vboxmanage = "C:\Program Files\Oracle\VirtualBox\VBoxManage.exe"

# Vérification des arguments
if ($args.Count -lt 2) {
    Write-Output "Arguments requis pour ce script :"
    Write-Output "- Nom de la VM"
    Write-Output "- Taille de la RAM (en Mo)"
    Write-Output "Optionnel :"
    Write-Output "- Nombre de VMs à créer (par défaut 1)"
    exit 1
}

# Variables depuis les arguments
$vm_name = $args[0]
$vm_ram = $args[1]
$num_vms = if ($args.Count -ge 3) { $args[2] } else { 1 }

# Emplacement du disque dur template
$template_disk_path = "D:\VMs\machine a script ssh\Clone de ubuntu 22 clean\Clone de ubuntu 22 clean-disk001.vdi"

# Vérifiez si le disque template existe
if (!(Test-Path -Path $template_disk_path)) {
    Write-Output "Erreur : Le disque dur template n'existe pas à l'emplacement spécifié: $template_disk_path"
    exit 1
}

# Boucle pour créer plusieurs VMs
for ($i = 1; $i -le $num_vms; $i++) {
    # Nom de la VM, ajout de suffixe pour éviter les conflits de nom
    $suffix = "_{0:D2}" -f $i
    $final_vm_name = "${vm_name}${suffix}"

    # Emplacement du nouveau disque dur cloné
    $new_disk_path = "D:\VMs\$final_vm_name\$final_vm_name_1.vdi"

    # Création du dossier pour la nouvelle VM
    $vm_folder = "D:\VMs\$final_vm_name"
    if (!(Test-Path -Path $vm_folder)) {
        New-Item -ItemType Directory -Path $vm_folder -Force | Out-Null
    }

    # Création de la VM vide
    $create_vm_result = & "$vboxmanage" createvm --name $final_vm_name --ostype "Ubuntu_64" --register
    Start-Sleep -Seconds 2  # Pause pour éviter tout conflit d'opération
    if ($LASTEXITCODE -ne 0) {
        Write-Output "Erreur lors de la création de la VM '$final_vm_name'."
        continue
    }

    # Configuration de la mémoire RAM et du contrôleur graphique
    $modify_vm_result = & "$vboxmanage" modifyvm $final_vm_name --memory $vm_ram --graphicscontroller VMSVGA --vram 16
    Start-Sleep -Seconds 1
    if ($LASTEXITCODE -ne 0) {
        Write-Output "Erreur lors de la configuration de la mémoire pour '$final_vm_name'."
        continue
    }

    # Création du contrôleur SATA
    $storagectl_sata_result = & "$vboxmanage" storagectl $final_vm_name --name "SATA Controller" --add sata --controller IntelAhci
    Start-Sleep -Seconds 1
    if ($LASTEXITCODE -ne 0) {
        Write-Output "Erreur lors de la création du contrôleur SATA pour '$final_vm_name'."
        continue
    }

    # Création du contrôleur IDE
    $storagectl_ide_result = & "$vboxmanage" storagectl $final_vm_name --name "IDE Controller" --add ide
    Start-Sleep -Seconds 1
    if ($LASTEXITCODE -ne 0) {
        Write-Output "Erreur lors de la création du contrôleur IDE pour '$final_vm_name'."
        continue
    }

    # Attachement du lecteur CD-ROM au contrôleur IDE
    $storageattach_cd_result = & "$vboxmanage" storageattach $final_vm_name --storagectl "IDE Controller" --port 0 --device 0 --type dvddrive --medium emptydrive
    Start-Sleep -Seconds 1
    if ($LASTEXITCODE -ne 0) {
        Write-Output "Erreur lors de l'attachement du lecteur CD-ROM pour '$final_vm_name'."
        continue
    }

    # Clonage du disque dur template, cette fois sans sortie
    $clonemedium_result = & "$vboxmanage" clonemedium disk "$template_disk_path" "$new_disk_path" --format VDI > $null 2>&1
    Start-Sleep -Seconds 2
    if ($LASTEXITCODE -ne 0) {
        Write-Output "Erreur lors du clonage du disque dur pour '$final_vm_name'."
        continue
    }

    # Attachement du disque dur cloné à la VM
    $storageattach_hdd_result = & "$vboxmanage" storageattach $final_vm_name --storagectl "SATA Controller" --port 0 --device 0 --type hdd --medium "$new_disk_path"
    Start-Sleep -Seconds 1
    if ($LASTEXITCODE -ne 0) {
        Write-Output "Erreur lors de l'attachement du disque dur cloné pour '$final_vm_name'."
        continue
    }

    # Configuration de la carte réseau en NAT
    $modifyvm_network_result = & "$vboxmanage" modifyvm $final_vm_name --nic1 nat
    if ($LASTEXITCODE -ne 0) {
        Write-Output "Erreur lors de la configuration du réseau pour '$final_vm_name'."
        continue
    }

    Write-Output "VM '$final_vm_name' créée et configurée avec succès."
}
