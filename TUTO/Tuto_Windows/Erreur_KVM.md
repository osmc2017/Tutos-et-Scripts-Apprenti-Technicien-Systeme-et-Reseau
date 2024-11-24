# ERREUR "no support for hardware accelerated KVM" DANS VM

## 1ER CHOSE A FAIRE

1. **Activer la virtualisation dans le BIOS** :  
   - Pour Intel : activez "Intel VT-x" (Virtualization Technology)  
   - Pour AMD : activez "AMD-V"

2. **Désactiver Hyper-V et redémarrer** :  
   Exécuter la commande suivante dans PowerShell :  
   `Disable-WindowsOptionalFeature -Online -FeatureName Microsoft-Hyper-V-All`

3. **Si le bouton d'activation de virtualisation est encore grisé dans la VM, forcer l'activation** :  
   Exécuter la commande suivante dans le terminal :  
   `VBoxManage modifyvm "NomDeVotreVM" --nested-hw-virt on`

---

## SI CA NE FONCTIONNE TOUJOURS PAS

1. **Vérifier les services de virtualisation** :  
   Exécuter cette commande dans PowerShell :  
   `Get-WmiObject -Query "select * from Win32_Processor" | fl VirtualizationFirmwareEnabled,SecondLevelAddressTranslationExtensions`  
   Si les résultats sont `FALSE`, suivre les étapes suivantes.

2. **Désactiver WSL et redémarrer** :  
   WSL utilise la virtualisation et peut entrer en conflit avec les machines virtuelles. Pour le désactiver, exécuter les commandes suivantes dans PowerShell :  
   `dism.exe /online /disable-feature /featurename:Microsoft-Windows-Subsystem-Linux`  
   `dism.exe /online /disable-feature /featurename:VirtualMachinePlatform`

3. **Vérifier à nouveau les services** :  
   Si tout est sur `TRUE`, tout devrait fonctionner normalement. Le bouton d'activation de virtualisation ne devrait plus être grisé.

4. **Si toujours sur `FALSE`**, désactiver l'isolement du noyau dans les paramètres Windows :  
   Allez dans `Paramètres > Confidentialité et sécurité > Sécurité Windows > Sécurité de l'appareil`.

5. **Pour activer KVM via PowerShell** :  
   Ouvrir le terminal en tant qu'administrateur, puis exécuter les commandes suivantes :  
   `cd "C:\Program Files\Oracle\VirtualBox"`  
   `.\VBoxManage list vms`  
   `.\VBoxManage modifyvm "Nom_VM" --nested-hw-virt on`

