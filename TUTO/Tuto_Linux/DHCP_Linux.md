# PARAMETRAGE SERVEUR DHCP SUR LINUX


- on installe avec `sudo apt install isc-dhcp-server`

- On peut maintenant paramétrer nos cartes réseau (si VMs) sur le mode réseau interne en mettant bien le même réseau sur notre serveur et nos clients

- on paramètre notre ip fixe sur notre serveur (172.20.0.5/24) dans les paramètres de notre Ubuntu;

- on configure dans `sudo nano /etc/dhcp/dhcpd.conf` avec à la fin:


```    
subnet 172.20.0.0 netmask 255.255.255.0 
{   
    range 172.20.0.20 172.20.0.40;  
    option routers 172.20.0.1;        
    option subnet-mask 255.255.255.0; 
    option domain-name-servers 8.8.8.8, 8.8.4.4; 
}
```

- Ici on a paremetrer notre serveur DHCP sur le reseau 172.20.0.0/24 et il va attribuer des adresses dans la plage 172.20.0.20 - 172.20.0.40
- Nous avons bien attribué le masque sous réseau 255.255.255.0
- On a pris un nom de domaine générique (google)

- On configure ensuite une reservation d'ip (172.20.0.10) pour un appareil (avec son adresse MAC) dans le même fichier que précédemment, à la suite:

```
host nom_client 
{
    hardware ethernet [adresse mac]
    fixed-address 172.20.0.10;            # Remplacez par l'adresse IP souhaitée
}
```

- Maintenant on va configurer l'interface réseau (avant de la configurer la chercher avec la cmd ip a) dans le dossier /etc/default/isc-dhcp-server:
	- à la ligne INTERFACEv4= "enp0s3" => remplacer par votre interface réseau

- Maintenant que tout est parametrer suivez les étapes suivante
```
	- sudo systemctl restart isc-dhcp-server => on redémarre le service DHCP
	- sudo systemctl enable isc-dhcp-server => on active le service DHCP au démarrage
	- sudo systemctl status isc-dhcp-server => on vérifie que le service est activé
	- sudo ufw allow 67/udp => on autorise le port udp 67 sur le pare feu  qui correspond au service DHCP
```
- On démarre nos client (parametrer en DHCP) et on constate que nos adresses IP correspondent bien à notre plage et à l'adresse assigné.
