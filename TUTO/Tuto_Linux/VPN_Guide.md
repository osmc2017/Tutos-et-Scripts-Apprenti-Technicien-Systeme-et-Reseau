# 🔧 Prérequis

Tu as besoin de 2 PC ou VM. Pour chacun :

- Une distribution Linux, comme Ubuntu
- 1 carte réseau en mode Réseau interne, avec l'adresse `172.16.10.1` pour PC1 et `172.16.10.2` pour PC2
- 1 carte réseau permettant d'aller sur internet, en mode NAT par exemple
- Ne pas oublier de donner les droits sudo à chacun de ces utilisateurs avec `usermod -aG sudo <user>`
- PC1 est le client et PC2 est le serveur, la connexion sécurisée se fera donc de PC1 vers PC2.


# 🔬 Configuration initiale des PC

Sur PC1 et PC2, effectuer les actions suivantes :

## Mise à jour des paquets :
```bash
sudo apt update && sudo apt upgrade -y
```

## Installation d'OpenVPN :
```bash
sudo apt install openvpn
```

## Installation de SSH :
```bash
sudo apt install openssh-server
```

### Configuration du fichier SSH sur PC2

1. Modifier le fichier de configuration SSH :
   ```bash
   sudo nano /etc/ssh/sshd_config
   ```
2. Désactiver l'accès root :
   ```plaintext
   PermitRootLogin no
   ```
3. Limiter l'accès à l'utilisateur `USER2` :
   ```plaintext
   AllowUsers <USER2>
   ```
4. Redémarrer le service SSH :
   ```bash
   sudo systemctl restart ssh
   ```

## Installation de Wireshark :
```bash
sudo apt install wireshark
```
Lors de l'installation, répondre **Oui** à la question : _Should non-superusers be able to capture packets ?_. Cela permet aux utilisateurs qui ne sont pas super-utilisateurs de capturer des paquets.

Ensuite, ajouter l'utilisateur courant au groupe Wireshark :
```bash
usermod -a -G wireshark <Utilisateur>
```

# 🏗️ Création d'une clé sécurisée

1. Désactiver ou supprimer les cartes NAT si les machines sont des VM et ne garder que les cartes réseaux du réseau interne.
2. Sur PC1, se placer dans `/etc/openvpn/client`.
3. Générer la clé avec la commande :
   ```bash
   sudo openvpn --genkey secret <NomDeLaCléStatique>.key
   ```

### Explications :
- `--genkey` : Argument de la ligne de commande d'OpenVPN qui indique une génération de clé
- `secret` : Indique un chiffrement de clé symétrique
- `<NomDeLaCléStatique>.key` : Nom de la clé (ex. `static-OpenVPN.key`)

Tu peux vérifier le contenu de la clé avec la commande :
```bash
sudo cat static-OpenVPN.key
```

# 🔬 Envoi de la clé sur le serveur

Utilise la commande `scp` pour envoyer la clé de PC1 vers PC2 de manière sécurisée :
```bash
sudo scp static-OpenVPN.key <USER2>@172.16.10.2:~
```

Ensuite :
1. Connecte-toi en SSH sur PC2 :
   ```bash
   ssh <USER2>@172.16.10.2
   ```
2. Copie la clé dans le répertoire `/etc/openvpn/server/` avec sudo :
   ```bash
   sudo mv ~/static-OpenVPN.key /etc/openvpn/server/
   ```

# 💬 Test d'une communication non-sécurisée

1. Fais un ping de PC1 vers PC2 :
   ```bash
   ping 172.16.10.2
   ```
2. Lance Wireshark sur PC1 et vérifie :
   - Ton ping est fonctionnel (echo request et echo reply).
   - Le protocole est bien ICMP.
   - La partie Data du protocole ICMP est visible en clair.

# 🔬 Mise en place du VPN

## Sur PC1 :
1. Place-toi dans le dossier où se trouve la clé.
2. Exécute la commande suivante :
   ```bash
   sudo openvpn --dev tun --remote 172.16.10.2 --ifconfig 10.10.5.1 10.10.5.2 --cipher AES-256-CBC --secret static-OpenVPN.key
   ```

### Explications :
- `--dev tun` : Utilise un périphérique réseau virtuel de type TUN.
- `--remote 172.16.10.2` : Adresse IP du serveur VPN (ici PC2).
- `--ifconfig 10.10.5.1 10.10.5.2` : Adresses IP virtuelles dans le tunnel VPN (client et serveur).
- `--cipher AES-256-CBC` : Définit l'algorithme de chiffrement.
- `--secret static-OpenVPN.key` : Chemin du fichier contenant la clé secrète statique.

## Sur PC2 :
1. Place-toi dans le dossier où se trouve la clé.
2. Exécute la commande suivante :
   ```bash
   sudo openvpn --dev tun --ifconfig 10.10.5.2 10.10.5.1 --cipher AES-256-CBC --secret static-OpenVPN.key
   ```

Une communication sécurisée est établie lorsque, sur les deux machines, le message suivant apparaît :
```
Initialization Sequence Completed
```

# 🔑 Test d'une communication sécurisée

1. Fais un ping de PC1 vers PC2 (avec les adresses IP virtuelles) :
   ```bash
   ping 10.10.5.2
   ```
2. Lance Wireshark et vérifie :
   - Ton ping est fonctionnel.
   - Le protocole est bien OpenVPN.
   - La partie Data est chiffrée.

# ☝️ Résumé

Pourquoi Wireshark ne montre pas les adresses IP virtuelles ?

- **10.10.5.1 (PC1)** et **10.10.5.2 (PC2)** sont des adresses IP virtuelles utilisées à l'intérieur du tunnel VPN.
- **172.16.10.1 (PC1)** et **172.16.10.2 (PC2)** sont les adresses IP réelles dans le réseau local.

Lors du ping de PC1 vers l'adresse IP virtuelle de PC2 (`ping 10.10.5.2`), cette adresse n'est utilisée qu'à l'intérieur du tunnel VPN. Les paquets ICMP sont encapsulés et chiffrés avant d'être transmis via le réseau local. Wireshark affiche uniquement les adresses IP réelles utilisées pour transporter le trafic VPN encapsulé.
