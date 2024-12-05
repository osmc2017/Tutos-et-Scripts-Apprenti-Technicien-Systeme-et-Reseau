*** AS sur le réseau => plusieurs zones et domaine => EGP = exterior Gateway Protocol et IGP = Interieur Gateway Protocol et BGP = Border Gateway Protocol***

# Routeur logique sous Debian (3ème partie)

## Installation de frr et configuration

#### Routeur interne

- On installe le logiciel frr
>apt install frr

- On va configurer le dossier daemons:

>nano /etc/frr/daemons
```
ripd=yes        # vecteur de distance = il regarde les bonds et indique la meilleure route
```
- Il faut relancer le service et on vérifie le service:

>systemctl restart frr.service

>systemctl status frr.service

- On configure le fichier frr.conf:

>nano /etc/frr/frr.conf

```
# active la journalisation
log syslog informational

#precise le protocole de cette configuration
router rip
version 2

#indique l'interface sur laquelle le protocole rip doit être géré
network enp0s3
# On peut egalement déclarer les cartes réseaux au lieu de la plages ip

#Indiquer les réseaux auxquels le routeur a accés dans une plage d'adresses
network 10.0.0.0/22

#désactive l'agglomération de routes en une avec un CIDR non maîtrisé
no auto-summary
```
- Il faut relancer le service et on vérifie le service:

>systemctl restart frr.service

>systemctl status frr.service

- utilisation de l'outil:
 ```
vtysh
    show ip neigh   # montre les "voisins"
```

#### Routeur Edge

- On installe le logiciel frr

>apt install frr

- On va configurer le dossier daemons:

>nano /etc/frr/daemons
```
ripd=yes        # vecteur de distance = il regarde les bonds et indique la meilleure route
```
Il faut relancer le service et on vérifie le service:

>systemctl restart frr.service

>systemctl status frr.service

- On configure le fichier frr.conf:

>nano /etc/frr/frr.conf

```
# active la journalisation
log syslog informational

#precise le protocole de cette configuration
router rip
version 2

#indique l'interface sur laquelle le protocole rip doit être géré
network enp0s8

#désactive l'agglomération de routes en une avec un CIDR non maîtrisé
no auto-summary
```
- Il faut relancer le service et on vérifie le service:

>systemctl restart frr.service

>systemctl status frr.service

- On vérifie les routes et on voit que l'on a bien toute nos routes de déclarées:
>ip route

# La suite dans la partie 4: Installation et configuration d'un serveur DHCP (R-INTER)
