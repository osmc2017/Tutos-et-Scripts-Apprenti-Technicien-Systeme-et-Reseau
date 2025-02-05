## Filtres utiles pour Wireshark  

Wireshark permet de capturer et d'analyser le trafic réseau. Voici une liste de filtres utiles pour affiner votre analyse.

### 🌐 Filtres IP  
- **ip.addr == 10.0.0.1** : Afficher tout le trafic avec 10.0.0.1 comme source ou destination.  
- **ip.addr == 10.0.0.0/24** : Afficher tout le trafic vers et depuis le sous-réseau 10.0.0.0/24.  
- **ip.src == 10.0.0.1 && ip.dst == 10.0.0.2** : Afficher tout le trafic de 10.0.0.1 vers 10.0.0.2.  
- **!(ip.addr == 10.0.0.1)** : Exclure tout le trafic vers ou depuis 10.0.0.1.  

### 🛡️ Filtres ICMP et TCP/UDP  
- **icmp.type == 3** : Afficher les paquets ICMP "destination unreachable".  
- **tcp or udp** : Afficher le trafic TCP ou UDP.  
- **tcp.port == 80** : Afficher le trafic TCP sur le port 80 (HTTP).  
- **tcp.srcport < 1000** : Afficher le trafic TCP avec un port source inférieur à 1000.  
- **tcp or dns** : Afficher tout le trafic HTTP ou DNS.  
- **tcp.flags.syn == 1** : Afficher les paquets TCP avec le drapeau SYN activé.  
- **tcp.flags == 0x012** : Afficher les paquets TCP avec SYN et ACK activés.  
- **tcp.analysis.retransmission** : Afficher tous les paquets TCP retransmis.  

### 🛠️ Filtres HTTP et TLS  
- **http.request.method == "GET"** : Afficher les paquets HTTP GET.  
- **http.response.code == 404** : Afficher les paquets avec une réponse HTTP 404.  
- **http.host == "www.abc.com"** : Afficher le trafic HTTP correspondant à un hôte spécifique.  
- **tls.handshake** : Afficher uniquement les paquets de handshake TLS.  
- **tls.handshake.type == 1** : Afficher les paquets Client Hello TLS.  

### 🛡️ Filtres DHCP et DNS  
- **dhcp and ip.addr == 10.0.0.0/24** : Afficher le trafic DHCP pour le sous-réseau 10.0.0.0/24.  
- **dhcp.hw.mac_addr == 00:11:22:33:44:55** : Afficher les paquets DHCP pour une adresse MAC spécifique.  
- **dns.resp.name == cnn.com** : Afficher les réponses DNS contenant "cnn.com".  

### 🗃️ Filtres avancés  
- **frame contains keyword** : Afficher les paquets contenant le mot "keyword".  
- **frame.len > 1000** : Afficher les paquets avec une taille totale supérieure à 1000 octets.  
- **eth.addr == 00:11:22:33:44:55** : Afficher tout le trafic vers/depuis une adresse MAC spécifique.  
- **eth[0x47:2] == 01:80** : Filtrer les trames Ethernet ayant une valeur spécifique à l'offset 0x47.  
- **!(arp or icmp or stp)** : Exclure le trafic de fond ARP, ICMP et STP.  
- **vlan.id == 100** : Afficher les paquets avec VLAN ID 100.  

Ces filtres permettent d'affiner l'analyse et d'identifier plus facilement les événements réseau pertinents. 🚀

