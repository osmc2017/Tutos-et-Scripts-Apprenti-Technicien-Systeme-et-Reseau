## Labo DNS sous Bind9

### :one: Dans ce tuto nous allons mettre en place un labo composé de :  
- un serveur DNS sous **Debian 12**  
- un client sous **Debian 12**  
- L'installation et la configuration du package **Bind9**
> Les adresses IP, CIDR, nom de carte réseau et nom de domaine/sous-domaine sont à modifier suivant votre application.

### :two: Configuration IP des deux machines
#### Serveur DNS sous Debian 12
##### :pencil2: Modification du fichier "*interfaces*"
- Nom de la carte réseau `enp0s3`  
- Etat de la carte réseau `static`  
- Adresse IP du serveur DNS `10.0.0.5`  
- Adresse IP de la passerelle `10.0.0.1`  
- CIDR `/24`

![1_interfaces](https://github.com/user-attachments/assets/394ed49c-1d95-441e-8faa-8aa1acb4d77d)

#### Client sous Debian 12
##### :pencil2: Modification du fichier "*interfaces*"
- Nom de la carte réseau `enpos3`  
- Etat de la carte réseau `static`  
- Adresse IP du client `10.0.0.20`  
- Adresse IP de la passerelle `10.0.0.1`  
- CIDR `/24`

![1 1_interfaces](https://github.com/user-attachments/assets/63eed0df-0131-4896-bdf8-5976c81997fa)

##### :pencil2: Modification du fichier "*resolv.conf*"
- Domaine de recherche `wilders.lan`  
- Adresse IP du DNS `10.0.0.5`

![1 2_resolv conf](https://github.com/user-attachments/assets/44700d32-d211-493e-a337-53966d2cc2d5)

### :three: Installation du package DNS
Sur votre serveur DNS mettre a jour le système et installer le package **Bind9**  
- `sudo apt update && sudo apt upgrade`  
- `sudo apt install bind9 bind9-doc`  

### :four: Editions des fichiers de configurations
:warning: Attention à la syntaxe, les fichiers de configs sont sensibles :warning:  
#### :pencil2: Modification du fichier "*/etc/bind/named.conf.options*"
- Réseau `10.0.0.0/24`
- Autorisation de requête DNS `localhost` ; `internal-network`  
- Autorisation de transfert DNS `localhost`  
- Redirection DNS `8.8.8.8`  
- Autorisation de requête récursive `yes`

![2_named conf options](https://github.com/user-attachments/assets/663b2eab-9110-4627-8593-4f23a5a52e97)

#### :pencil2: Modification du fichier "*/etc/bind/named.conf.local*"
- Zone directe `wilders.lan`  
- Zone inverse `0.0.10.in-addr.arpa`  
- Type `master`  
- Fichier directe `/etc/bind/forward.wilders.lan`  
- Fichier inverse `/etc/bind/reverse.wilders.lan`  
- Autorisation de mise à jour `none`
> A ce stade les fichiers de configurations "*forward.wilders.lan*" et "*reverse.wilders.lan*" n'existent pas encore.  

![3_named conf local](https://github.com/user-attachments/assets/48e11add-6ab9-488e-bd40-e96031fcda87)

#### :pencil2: Création du fichier "*forward.wilders.lan*"
Tout d'abord il faut copier le fichier "*db.local*" vers "*forward.wilders.lan*"  
- `cp /etc/bind/db.local /etc/bind/forward.wilders.lan`  
- Déclaration des informations serveur DNS `primary.wilders.lan` ; `10.0.0.5`  
- Enregistrement "A" de `www` en `10.0.0.20`  
- Enregistrement "CNAME" du sous-domaine `www.wilders.lan`  

![4_forward wilders lan](https://github.com/user-attachments/assets/fd766c58-df93-4926-a2b5-bdf62f632b5c)

#### :pencil2: Création du fichier "*reverse.wilders.lan*"
Tout d'abord il faut copier le fichier "*db.127*" vers "*reverse.wilders.lan*"  
- `cp /etc/bind/db.127 /etc/bind/reverse.wilders.lan`  
- Déclaration des informations serveur DNS `primary.wilders.lan` ; `10.0.0.5`  
- Enregistrement inverse `5` du sous-domaine `primary.wilders.lan`  
- Enregistrement inverse `20` du sous-domaine `www.wilders.lan`

![5_reverse wilders lan](https://github.com/user-attachments/assets/2289a0ba-1bd4-431c-8c86-26267527fa82)

#### :pencil2: Modification du fichier "*/etc/default/named*"
- Options `-4`  

![6_named](https://github.com/user-attachments/assets/948e4e9a-a05b-47a3-8656-f1f2c9578ab3)

### :five: Lancement du service "*named*"
- `sudo systemctl start named`
- `sudo systemctl enable named`
- `sudo systemctl status named`

![10_systemctl_status_named](https://github.com/user-attachments/assets/08de342d-4b84-40b6-9742-77749c8df673)

### :hammer: Débogage
:sos: Contrôler vos logs à tout moment pour poser un diagnostique `journalctl`  
- Ping depuis serveur vers client `ping`
- Vérification de la syntaxe du fichier "*named.conf.local*" avec `named-checkconf`
- Vérification de la syntaxe des fichiers "*forward*" et "*reverse*" avec `named-checkzone`
- Ouverture du port 53 si parefeu actif `sudo ufw allow 53`  

### :negative_squared_cross_mark: Quelques tests depuis la machine client
- `dig primary.wilders.lan`  
![7_dig_primary wilders lan](https://github.com/user-attachments/assets/caf4ba41-6ab4-455a-844a-933139197d4d)

- `dig -x 10.0.0.5`  
![8_dig-x_10 0 0 5](https://github.com/user-attachments/assets/4f660e41-0b64-4f9e-b471-89b78d9f5159)

- `nslookup www.wilders.lan`   
![9_nslookup_www wilders lan](https://github.com/user-attachments/assets/3a9d842c-f46f-4669-9f73-3ec14f535395)


:information_source: Plus d'infos : https://bind9.readthedocs.io/en/v9.18.31/index.html
