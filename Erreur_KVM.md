# ERREUR "no support for hardware accelerated KVM" DANS VM

 1ER CHOSE A FAIRE:


- ACTIVER LA VIRTUALISATION DANS LE BIOS: Intel : Activez "Intel VT-x" (Virtualization Technology) / AMD : Activez "AMD-V"
- DESACTIVER HYPER V ET REDEMARRER: 
> Disable-WindowsOptionalFeature -Online -FeatureName Microsoft-Hyper-V-All 
- SI LE BOUTON D ACTIVATION DE VIRTUALISATION EST ENCORE GRISE DANS LA VM ON LE FORCE AVEC:
> VBoxManage modifyvm "NomDeVotreVM" --nested-hw-virt on

---
SI CA NE FONCTIONNE TOUJOURS PAS:

- ON VERIFIE LES SERVICE DE VIRTUALISATIONS AVEC :
> Get-WmiObject -Query "select * from Win32_Processor" | fl VirtualizationFirmwareEnabled,SecondLevelAddressTranslationExtensions

=> SI FALSE SUIVRE LES ETAPES SUIVANTES

- WSL UTILISE LA VIRTUALISATION ET PEUT ENTRER EN CONFLIT AVEC LES VM, ON LE DESACTIVE ET ON REDEMARRE:
> dism.exe /online /disable-feature /featurename:Microsoft-Windows-Subsystem-Linux

> dism.exe /online /disable-feature /featurename:VirtualMachinePlatform

- ON VERIFIE DE NOUVEAU LES SERVICE SI TOUT EST SUR TRUE TOUT DEVRAIT FONCTIONNE NORMALEMENT (LE BOUTON N EST PLUS GRISE NORMALEMENT) 
- SI TOUJOURS SUR FALSE ON DESACTIVE L'ISOLATION DU NOYAU DANS 
=> PARAMETRES/CONFIDENTIALITE ET SECURITE/SECURITE WINDOWS/SECURITE DE L APPAREIL/

- Pour activer kvm via PowerShell:
> Ouvrir Terminal en admin

> cd "C:\Program Files\Oracle\VirtualBox"

> .\VBoxManage list vms

> .\VBoxManage modifyvm "Nom_VM" --nested-hw-virt on
