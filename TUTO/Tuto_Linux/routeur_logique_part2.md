# Routeur logique sous Debian (2ème partie)

## On prépare nos routeurs (VM Debian)

- on nomme nos routeurs
> `echo R-EDGE > /etc/hostname`
> `echo R-INTER > /etc/hostname`

### Configuration des réseaux

#### Routeur edge
- On édite le fichier **/etc/network/interfaces.d**:
```
allow-hotplug enp0s8
iface enp0s8 inet static
    address 10.0.99.254/30
```

- On active la fonction de routage de facon persistente dans **/etc/sysctl.conf** en décochant:
```
net.ipv4.ip_forward=1
net.ipv6.conf.all.forwarding=1
```
- On redémarre le service avec `systemctl restart networking.service`.

#### Routeur interne
- On édite le fichier **/etc/network/interfaces.d**:
```
allow-hotplug enp0s3 enp0s8 enp0s9 enp0s10
iface enp0s3 inet static
    address 10.0.99.253/30
    gateway 10.0.99.254

iface enp0s8 inet static
    address 10.0.1.254/24
   
iface enp0s9 inet static
    address 10.0.2.254/24
   
iface enp0s10 inet static
    address 10.0.3.254/24
   ```
- On redémarre le service avec `systemctl restart networking.service`.
- On vérifie avec `ip route`.

### Règle NAT

#### Routeur Edge

- On parametre le NAT:
```
nft add table ip table_NAT
nft add chain ip table_NAT chain_postrouting { type nat hook postrouting priority @ \; }
nft add rule table_NAT chain_postrouting ip saddr 10.0.99.252/30 oif enp0s3 snat 192.168.1.110 
nft list table ip table_NAT > table_NAT.nft
```
- On liste avec `nft list table ip table_NAT`.

- On édite le fichier **/etc/network/interfaces.d**:
```
allow-hotplug enp0s3
iface enp0s3 inet dhcp
pre-up nft -f /root/table_NAT 
```
- On redémarre le service avec `systemctl restart networking.service`.

- On vérifie si on a internet en faisant un ping `8.8.8.8`.
- Tout est bon.

### Accés internet Vlan 1

#### Routeur Edge
- On edite avec `nano table_NAT.nft
```
table ip table_NAT { 
    chain chain_postrouting {
        type nat hook postrouting priority filter; policy accept;
        ip saddr 10.0.99.252/30 oif "enp0s3" snat to 192.168.1.110
        ip saddr 10.0.0.0/22 oif "enp0s3" snat to 192.168.1.110
    }
}
```
- On rajoute la route pour que le vlan 1 puise communiquer avec internet `ip route add 10.0.1.0/24 via 10.0.99.253`.
- Un client du vlan 1 a bien accés à internet.
 

# La suite dans la partie 3!