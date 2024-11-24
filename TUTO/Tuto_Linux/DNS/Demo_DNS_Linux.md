# Mise en place serveur DNS sur Debian

> On installe les paquets: `apt install bind9utils bind9-doc`

> On configure l'adresse IP avec `sudo nano /etc/interfaces` en entrant une ip fixe;

> Ensuite `systemctl restart networking.service`;

> On vérifie avec `ip -c -4 a`.

## On configure notre fichier DNS

> On fait `cd /etc/bind/` puis `nano named.conf`;

> On commente la dernière ligne et on sauvegarde;

> On configure avec `nano named.conf.local` :
```bash
#zone direct => on donne le nom que l'on veut au lieu de stars
zone "stars.local" {
    type master;
    file "/etc/bind/stars-directe";
};
#zone indirect
zone "0.0.10.in-addr.arpa" {
    type master;
    file "/etc/bind/stars-inverse";
}
```

> On vérifie avec: `systemctl status bind9`;

> On copie le fichier `db.local` avec `cp db.local stars-directe` et ensuite on le configure :
```bash
$ORIGIN @ 

$TTL    604800
@               SOA     SRV-DNS             admin.stars.local. (
                        2                   ; Serial
                        604800              ; Refresh
                        86400               ; Retry
                        2419200             ; Expire
                        604800 )            ; Negative Cache TTL

@               NS      SRV-DNS
SRV-DNS         A       10.0.0.250  # adresse ip de notre serveur
W10-Client      A       10.0.0.1
```

> On vérifie avec `journalctl -xe` et on voit qu'il y a moins d'erreurs;

> `named-checkzone stars.local /etc/bind/stars-directe` => tout ok;

> `named-checkzone stars.local /etc/bind/stars-inverse` => erreur fichier à configurer;

> On copie le fichier `db.local` avec `cp stars-directe stars-inverse` et ensuite on le configure :
```bash
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

> `nano resolv.conf` :
```bash
domain lan 
search lan
nameserver SRV-DNS
```

> On redémarre le service avec `systemctl restart bind9`;

> On vérifie avec `journalctl -xe` et il n'y a plus d'erreurs.

## TEST

> Tout d'abord on met le client sur le même réseau que notre serveur, on lui donne une IP fixe et on lui met l'adresse de notre serveur DNS `10.0.0.250`;

> On ping notre serveur avec `SRV-DNS.stars.local` et on a bien une résolution de nom;

> On ping notre client avec `10.0.0.1`;

> Ensuite, on ping son nom `W10-Client.stars.local` et tout fonctionne.
