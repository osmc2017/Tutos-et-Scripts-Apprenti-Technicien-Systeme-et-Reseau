# Utilisation basique de Wireshark

* ## Installation:

    - Pour l'installer sur Mac et Windows il faut télécharger le logciel [ici](https://www.wireshark.org/#download).
    - Pour l'installer sur linux voici [la doc officelle](https://www.wireshark.org/docs/wsug_html_chunked/ChBuildInstallUnixInstallBins.html). Et pour le lancer sans être en root il faut suivre [ce guide](https://gitlab.com/wireshark/wireshark/blob/master/packaging/debian/README.Debian)


* ## 1ere Utilisation

>Au lancement de Wireshark, tu peux voir une fenêtre qui montre une liste de toutes les interfaces réseau que tu peux surveiller.

>Tu as également un champs de filtre de capture, pour ne capturer que ce que tu souhaites.


- ### Capturer des paquets

>Cliquer sur l'icone en forme d'aileron bleu en haut à gauche pour démarrer la capture. L'icône devient alors grise et la fenêtre principale se remplie de données en temps réel !

>Cliquer sur l'icône en forme de carré rouge pour arrêter la capture.


- ### Analyser la capture

    #### La liste des paquets

    >La vue du haut, la liste des paquets, contient la liste des paquets capturés

    - Elle contient des lignes qui avancent dans le temps, chaque ligne représentant un paquet capturé, ainsi que les colonnes suivantes:

        - No. : Il s'agit de l'ordre de numérotation du paquet qui a été capturé. La parenthèse indique que ce paquet fait partie d'une conversation.
        - Time : Cette colonne t'indique combien de temps après le début de la capture ce paquet a été capturé. Tu peux modifier cette valeur dans le menu Paramètres si tu souhaites afficher quelque chose de différent.
        - Source : Il s'agit de l'adresse du système qui a envoyé le paquet.
        -  Destination : il s'agit de l'adresse de destination de ce paquet.
        - Protocole : il s'agit du type de paquet, par exemple, TCP, DNS, DHCPv6 ou ARP.
        - Length : Cette colonne t'indique la longueur du paquet en octets.
        - Info : cette colonne te donne plus d'informations sur le contenu du paquet et varie selon le type de paquet dont il s'agit.

    #### Détails des paquets

    >La vue du milieu, le détail des paquets, montre toutes les informations du paquet sélectionné.

    - Ce volet affiche les protocoles et les entêtes de protocole du paquet sélectionné dans la fenêtre « Liste de paquets ».
    - Ces protocoles sont affichés du plus bas niveau en haut (protocole physique) en haut de la vue au plus haut niveau (applicatif) en bas de la vue.
    - Les lignes de résumé du protocole (étiquettes de sous-arborescence) et les champs du paquet sont affichés dans une arborescence qui peut être développée et réduite.

    #### Filtres de capture et d'affichage

    ##### Les filtres de capture (comme tcp port 80)

    - Ils ne doivent pas être confondus avec les filtres d'affichage .
    - Ils sont beaucoup plus limités et sont utilisés pour réduire la taille d'une capture de paquets bruts.
    - Les filtres de capture sont définis avant de démarrer une capture de paquet et ne peuvent pas être modifiés pendant la capture.
    - Quelques filtres de captures:
        - host IP-address : ce filtre limite la capture au traffic de et vers l'adresse IP
        - net 192.168.0.0/24 : ce filtre capture tout le traffic sur le sous-réseau
        - dst host IP-address : capture les paquets envoyés vers l'hôte spécifique
        - port 53 : capture le traffic seulement sur le port 53
        - port not 53 and not arp : capture tout le traffic sauf le port 53 (DNS) et le traffic ARP

    ##### Les filtres d'affichage (comme tcp.port == 80)

    - Ils sont utilisés pour masquer certains paquets de la liste des paquets et peuvent être modifié à la volée.
    - Quelques filtres d'affichage:
        - ip.src==IP-address and ip.dst==IP-address : Ce filtre montre les paquets d'un ordinateur (ip.src) à un autre (ip.dst). Tu peux également utiliser ip.addr pour afficher les paquets vers et depuis cette adresse IP
        - tcp.port eq 25 : Ce filtre te montrera tout le trafic sur le port 25 (SMTP)
        - icmp : Ce filtre te montrera uniquement le trafic ICMP dans la capture, il s'agit très probablement de pings.
        - ip.addr != IP_address : Ce filtre te montre tout le trafic sauf le trafic vers ou depuis l'ordinateur spécifié
    
>*Dans la fenêtre principale, on peut trouver le filtre de capture juste au-dessus de la liste des interfaces et dans la boîte de dialogue des interfaces. Le filtre d'affichage peut être changé au-dessus de la liste de paquets*