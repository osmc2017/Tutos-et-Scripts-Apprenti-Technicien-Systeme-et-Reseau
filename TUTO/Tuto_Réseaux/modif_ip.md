# Modifier une adresse IP en ligne de commande

## 1. Ubuntu (Netplan)

### Voir la configuration existante :
```bash
cat /etc/netplan/*.yaml
```

### Modifier l'adresse IP :

#### Éditer la configuration Netplan :
```bash
sudo nano /etc/netplan/01-netcfg.yaml     # a adapter
```

#### Exemple de configuration :           
```yaml
network:                      # A adapter
  version: 2
  renderer: networkd
  dhcp4: true/false
  ethernets:
    eth0:
      addresses:
        - 192.168.1.100/24
      gateway4: 192.168.1.1
      nameservers:
        addresses:
          - 8.8.8.8
          - 8.8.4.4
```

#### Appliquer la configuration :
```bash
sudo netplan apply
```

## 2. Debian (interfaces)

### Voir la configuration existante :
```bash
cat /etc/network/interfaces
```

### Modifier l'adresse IP :

#### Éditer le fichier de configuration réseau :
```bash
sudo nano /etc/network/interfaces
```

#### Ajouter une configuration IP statique :
```arduino
auto eth0
iface eth0 inet static
    address 192.168.1.100
    netmask 255.255.255.0
    gateway 192.168.1.1
    dns-nameservers 8.8.8.8 8.8.4.4
```

#### Redémarrer le service réseau :
```bash
sudo systemctl restart networking
```

## 3. Windows (PowerShell)

### Voir la configuration existante :
```powershell
Get-NetIPAddress
```

### Modifier l'adresse IP :

#### Configurer une adresse IP statique :
```powershell
New-NetIPAddress -InterfaceAlias "Ethernet" -IPAddress 192.168.1.100 -PrefixLength 24 -DefaultGateway 192.168.1.1
```

#### Configurer les serveurs DNS :
```powershell
Set-DnsClientServerAddress -InterfaceAlias "Ethernet" -ServerAddresses 8.8.8.8,8.8.4.4
```