# Paramétrage du Serveur DHCP sur Linux

## 1. Installation du serveur DHCP
Installez le serveur DHCP avec la commande suivante :
```bash
sudo apt install isc-dhcp-server
```

## 2. Configuration des cartes réseau (pour des VMs)
Si vous utilisez des machines virtuelles, paramétrez vos cartes réseau en mode réseau interne, en veillant à utiliser le même réseau pour le serveur et les clients.

## 3. Attribution d'une IP fixe au serveur
Configurez l'IP fixe du serveur (par exemple, `172.20.0.5/24`) dans les paramètres réseau de votre Ubuntu.

## 4. Configuration du serveur DHCP
Éditez le fichier de configuration `dhcpd.conf` avec la commande suivante :
```bash
sudo nano /etc/dhcp/dhcpd.conf
```

À la fin du fichier, ajoutez les lignes suivantes :
```bash
subnet 172.20.0.0 netmask 255.255.255.0 {
    range 172.20.0.20 172.20.0.40;
    option routers 172.20.0.1;
    option subnet-mask 255.255.255.0;
    option domain-name-servers 8.8.8.8, 8.8.4.4;
}
```

### Explications :
- Le serveur DHCP est configuré pour le réseau `172.20.0.0/24`.
- Il attribuera des adresses IP dans la plage `172.20.0.20 - 172.20.0.40`.
- Le masque de sous-réseau est `255.255.255.0`.
- Le nom de domaine utilisé est Google (`8.8.8.8` et `8.8.4.4`).

## 5. Réservation d'IP pour un appareil
Ajoutez une réservation d'adresse IP pour un appareil (par exemple, `172.20.0.10`) dans le même fichier de configuration. Ajoutez le code suivant après la configuration précédente :
```bash
host nom_client {
    hardware ethernet [adresse mac]
    fixed-address 172.20.0.10;  # Remplacez par l'adresse IP souhaitée
}
```

## 6. Configuration de l'interface réseau
Avant de configurer l'interface réseau, identifiez-la avec la commande suivante :
```bash
ip a
```

Ensuite, modifiez le fichier de configuration `/etc/default/isc-dhcp-server` :
- À la ligne `INTERFACESv4="enp0s3"`, remplacez `enp0s3` par l'interface réseau de votre serveur.

## 7. Redémarrage et activation du service DHCP
Une fois toutes les configurations effectuées, suivez les étapes suivantes pour redémarrer et activer le service DHCP :

```bash
sudo systemctl restart isc-dhcp-server   # Redémarre le service DHCP
sudo systemctl enable isc-dhcp-server    # Active le service DHCP au démarrage
sudo systemctl status isc-dhcp-server    # Vérifie que le service est activé
sudo ufw allow 67/udp                    # Autorise le port UDP 67 sur le pare-feu (service DHCP)
```

## 8. Vérification sur les clients
Démarrez vos clients configurés en mode DHCP et vérifiez que les adresses IP attribuées correspondent à la plage et à l'adresse réservée.
