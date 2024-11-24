# SERVEUR DNS SUR DEBIAN

-----------------------------------------------------------------------

## Installation de Bind 9

- On met à jour les paquets avec:
```bash
sudo apt update 
sudo apt upgrade
```

- On installe les paquets:
```bash
sudo apt install -y bind9 bind9utils bind9-doc dnsutils
```

- On met une IP fixe pour notre serveur DNS (ici `192.168.0.40/24`)

- Si on travaille sur une VM, on met notre carte réseau sur réseau interne

- On redémarre les services réseau:
```bash
sudo systemctl restart NetworkManager
```

-----------------------------------------------------------------------

## Configuration de Bind

- On se déplace dans le dossier bind:
```bash
cd /etc/bind/
```

- On édite le fichier avec `sudo nano named.conf.options` afin de :
    * Autoriser la requête sur votre DNS à partir de votre réseau privé
    * Autoriser les requêtes récursives
    * Spécifier le port DNS (53)
    * Configurer les redirections de requêtes DNS
- On a donc rajouté dans le fichier:
```bash
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

- On édite maintenant le fichier `named.conf.local` afin de définir les fichiers de zone pour notre domaine en rajoutant :
```bash
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

- On copie le fichier `db.local` de cette façon:
```bash
sudo cp db.local forward.linuxtechi.local
```

- Maintenant on édite le nouveau fichier `forward.linuxtechi.local` avec:
```bash
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

- On copie le fichier `db.local` de cette façon:
```bash
sudo cp db.local reverse.linuxtechi.local
```

- Maintenant on édite le nouveau fichier `reverse.linuxtechi.local` pour zone directe et inversée mentionnés avec:
```bash
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

- Il faut ensuite modifier le fichier `/etc/default/named` afin que le service DNS écoute en IPV4:
```bash
OPTIONS = "-u bind -4"
```

- On démarre, on active le service BIND et on vérifie le status:
```bash
sudo systemctl start named
sudo systemctl enable named
sudo systemctl status named
```

- On autorise le port 53:
```bash
sudo ufw allow 53
```

---

## Validation de la syntaxe de Bind

- On peut vérifier la syntaxe des différents fichiers et si nous n'avons aucun retour tout est bon:
```bash
sudo named-checkconf /etc/bind/named.conf.local
sudo named-checkzone linuxtechi.local /etc/bind/forward.linuxtechi.local
zone linuxtechi.local/IN: loaded serial 2022072651
OK
sudo named-checkzone linuxtechi.local /etc/bind/reverse.linuxtechi.local
zone linuxtechi.local/IN: loaded serial 2022072752
OK
```

---

## On test notre serveur avec Dig et Nslookup

- Sur une autre machine Ubuntu, on modifie le fichier `/etc/resolv.conf` pour qu'il pointe vers notre serveur DNS:
```bash
search linuxtechi.local
nameserver 192.168.0.40
```

- Si `dig` n'est pas installé, on l'installe avec:
```bash
sudo apt install dnsutils -y
```

- On lance la commande suivante afin de trouver notre serveur et les informations associées:
```bash
dig primary.linuxtechi.local
```

- Maintenant on fait une recherche inversée:
```bash
dig -x 192.168.0.40
```

- On utilise `nslookup` pour confirmer la sortie de `dig`:
```bash
nslookup primary.linuxtechi.local
```

- Si nous n'avons aucune erreur, c'est que notre serveur DNS et ses services fonctionnent correctement.
