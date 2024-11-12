# Configuration d'un serveur DHCP sur Windows server 22


1) Configuration du service DHCP avec paramétrage plage IP


Une fois la vm windows server démarré (et à jour) on ajoute le rôle de serveur DHCP à notre serveur en suivant les étapes suivantes:

	- Tout d'abord on donne une IP fixe au serveur (172.20.0.101/24 dans notre cas)
	- cliquer sur Add Roles and Features
	- chose Role-based or …
	- chose your server
	- select DHCP server and click Add Features dans la fenêtre contextuelle puis cliquer sur Next
	- on passe les Features en appuyant sur next
	- On clique sur next une nouvelle fois dans la section DHCP (bien avoir une ip fixe)
	- et maintenant on clique sur install sans avoir besoin de redémarrer

Maintenant que le service DHCP est installé on le paramètre:

	- aller dans la section DHCP, cliquez droit sur votre serveur et cliquez sur DHCP manager
	- dans la bar de gauche sélectionner votre serveur puis clique droit sur ipv4 et enfin new scope;
	- appuyez sur next, puis donner un nom à votre étendue (serveur_dhcp pour l 'exo) puis cliquez sur next
	- entrez l'adresse ip de début (172.20.0.100) et ensuite celle de fin (172.20.0.200) et indiquer 24 dans lenght puis cliquez sur next
	- cliquez encore sur next (on ne reserve pas d'adresse ip dans cette plage) et encore next (on ne touche pas au bail pour l'instant) et enfin on choisi yes, i want… 	et next encore une fois.
	- Pour l'instant on ne paramètre pas de default Gateway, pareil pour le dns donc on clique deux fois sur next
	- Pareil pour WINS server on laisse vide et next,
	- on choisi yes, i want… et on clique sur next et enfin sur finish

On voit bien que notre scope est créer on peut maintenant réserver l'adresse IP pour notre machine particulière:

	- Dans le DHCP manager à droite, déroulez le scope créé et clique droit sur réservation puis new réservation;
	- Ajoutez le nom de votre périphérique, l'adresse IP qui lui ai réservé (172.20.0.10) ainsi que son adresse MAC puis choisissez DHCP dans supported types.


2) Configuration des cartes réseaux des VMs

Pour que ce système fonctionne entre plusieurs VMs il faut mettre nos Vms sur un réseau interne. Pour cela allez dans les parametres de vos VMs, puis dans réseau et la vous choisissez en mode d'accés réseau: réseau interne, et ensuite sélectionnez le même réseau (ici intnet) pour vos deux VMs.