
pour la configuration mode configuration global:
```
configuration terminal
```

changer le nom
```
hostname <nomadonner>
```

voir si le changement a bien été pris en compte:
```
show running-config (dans le mode normal)
```

pour ssh il faut lui donner un nom de domaine:
```
configure terminal
ip domain-name <nomdudomain>
exit
sh running-config
```

pour sauvegarder:
```
copy running-config to startup-config
```

On créer un vlan "exotique" et on y met toutes les interfaces (mesure de sécurité)
```
conf t
vlan 399
show running-config
interface range fastEthernet 0/1-24
switchport mode access (evite les interfaces de se faire negocier)
switchport access vlan 399
end
interface range g0/1-2
switchport access vlan 399
show running-config | section int
sh vlan
```


commande basique
? => permet de donner la liste de commande peut etre placé aprés une commande tel que show
show => permet de voir des choses tel que startup-config
show running config
show ip interface
show startup-config
