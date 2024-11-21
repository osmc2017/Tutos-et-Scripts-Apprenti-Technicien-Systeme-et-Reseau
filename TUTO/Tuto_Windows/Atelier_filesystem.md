ATELIER FILESYSTEM SUR DEBIAN=> VOIR RECO MACHINE
------------------------------------------------------------------
			CONFIGURATION
=>AJOUTER UN DEUXIEME DISQUE AVANT TOUT (8GO C EST OK)
=> LA METTRE EN PONT

------------------------------------------------------------------
			EXERCICE

- ON VEUT PARTIONNER LE DEUXIEME DISQUE:UNE SVG ET UNE SWAP
- SE CONNECTER EN ROOT
blkid comme lsblk -f pour UUID
------------------------------------------------------------------

			ETAPE

- VERIFIER PARTIONNEMENT AVEC lsblk
=> on voit que le disque principal est en 3 partition dont une déjà SWAP=> system
=> on voit le sdb pas partionné ni rien

- on partionne avec cfdisk /dev/sdb
- on choisi DOS= MBR
- on le partionne en deux avec entrer = une de 6go en primary et la deuxième avec le reste en primary également
et on write puis quitter

- On verifie avec lsblk que tout est ok
- On formate les deux partition en ext4 la première et SWAP la deuxième:
	- mkfs.ext4 -L BACKUP /dev/sdb/sdb1 => On renomme avec -L => la partition récupère un UUID => identifiant unique
	- mkswap -L SWAP /dev/sdb/sdb2 => partionner en swap et renommé

- on verifie avec lsblk -f Pour avoir des info sur les UUID MAINTENANT on va désactiver le sda5 en SWAP et passer sur le nouveau:

	- swapoff /dev/sda5 => et on vérifie que le SWAP de sda5 a été désactivé
	- swapon /dev/sdb2 => et on vérifie que sdb2 est bien SWAP

ls /mnt => pour voir point de montage => on créé un dossier pour les montage de backup puis on monte
	- mkdir /mnt/backup
	- mount /dev/sdb1 /mnt/backup

- On vérifie avec lsblk si le disque et bien dans le /backup

- On configure les point de montage au demarrage dans /etc/fstab/ => on cat dedans pour vérifier:
	- on récupère l'autre avec blkid | grep LABEL >> /etc/fstab ou en ssh  root@adresseip sur deux fenêtres Windows (revoir SSH) => on fait lsblk -f sur la première et nano /etc/fstab sur la seconde => on commente un nouvel argument et on copie colle une autre ligne du fichier et on remplace avec celle dans l'autre page=> faire ca pour les deux disques (penser a mettre le dossier mount/backup/pour le sdb1)= > on modifie la ligne en remplaçant après UUID sdb1 et sdb2:
		- ext4	default	0	0
		- swap sw	0	0
	- on désactive celui de sda 


- On vérifie avec la commande mount -a
- on vérifie avec lsblk que tout est ok
- on redémarre avec reboot
- on vérifie dans fstab
