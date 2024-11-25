# Tuto : Utiliser Stream Deck sur Proxmox pour allumer un PC via Wake on LAN !!!!!!!!!!!en test!!!!!!!!

Ce tutoriel vous guide à travers les étapes pour configurer un **Stream Deck** sur une **VM Windows** dans **Proxmox** afin de réveiller un PC via **Wake on LAN**.

## Étape 1 : Créer une VM Windows sur Proxmox

1. **Télécharger l'ISO de Windows** :
   - Allez sur le site de Microsoft et téléchargez l'ISO d'une version de **Windows** (Windows 10 ou 11).

2. **Créer la VM sur Proxmox** :
   - Ouvrez l'interface web de Proxmox.
   - Allez dans **Datacenter** > **Node** > **Create VM**.
   - Entrez un **nom** pour votre VM (par exemple, `Windows-StreamDeck`).
   - Sélectionnez l'ISO de Windows que vous avez téléchargé dans le champ **CD/DVD**.
   - Attribuez une **quantité de mémoire** et de **CPU** en fonction de la capacité de votre hôte.
   - Configurez un **disque dur** virtuel avec suffisamment d'espace pour Windows et Stream Deck (20 Go minimum).

3. **Installer Windows** :
   - Démarrez la VM, connectez-vous à la console via l'interface Proxmox.
   - Suivez l'installation de **Windows** comme sur un PC classique.
   - Une fois l'installation terminée, vous aurez une VM Windows prête à l'emploi.

## Étape 2 : Installer Stream Deck dans la VM Windows

1. **Télécharger et installer Stream Deck** :
   - Allez sur le site d'**Elgato** pour télécharger le logiciel **Stream Deck** pour Windows.
   - Installez **Stream Deck** dans la VM Windows comme vous le feriez sur un PC standard.

2. **Brancher le Stream Deck** :
   - Connectez votre **Stream Deck** à l'hôte Proxmox via USB.
   - Vous devrez peut-être activer la redirection USB dans Proxmox pour que la VM Windows puisse reconnaître le périphérique.
     - Allez dans l'interface de Proxmox > sélectionnez votre VM > **Hardware** > **Add** > **USB Device**.
     - Sélectionnez le périphérique **Stream Deck**.

3. **Configurer Stream Deck** :
   - Lancez **Stream Deck** dans la VM Windows.
   - Ajoutez un bouton sur l'interface de Stream Deck pour envoyer un script **Wake on LAN**.

## Étape 3 : Créer un script Wake on LAN dans la VM Windows

1. **Télécharger un utilitaire Wake on LAN** :
   - Téléchargez un utilitaire pour envoyer des paquets **Wake on LAN** depuis Windows, comme **WakeMeOnLan** de NirSoft : [Télécharger WakeMeOnLan](https://www.nirsoft.net/utils/wake_on_lan.html).
   - Extraire et installer l’utilitaire.

2. **Créer un script pour Wake on LAN** :
   - Créez un fichier **batch** ou **PowerShell** pour envoyer un paquet WOL. Par exemple, un script PowerShell simple pour envoyer un paquet WOL pourrait ressembler à cela :
   
   ```powershell
   # wakeonlan.ps1
   $macAddress = "XX:XX:XX:XX:XX:XX"  # Remplacez par l'adresse MAC de votre PC cible
   $broadcast = "192.168.1.255"  # Remplacez par l'adresse de diffusion de votre réseau
   $port = 9
   $sock = New-Object System.Net.Sockets.UdpClient
   $sock.Connect($broadcast, $port)
   $magicPacket = [byte[]]@(0xFF) * 6 + ([byte[]](($macAddress -split ":") | ForEach-Object { [Convert]::ToByte($_, 16) }))
   $sock.Send($magicPacket, $magicPacket.Length)
   $sock.Close()
   ```

3. **Tester le script** :
   - Ouvrez une fenêtre PowerShell ou **cmd** dans la VM Windows et exécutez votre script **Wake on LAN** pour vérifier qu'il fonctionne correctement.
   - Si votre PC cible est bien configuré pour le Wake on LAN, il devrait se réveiller.

## Étape 4 : Configurer le Stream Deck pour envoyer un WOL

1. **Configurer le bouton Stream Deck** :
   - Dans l'interface **Stream Deck** de la VM Windows, ajoutez un bouton qui exécutera le script **Wake on LAN**.
   - Cliquez sur un bouton vide de l'interface Stream Deck et sélectionnez **System > Open** pour ouvrir un programme.
   - Dans le champ **Action**, mettez le chemin vers le script **PowerShell** ou **batch** que vous avez créé pour envoyer le paquet **Wake on LAN**. Par exemple :
     - Pour PowerShell : `powershell.exe -ExecutionPolicy Bypass -File "C:\cheminers\wakeonlan.ps1"`
     - Pour un script batch : `"C:\cheminers\wakeonlan.bat"`

2. **Tester le Stream Deck** :
   - Appuyez sur le bouton **Stream Deck** pour tester si le PC cible se réveille en envoyant un paquet **Wake on LAN**.

## Résumé

1. **Créer une VM Windows** sur Proxmox.
2. **Installer Stream Deck** sur la VM Windows.
3. **Connecter le Stream Deck à la VM** via USB redirigé.
4. **Créer un script Wake on LAN** dans la VM Windows.
5. **Configurer le Stream Deck** pour exécuter ce script.
