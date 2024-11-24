# Commande de configuration d'un routeur sur cisco packet tracer

## **Nommer le routeur**

```
Router> enable
   Router# configure terminal
   Router(config)# hostname R0
   R0(config)# 
```

## **Parametrage des interfaces**

- Explication:
    * interface GigabitEthernet0/* : Accède au mode de configuration de l'interface.
    * ip address : Définit l'adresse IPv4 et son masque de sous-réseau pour l'interface.
    * ipv6 address : Définit l'adresse IPv6 et son préfixe pour l'interface.
    * no shutdown : Active l'interface.
    * exit : Quitte le mode de configuration de l'interface pour retourner au mode de configuration terminal.
    * ipv6 unicast-routing : Active le routage de IPv6.

- Exemple:

```
R0> enable
R0# configure terminal
R0(config)# interface GigabitEthernet0/0
R0(config-if)# ip address 192.168.1.1 255.255.255.0         #a modifier
R0(config-if)# ipv6 address 2001:db8:f3c1:1::1/64           #a modifier
R0(config-if)# no shutdown
R0(config-if)# exit
R0(config)# interface GigabitEthernet0/1
R0(config-if)# ip address 192.168.2.1 255.255.255.0         #a modifier
R0(config-if)# ipv6 address 2001:db8:f3c1:2::1/64           #a modifier
R0(config-if)# no shutdown
R0(config-if)# exit
R0(config)# ipv6 unicast-routing
```

## **Sauvegarde de la configuration**

```
R0> enable
   R0# copy running-config startup-config
   Destination filename [startup-config]? 
   Building configuration...
   [OK]
```

## **Connecter deux routeur**

- Explication:  
    - interface GigabitEthernet0/* : Accède au mode de configuration de l'interface.
    - ip address : Définit l'adresse IPv4 et son masque de sous-réseau pour l'interface.
    - ipv6 enable : Active l'IPv6 sur l'interface en génère une adresse link-local.
    - no shutdown : Active l'interface.
    - exit : Quitte le mode de configuration de l'interface pour retourner au mode de configuration terminal.
    - ipv6 unicast-routing : Active le routage de IPv6.
    - Utiliser un CIDR en /30 permet d'avoir seulement deux addresses utilisables ce qui est bien pour connecter deux routeur. On va prendre un exemple pour un sous-réseau en `192.168.4.0/30`

- Exemple:

    - Routeur 1

```
R0> enable
R0# configure terminal
R0(config)# interface GigabitEthernet0/2
R0(config-if)# ip address 192.168.4.1 255.255.255.252
R0(config-if)# ipv6 enable
R1(config)# ipv6 unicast-routing                            # Si pas notifier précédemment
R0(config-if)# no shutdown
R0(config-if)# exit

```
    - Routeur 2:

```
R1> enable
R1# configure terminal
R1(config)# interface GigabitEthernet0/0
R1(config-if)# ip address 192.168.4.2 255.255.255.252
R1(config-if)# ipv6 enable
R1(config)# ipv6 unicast-routing
R1(config-if)# no shutdown
R1(config-if)# exit
```

Les adresses de lien local IPv6 FE80::/10 sont générées automatiquement en utilisant la méthode EUI-64 à partir de l'adresse MAC de l'interface réseau. N'oublie pas de noter ces adresses IPv6 de lien local, car tu en auras besoin plus tard pour configurer les routes IPv6.

Pour les visualiser, utilise la commande `do show ipv6 interface brief`.

Voici les adresses générées par les deux interfaces de mes deux routeurs :

`R0 / GigabitEthernet0/2 : FE80::260:70FF:FECD:3703`
`R1 / GigabitEthernet0/0 : FE80::20C:85FF:FE83:1D01`

## **Déclaration de route statique 

- Explication:
    - Pour déclarer les routes statiques sur les routeurs Cisco, utilise la commande ip route. Assure-toi d'être en mode configuration Router(config)#.
        - Exemple v4 : pour déclarer la route statique IPv4 vers le réseau 10.0.0.0/8 via la passerelle 9.0.0.254
            - Router(config)# ip route 10.0.0.0 255.0.0.0 9.0.0.254
        - Exemple v6 : pour déclarer la route statique IPv6 vers le réseau fd03:5fe:b:a3f::/64 via la passerelle FE80::1, spécifie également l'interface de sortie
            - Router(config)# ipv6 route fd03:5fe:b:a3f::/64 GigabitEthernet0/0 FE80::1

- Exemple (Adapte les commandes avec tes propres adresses de lien local FE80::. Pour voir les adresses configurées, utilise la commande `show ipv6 interface brief`):

    - Routeur 1
```
R0> enable
R0# configure terminal
R0(config)# ip route 192.168.3.0 255.255.255.0 192.168.4.2
R0(config)# ipv6 route 2001:db8:f3c1:3::/64 GigabitEthernet0/2 FE80::20C:85FF:FE83:1D01
```

    - Routeur 2
```
R1> enable
R1# configure terminal
R1(config)# ip route 192.168.1.0 255.255.255.0 192.168.4.1
R1(config)# ip route 192.168.2.0 255.255.255.0 192.168.4.1
R1(config)# ipv6 route 2001:db8:f3c1:1::/64 GigabitEthernet0/0 FE80::260:70FF:FECD:3703
R1(config)# ipv6 route 2001:db8:f3c1:2::/64 GigabitEthernet0/0 FE80::260:70FF:FECD:3703
```

# **Paramétrage du NAT**