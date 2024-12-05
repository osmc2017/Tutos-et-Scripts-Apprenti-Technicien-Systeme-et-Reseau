# Routeur logique sous Debian (1ère partie)

## Explication

On crée un routeur permettant de faire communiquer un réseau privé et Internet.

## Préparation du labo
- **Labo** :
    - 1 routeur Debian
    - 2 clients Windows

Les clients sont sur le même réseau interne. Il faut configurer les adresses IP des clients :
- `192.168.1.1/24` avec passerelle : `192.168.1.254`
- `192.168.2.2/24` avec passerelle : `192.168.2.254`

Vérifiez avec la commande `ipconfig`.

## Paramétrage IP sur le serveur Debian (avec deux cartes réseau)

- Ouvrir le fichier de configuration réseau avec :  
  `nano /etc/network/interfaces`

- Configurer `enp0s3` en `static` avec l'adresse `192.168.1.254/24`. Sauvegardez et relancez le service avec :  
  `systemctl restart networking.service`

- Configurer `enp0s8` en `static` avec l'adresse `192.168.2.254/24`. Sauvegardez et relancez le service avec :  
  `systemctl restart networking.service`

Vous pouvez vous connecter en SSH depuis les clients pour copier/coller les configurations.

- Testez depuis les clients si vous pouvez pinger les nouvelles passerelles du serveur.

- Lancez Wireshark sur vos clients et surveillez le trafic Ethernet.

## Activation du routage sur le serveur

- Vérifiez si le routage est activé avec la commande :  
  `cat /proc/sys/net/ipv4/ip_forward`. Si la valeur est `0`, le routage est désactivé.

```
( si on le passe a 1 avec `echo 1 > /proc/sys/net/ipv4/ip_forward` et on revérifie et on a bien un 1; Les ping fonctionnent car le routeur est sur les deux réseaux mais que en interne, on veut faire du NAT. /proc chargé dans la ram donc cette méthode n'est pas pérenne car perdu au redémarrage.)
```

- Pour rendre cette configuration persistante, éditez le fichier `nano /etc/sysctl.conf`, décommentez la ligne `net.ipv4.ip_forward=1`, puis appliquez les changements avec :  
  `sysctl -p`

- Vérifiez de nouveau avec `cat /proc/sys/net/ipv4/ip_forward` pour confirmer que le routage est activé.

- Testez avec des pings. Sur Wireshark, vous devriez voir que les machines communiquent directement.

## Règle NAT sur le serveur (Netfilter, nftables, iptables)

On va créer une table, ajouter des chaînes et définir des règles NAT :

- Créez la table NAT en IP avec :  
  `nft add table ip table_NAT`

- Listez les tables avec :  
  `nft list tables` et vous verrez la table `table_NAT`.

- Créez la chaîne pour le NAT avec :  
  `nft add chain ip table_NAT chain_postrouting {type nat hook postrouting priority 0 \; }`

- Vérifiez la chaîne avec :  
  `nft list table ip table_NAT`

- Ajoutez la règle pour le NAT :  
  `nft add rule table_NAT chain_postrouting ip saddr 192.168.1.0/24 oif enp0s8 snat 192.168.2.254`

- Vérifiez la règle avec :  
  `nft list table ip table_NAT`

Maintenant, testez avec un `ping` et utilisez Wireshark pour observer que le serveur envoie le ping au client 2, mais que le client 1 reçoit directement du client 2. Vous devrez configurer la même chose pour l'autre client.

- Ajoutez une règle pour l'autre client :  
  `nft add rule table_NAT chain_postrouting ip saddr 192.168.2.0/24 oif enp0s3 snat 192.168.1.254`

- Testez avec un ping de l'autre client, et tout devrait être opérationnel.

- Sauvegardez vos règles dans un fichier avec :  
  `nft list table table_NAT > myrules.nft` au cas de coupure.

## En cas de redémarrage : chargez la configuration NAT au démarrage

- Ouvrez le fichier de configuration réseau avec :  
  `nano /etc/network/interfaces`

- Ajoutez la ligne suivante pour charger la table NAT après l'activation des cartes réseau :

```
# Commande qui charge la table_NFT aprés l'activation des cartes réseaux
pre-up nft -f /root/myrules.nft #mauvaise pratique de mettre dans root
```


- Maintenant, la configuration de NAT ne devrait plus être perdue après un redémarrage. Testez avec :  
`systemctl restart networking.service`




