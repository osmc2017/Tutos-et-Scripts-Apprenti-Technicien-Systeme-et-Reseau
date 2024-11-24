# Utilisation basique de Wireshark

## Installation

- Pour l'installer sur Mac et Windows, télécharge le logiciel [ici](https://www.wireshark.org/#download).
- Pour l'installer sur Linux, voici [la documentation officielle](https://www.wireshark.org/docs/wsug_html_chunked/ChBuildInstallUnixInstallBins.html).  
  Et pour le lancer sans être en root, il faut suivre [ce guide](https://gitlab.com/wireshark/wireshark/blob/master/packaging/debian/README.Debian).

## 1ère utilisation

Au lancement de Wireshark, tu peux voir une fenêtre qui montre une liste de toutes les interfaces réseau que tu peux surveiller. Il y a également un champ de filtre de capture, permettant de ne capturer que ce que tu souhaites.

### Capturer des paquets

- Clique sur l'icône en forme d'aileron bleu en haut à gauche pour démarrer la capture. L'icône devient alors grise, et la fenêtre principale se remplit de données en temps réel !
- Clique sur l'icône en forme de carré rouge pour arrêter la capture.

### Analyser la capture

#### La liste des paquets

La vue du haut, la liste des paquets, contient la liste des paquets capturés.

- Elle contient des lignes qui avancent dans le temps, chaque ligne représentant un paquet capturé, avec les colonnes suivantes :
  
    - **No.** : L'ordre de numérotation du paquet capturé. La parenthèse indique que ce paquet fait partie d'une conversation.
    - **Time** : Le temps écoulé depuis le début de la capture pour ce paquet. Tu peux modifier cette valeur dans le menu Paramètres si tu souhaites afficher autre chose.
    - **Source** : L'adresse du système qui a envoyé le paquet.
    - **Destination** : L'adresse de destination du paquet.
    - **Protocole** : Le type de paquet, par exemple, TCP, DNS, DHCPv6 ou ARP.
    - **Length** : La longueur du paquet en octets.
    - **Info** : Fournit plus d'informations sur le contenu du paquet et varie en fonction du type de paquet.

#### Détails des paquets

La vue du milieu, le détail des paquets, montre toutes les informations du paquet sélectionné.

- Ce volet affiche les protocoles et les en-têtes de protocole du paquet sélectionné dans la fenêtre « Liste de paquets ».
- Les protocoles sont affichés du plus bas niveau (protocole physique) en haut de la vue et du plus haut niveau (application) en bas de la vue.
- Les lignes de résumé du protocole (étiquettes de sous-arborescence) et les champs du paquet sont affichés dans une arborescence qui peut être développée ou réduite.

#### Filtres de capture et d'affichage

##### Les filtres de capture (comme `tcp port 80`)

- Ils ne doivent pas être confondus avec les filtres d'affichage.
- Les filtres de capture sont plus limités et sont utilisés pour réduire la taille d'une capture de paquets bruts.
- Ils sont définis avant de démarrer la capture et ne peuvent pas être modifiés pendant la capture.

Quelques filtres de capture :
- `host IP-address` : Ce filtre limite la capture au trafic de et vers l'adresse IP.
- `net 192.168.0.0/24` : Capture tout le trafic sur le sous-réseau.
- `dst host IP-address` : Capture les paquets envoyés vers un hôte spécifique.
- `port 53` : Capture le trafic seulement sur le port 53.
- `port not 53 and not arp` : Capture tout le trafic sauf celui du port 53 (DNS) et le trafic ARP.

##### Les filtres d'affichage (comme `tcp.port == 80`)

- Ils sont utilisés pour masquer certains paquets de la liste des paquets et peuvent être modifiés à la volée.

Quelques filtres d'affichage :
- `ip.src==IP-address and ip.dst==IP-address` : Montre les paquets d'un ordinateur (`ip.src`) à un autre (`ip.dst`). Tu peux également utiliser `ip.addr` pour afficher les paquets vers et depuis cette adresse IP.
- `tcp.port eq 25` : Affiche tout le trafic sur le port 25 (SMTP).
- `icmp` : Affiche uniquement le trafic ICMP, très probablement des pings.
- `ip.addr != IP_address` : Affiche tout le trafic sauf celui vers ou depuis l'ordinateur spécifié.

*Dans la fenêtre principale, tu peux trouver le filtre de capture juste au-dessus de la liste des interfaces et dans la boîte de dialogue des interfaces. Le filtre d'affichage peut être changé au-dessus de la liste des paquets.*

