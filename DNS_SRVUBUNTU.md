SERVEUR DNS SUR DEBIAN
-----------------------------------------------------------------------

**Installation de Bind 9**

- on met a jour les paquets avec:
>sudo apt update 
>sudo apt upgrade

- On installe les paquets:
>sudo apt install -y bind9 bind9utils bind9-doc dnsutils

- On met une IP fix pour notre serveur DNS (ici 192.168.0.40/24)

- Si on travail sur VM on met notre carte sur réseau interne

- On redémarre les service réseau:
>sudo systemctl restart NetworkManager
-----------------------------------------------------------------------

**Configuration de Bind**

- on se déplace dans le dossier bind:
>cd /etc/bind/

- On édite le fichier avec `sudo nano named.conf.options` afin:
    * Autoriser la requête sur votre DNS à partir de votre réseau privé (comme son nom l'indique, seuls les systèmes de votre réseau privé peuvent interroger le serveur DNS pour la traduction du nom en IP et vice-versa)
    * Autoriser les requêtes récursives
    * Spécifiez le port DNS ( 53)
    * Redirecteurs (la requête DNS sera transmise aux redirecteurs lorsque 
    * votre serveur DNS local ne sera pas en mesure de résoudre la requête)
- On a donc rajouter dans le fichier: 
``` 
acl internal-network {
192.168.0.0/24;
};
options {
        directory "/var/cache/bind";
        allow-query { localhost; internal-network; };
        allow-transfer { localhost; };
        forwarders { 8.8.8.8; };
        recursion yes;
        dnssec-validation auto;
        listen-on-v6 { any; };
};
```

- On édite maintenant le fichier `named.conf.local` afin de définir les fichiers de zone pour notre domaine en rajoutant:
```
zone "linuxtechi.local" IN {
        type master;
        file "/etc/bind/forward.linuxtechi.local";
        allow-update { none; };
};
zone "0.168.192.in-addr.arpa" IN {
        type master;
        file "/etc/bind/reverse.linuxtechi.local";
        allow-update { none; };
};
```
- On copie le fichier db.local de cette façon:
>sudo cp db.local forward.linuxtechi.local

- Maintenant on édite le nouveau fichier `forward.linuxtechi.local` avec:
```
$TTL 604800
@ IN SOA primary.linuxtechi.local. root.primary.linuxtechi.local. (
                                   2022072651 ; Serial
                                   3600 ; Refresh
                                   1800 ; Retry
                                   604800 ; Expire
                                   604600 ) ; Negative Cache TTL
;Name Server Information
@       IN  NS    primary.linuxtechi.local.

;IP address of Your Domain Name Server(DNS)
primary IN  A     192.168.0.40

;Mail Server MX (Mail exchanger) Record
linuxtechi.local. IN MX 10   mail.linuxtechi.local.

;A Record for Host names
www     IN  A    192.168.0.50
mail    IN  A    192.168.0.60

;CNAME Record
ftp     IN CNAME www.linuxtechi.local.
```
- On copie le fichier db.local de cette façon:
>sudo cp db.local reverse.linuxtechi.local

- Maintenant on édite le nouveau fichier `reverse.linuxtechi.local` pour zone directe et inversée mentionnés avec:
```
$TTL 86400
@ IN SOA linuxtechi.local. root.linuxtechi.local. (
                           2022072752 ;Serial
                           3600 ;Refresh
                           1800 ;Retry
                           604800 ;Expire
                           86400 ;Minimum TTL
)
;Your Name Server Info
@ IN NS primary.linuxtechi.local.
primary   IN  A    192.168.0.40
;Reverse Lookup for Your DNS Server
40        IN PTR   primary.linuxtechi.local.
;PTR Record IP address to HostName
50        IN PTR   www.linuxtechi.local.
60        IN PTR   mail.linuxtechi.local.
```
- Il faut ensuite modifier le fichier `/etc/default/named` afin que le service DNS ecoute IPV4:
>OPTIONS = "-u bind -4"

- On démarre, on active le service BIND et on vérifie le status:
>sudo systemctl start named
>sudo systemctl enable named
>sudo systemctl status named

-On autorise le port 53:
> sudo ufw allow 53
---
**Validation de la syntaxe de Bind**

- On peut vérifier la syntaxe des différent fichier et si nous n'avons aucun retour tout est bon:
>sudo named-checkconf /etc/bind/named.conf.local
>sudo named-checkzone linuxtechi.local /etc/bind/forward.linuxtechi.local
zone linuxtechi.local/IN: loaded serial 2022072651
OK
>sudo named-checkzone linuxtechi.local /etc/bind/reverse.linuxtechi.local
zone linuxtechi.local/IN: loaded serial 2022072752
OK
---
**On test notre serveur avec Dig et Nslookup**

- sur une autre machine ubuntu on modifie le fichier `/etc/resolv.conf` pour qu'il pointe notre serveur DNS:
```
search linuxtechi.local
nameserver 192.168.0.40
```
- Si dig n'est pas installer on l'installe avec `sudo apt install dnsutils -y` 

- On lance la commande suivante afin de trouver notre serveur et les informations associées:
>dig ptimary.linuxtechi.local

- Maintenant on fait une recherche inversé:
>dig -x 192.168.0.40

- On utiliser nslookup pour confirmer la sortie de dig:
>nslookup.primary.linuxtechi.local

- Si nous n'avons aucune erreur c'est que notre serveur DNS et ces services fonctionne correctement.
