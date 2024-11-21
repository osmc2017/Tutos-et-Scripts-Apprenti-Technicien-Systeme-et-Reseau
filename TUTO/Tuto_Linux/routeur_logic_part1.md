# Routeur logique sous Debian 1er partie

## Explication

on fait un routeur qui permet de faire communiquer un réseau privé et internet

## Préparation du Labo
- labo:
    - 1 routeur debian
    - 2 clients windows
 
 Clients sur le même réseau interne et configurer les adresses ip des clients
 - 192.168.1.1/24   gateway: 192.168.1.254
 - 192.168.2.2/24   gateway: 192.168.2.254

 Et on vérifie avec `ipconfig`


On paramètre IP sur le serveur Débian (avec deux cartes réseaux)
> `nano /etc/network/interfaces`

> enp0s3 en `static` et address `192.168.1.254/24` On sauvegarde puis `systemctl restart networking.service`

> enp0s8 en `static` et address `192.168.2.254/24` On sauvegarde puis `systemctl restart networking.service`

On peut se connecter en ssh depuis le client ( pour copier coller)

> On test depuis les clients si on peut ping les nouvelles passerelles du serveur.

> On lance Wireshark sur nos client et on surveille le trafic Ethernet.

## Activation du routage sur le serveur

> On vérifie si le routage est activé avec `cat /proc/sys/net/ipv4/ip_forward` et si on a 0 alors il est désactivé.

```
( si on le passe a 1 avec `echo 1 > /proc/sys/net/ipv4/ip_forward` et on revérifie et on a bien un 1; Les ping fonctionnent car le routeur est sur les deux réseaux mais que en interne, on veut faire du NAT. /proc chargé dans la ram donc cette méthode n'est pas pérenne car perdu au redémarrage.)
```

> Ce fichier est dans le disque donc on fait `nano /etc/sysctl.conf` et décommente `net.ipv4.ip_forward=1` puis `sysctl -p`pour activer le routage et on redémarre

> On vérifie `cat /proc/sys/net/ipv4/ip_forward` pour voir si tout est bien activé

> On test avec des ping et sur qireshark on voit que les machines communiquent directement.

## Régle NAT sur le serveur (netfilter /**nftable** /iptable parefeu intégré)

On va créer une table, mettre des chaîne et paramétrés les "hook" (point d'accroche) et y mettre des règles:

> Création de la table table_NAT en IP avec `nft add table ip table_NAT`

> on lites les tables avec `nft list tables`et on la voit 

> on créé la chaîne avec `nft add chain ip table_NAT chain_postrouting {type nat hook postrouting priority 0 \; }`

> On vérifie notre chaîne avec `nft list table ip table_NAT` ;

> On écrit notre régle `nft add rule table_NAT chain_postrouting ip saddr 192.168.1.0/24 oif enp0s8 snat 192.168.2.254`

> On vérifie notre regle avec `nft list table ip table_NAT` ;

Maintenant quand on va tester avec un `ping`et on voit, via wireshark que maintenant c'est le serveur qui envoit le ping au client 2 mais le 1, recoit  du client 2 directement. On va paramétrer pour l'autre client.

> On ajoute une règle: `nft add rule table_NAT chain_postrouting ip saddr 192.168.2.0/24 oif enp0s3 snat 192.168.1.254`

On fait un ping sur l'autre client et tout est bon.

> On copie nos règle dans un fichier `nft list table table_NAT > myrules.nft` en cas de coupure.

## En cas de redémarrage On fait de façon que la config de NATse charge au démarrage

> nano /etc/network/interface

> on rajoute:
```
# Command equi charge la table_NFT  aprés l'activation des cartes réseaux
pre-up nft -f /root/myrules.nft #mauvaise pratique de mettre dans root
```

> Maintenant on n'est plus censé perdre la config au redémarrage du service:
> `systemctl restart networking.service`

# La suite au prochain épisode.


