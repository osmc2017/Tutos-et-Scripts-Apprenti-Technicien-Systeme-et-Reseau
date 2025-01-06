# Configuration d'une Adresse IP sur Raspberry Pi OS

Ce tutoriel explique comment configurer une adresse IP (fixe ou DHCP) sur un Raspberry Pi utilisant deux méthodes : via NetworkManager en ligne de commande ou directement en modifiant un fichier de configuration.

## 1. Identifier l'interface réseau

Avant de configurer quoi que ce soit, identifiez l'interface réseau que vous souhaitez modifier.

```bash
ip a
```

Les interfaces courantes sont :

- `eth0` pour Ethernet
- `wlan0` pour le Wi-Fi

---

## 2. Méthode 1 : Configuration via ligne de commande avec NetworkManager

### Installer et activer NetworkManager

Si NetworkManager n'est pas installé, installez-le :

```bash
apt update
apt install network-manager
```

Assurez-vous que le service est actif :

```bash
systemctl enable NetworkManager
systemctl start NetworkManager
```

### Configuration IP Fixe avec NetworkManager

1. Identifiez votre connexion active :

   ```bash
   nmcli con show
   ```

   Recherchez le nom de la connexion active (par exemple, `Wired connection 1` pour Ethernet).

2. Configurez une adresse IP statique :

   ```bash
   nmcli con modify "NomDeLaConnexion" ipv4.addresses 192.168.1.100/24
   nmcli con modify "NomDeLaConnexion" ipv4.gateway 192.168.1.1
   nmcli con modify "NomDeLaConnexion" ipv4.dns "8.8.8.8,8.8.4.4"
   nmcli con modify "NomDeLaConnexion" ipv4.method manual
   ```

   Remplacez `NomDeLaConnexion` par le nom exact de la connexion identifié à l'étape précédente.

3. Appliquez la configuration :

   ```bash
   nmcli con up "NomDeLaConnexion"
   ```

4. Vérifiez la configuration :

   ```bash
   ip a
   ```

   Vous devriez voir l'adresse IP statique attribuée à l'interface.

### Configuration DHCP avec NetworkManager

1. Identifiez votre connexion active :

   ```bash
   nmcli con show
   ```

   Recherchez le nom de la connexion active.

2. Configurez l'interface pour utiliser DHCP :

   ```bash
   nmcli con modify "NomDeLaConnexion" ipv4.method auto
   ```

3. Appliquez la configuration :

   ```bash
   nmcli con up "NomDeLaConnexion"
   ```

4. Vérifiez que l'interface a obtenu une adresse IP automatiquement :

   ```bash
   ip a
   ```

---

## 3. Méthode 2 : Configuration via un fichier de configuration NetworkManager

### Localiser le fichier de configuration

1. Listez les connexions disponibles :

   ```bash
   nmcli con show
   ```

   Vous verrez une liste des connexions, par exemple :

   ```
   NAME                UUID                                  TYPE      DEVICE
   Wired connection 1  12345678-abcd-1234-abcd-123456789abc  ethernet  eth0
   ```

2. Localisez le fichier correspondant dans `/etc/NetworkManager/system-connections/`. Par exemple :

   ```bash
   ls /etc/NetworkManager/system-connections/
   ```

   Vous devriez voir un fichier comme `Wired connection 1.nmconnection`.

### Configuration IP Fixe dans le fichier

1. Ouvrez le fichier avec un éditeur de texte :

   ```bash
   nano /etc/NetworkManager/system-connections/Wired connection 1.nmconnection
   ```

2. Modifiez ou ajoutez la section suivante pour une configuration IP fixe :

   ```ini
   [ipv4]
   method=manual
   addresses=192.168.1.100/24
   gateway=192.168.1.1
   dns=8.8.8.8;8.8.4.4;

   [ipv6]
   method=ignore
   ```

   - **`addresses`** : Spécifie l'adresse IP fixe et le masque (CIDR, `/24` ici).
   - **`gateway`** : Adresse IP de la passerelle (routeur).
   - **`dns`** : Liste des serveurs DNS séparés par des points-virgules.
   - **`method=manual`** : Indique que la configuration est manuelle.

3. Sauvegardez et fermez le fichier : `CTRL+O`, puis `CTRL+X`.

4. Redémarrez NetworkManager pour appliquer les modifications :

   ```bash
   systemctl restart NetworkManager
   ```

5. Vérifiez la configuration :

   ```bash
   ip a
   ```

   Vous devriez voir l'adresse IP fixe attribuée.

### Configuration DHCP dans le fichier

1. Ouvrez le fichier de configuration correspondant :

   ```bash
   nano /etc/NetworkManager/system-connections/Wired connection 1.nmconnection
   ```

2. Modifiez la section `[ipv4]` pour activer DHCP :

   ```ini
   [ipv4]
   method=auto
   ```

3. Supprimez toute ligne définissant une adresse IP, une passerelle ou des serveurs DNS.

4. Sauvegardez et fermez le fichier : `CTRL+O`, puis `CTRL+X`.

5. Redémarrez NetworkManager :

   ```bash
   systemctl restart NetworkManager
   ```

6. Vérifiez que l'interface a obtenu une adresse IP automatiquement :

   ```bash
   ip a
   ```

---

## 4. Vérification et dépannage

1. Vérifiez l'adresse IP de l'interface :

   ```bash
   ip a
   ```

2. Si l'adresse ne correspond pas aux attentes, redémarrez votre Raspberry Pi :

   ```bash
   reboot
   ```

3. Si nécessaire, réinitialisez la configuration de la connexion avec NetworkManager :

   ```bash
   nmcli con delete "NomDeLaConnexion"
   ```

   Puis reconnectez-vous et configurez à nouveau la connexion.

---

En cas de problème, faites-le moi savoir pour un dépannage supplémentaire. 😊

[voir le ](README.md)
