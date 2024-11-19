# Mise en place serveur DNS sur Debian

> On installe les paquets: `apt install bind9utils bind9-doc`

> On configure l'adresse IP avec `sudo nano etc/interface` en entrant une ip fixe;

> Ensuite `systemctl restart networking.service`;

> On vérifie avec `ip -c -4 a`.

## On configure notre fichier DNS

>On fait `cd /etc/bind/` puis `nano named.conf`;

>On commente la dernière ligne et on svg;

>On configure avec `nano named.conf.local`:
```
#zone direct => on donne le nom que l'on veut au lieu de stars
zone "stars.local" {
    type master;
    file "/etc/bind/stars-directe";
};
#zone indirect
zone "0.0.10.in-addr.arpa" {
    type master;
    file "/etc/bind/stars-inverse";
}"
```

> On vérifie avec: `systemctl status bind9`;

> on copie le fichier db.local avec `cp db.local star-directe` et ensuite on le configure:
```
$ORIGIN @ 

$TTL    604800
@               SOA     SRV-DNS             admin.stars.local. (
                        2                   ; Serial
                        604800              ; Refresh
                        86400               ; Retry
                        2419200             ; Expire
                        604800 )            ; Negative Cache TTL

@               NS      SRV-DNS
SRV-DNS         A       10.0.0.250 (#addresse ip de notre serveur)
W10-Client      A       10.0.0.1
```

> On vérifie avec `journalctl -xe` et on voit qu'il y a moins d'erreur;  

>`named-checkzone stars.local /etc/bind/stars-directe` => tout ok;

>`named-checkzone stars.local /etc/bind/stars-inverse` => erreur fichier à configurer;

> on copie le fichier db.local avec `cp starts-directe star-inverse` et ensuite on le configure:
```
$ORIGIN @ 

@               SOA         SRV-DNS.stars.local.             admin.stars.local. (
                            2                                   ; Serial
                            604800                              ; Refresh
                            86400                               ; Retry
                            2419200                             ; Expire
                            604800 )                            ; Negative Cache TTL


@               NS          SRV-DNS.stars.local.
250             PTR         SRV-DNS.stars.local.
1               PTR         W10-Client.stars.local.   
```

> nano resolv.conf : 
```
domain lan 
search lan
nameserver SRV-DNS
``` 

> On redémarre le service avec `systemctl restart bind9`;

> On vérifie avec `journalctl -xe`et la plus d'erreur;


## TEST

> Tout d'abord on met le client sur le même réseau que notre serveur et on lui donne une ip fixe et on lui met l'addresse de notre serveur dns `10.0.0.250`;

> On ping notre serveur avec `SRV-DNS.stars.local` et on a bien une résolution de nom;

>On ping notre client avec `10.0.0.1`;

> ensuite on ping son  nom `W10-Client.stars.local` et tout fonctionne.
