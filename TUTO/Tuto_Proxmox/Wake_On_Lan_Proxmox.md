
# Étapes de configuration

## 1. Activer Wake-on-LAN sur Proxmox

Connectez-vous à votre serveur Proxmox via SSH ou la console.  
Installez `ethtool` si ce n’est pas déjà fait :

```bash
apt update
apt install ethtool
```

Vérifiez que Wake-on-LAN est activé sur l'interface réseau `enp6s0` :

```bash
ethtool enp6s0
```

Recherchez la ligne `Supports Wake-on: g` qui signifie que l'interface prend en charge WoL.  
Si WoL n'est pas activé, activez-le avec la commande suivante :

```bash
ethtool -s enp6s0 wol g
```

Pour que WoL soit activé au démarrage, créez un script qui sera exécuté lors de l'activation de l'interface réseau :

```bash
nano /etc/network/if-up.d/wol
```

Ajoutez le contenu suivant :

```bash
#!/bin/sh
ethtool -s enp6s0 wol g
```

Enregistrez et quittez (Ctrl+O, puis Ctrl+X).  
Rendez le script exécutable :

```bash
chmod +x /etc/network/if-up.d/wol
```

## 2. Configurer le DDNS avec No-IP

Créez un compte sur No-IP, si ce n'est pas déjà fait, et configurez un domaine DDNS, par exemple `lbartaire.ddns.net`.  
Sur votre routeur Asus, configurez le client DDNS :

1. Accédez à l'interface d'administration du routeur via [http://192.168.1.1](http://192.168.1.1).
2. Allez dans **WAN > DDNS**.
3. Choisissez **No-IP** comme fournisseur et entrez vos informations de connexion No-IP.
4. Définissez votre domaine (par exemple, `lbartaire.ddns.net`).
5. Assurez-vous que le service DDNS est activé et fonctionne correctement.

## 3. Configurer la redirection de port sur le routeur Asus

Pour envoyer le paquet WoL depuis l'extérieur de votre réseau, vous devez rediriger le port UDP 9 (port par défaut pour WoL) vers l'adresse IP locale de votre serveur Proxmox.

1. Accédez à l'interface de votre routeur Asus via [http://192.168.1.1](http://192.168.1.1).
2. Allez dans **WAN > Port Forwarding** ou **NAT**.
3. Ajoutez une nouvelle règle de redirection de port :
   - Nom du service : `WoL` (ou tout autre nom explicite).
   - Port externe : `9`.
   - Protocole : `UDP`.
   - IP locale : L'adresse IP locale de votre serveur Proxmox (par exemple, `192.168.1.100`).
   - Port interne : `9` (le même port).
4. Enregistrez les modifications.

## 4. Configurer la Livebox pour rediriger le port UDP 9

Si votre routeur Asus est derrière une Livebox, vous devrez peut-être configurer la Livebox pour rediriger le port vers le routeur Asus. Cela peut être nécessaire si la Livebox est le routeur principal qui gère l'accès Internet.

1. Connectez-vous à l'interface de la Livebox (généralement [http://192.168.1.1](http://192.168.1.1)).
2. Allez dans la section **NAT/PAT** ou **Redirection de port**.
3. Configurez une redirection de port UDP 9 vers l'adresse IP publique du routeur Asus (ou l'adresse IP privée du routeur Asus si la Livebox est en mode bridge).
4. Enregistrez les modifications.

## 5. Tester la redirection de port et WoL

- Vous pouvez tester si le port UDP 9 est ouvert en utilisant un outil comme [CanYouSeeMe](https://canyouseeme.org) pour vérifier si le port 9 est ouvert sur votre adresse IP publique.
- Vous pouvez tester l'activation de WoL via un service en ligne, comme [Wake-on-LAN Online](https://wakeonlan.me) ou [Depicus WoL](https://depicus.com), en entrant votre adresse MAC, votre nom de domaine DDNS (par exemple `lbartaire.ddns.net`), et le port 9.

## 6. Envoyer un paquet WoL depuis n'importe où

Une fois que tout est configuré, vous pouvez envoyer un paquet WoL depuis n'importe où en utilisant un outil comme :

- **Services en ligne** (comme [wakeonlan.me](https://wakeonlan.me) ou [Depicus](https://depicus.com)).
- **Outils de ligne de commande** (comme `wakeonlan` depuis une autre machine Linux) :

```bash
wakeonlan -i lbartaire.ddns.net -p 9 <adresse MAC de enp6s0>
```

## Résumé des étapes clés

1. Activer WoL sur l'interface réseau de Proxmox (`enp6s0`).
2. Configurer le DDNS avec No-IP pour avoir un domaine accessible à distance.
3. Rediriger le port UDP 9 sur le routeur Asus vers le serveur Proxmox.
4. Rediriger le port UDP 9 si nécessaire sur la Livebox vers le routeur Asus.
5. Envoyer le paquet WoL à partir d'un service en ligne ou d'un outil comme `wakeonlan`.

Avec cette configuration, vous pourrez réveiller votre serveur Proxmox à distance de n'importe où, simplement en envoyant un paquet WoL via votre domaine DDNS, sans avoir besoin de VPN.
