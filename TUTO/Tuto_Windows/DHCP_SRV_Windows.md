# Configuration d'un serveur DHCP sur Windows Server 2022

## 1. Configuration du service DHCP avec paramétrage de la plage IP

Une fois la machine virtuelle Windows Server démarrée (et à jour), ajoute le rôle de serveur DHCP à ton serveur en suivant les étapes suivantes :

### Étapes pour installer le rôle DHCP :

1. **Attribuer une IP fixe au serveur** (dans notre exemple, `172.20.0.101/24`).
2. **Ouvrir le Gestionnaire de serveur** et cliquer sur **Ajouter des rôles et des fonctionnalités**.
3. Sélectionner **Installation basée sur un rôle ou une fonctionnalité**.
4. Choisir le serveur sur lequel installer le rôle.
5. Sélectionner **Serveur DHCP**, puis cliquer sur **Ajouter des fonctionnalités** dans la fenêtre contextuelle. Cliquer ensuite sur **Suivant**.
6. Passer les options de **Fonctionnalités** et cliquer sur **Suivant**.
7. Dans la section **DHCP**, s'assurer que l'adresse IP fixe est bien configurée, puis cliquer sur **Suivant**.
8. Cliquer sur **Installer** sans avoir besoin de redémarrer.

### Paramétrage du service DHCP :

Une fois le service DHCP installé, il reste à le configurer :

1. Ouvrir le **Gestionnaire DHCP** en cliquant droit sur le serveur dans la section DHCP.
2. Dans la barre de gauche, sélectionner votre serveur, puis cliquer droit sur **IPv4** et choisir **Nouvelle étendue**.
3. Cliquer sur **Suivant**, puis donner un nom à votre étendue (par exemple : `serveur_dhcp`) et cliquer sur **Suivant**.
4. Entrer l'adresse IP de début (`172.20.0.100`) et l'adresse IP de fin (`172.20.0.200`), puis spécifier le **Masque de sous-réseau** en indiquant **24**. Cliquer sur **Suivant**.
5. Cliquer sur **Suivant** (on ne réserve pas d'adresses IP dans cette plage).
6. Cliquer encore sur **Suivant** (on ne modifie pas les paramètres de bail pour l'instant).
7. Choisir **Oui, je veux...** pour activer l'étendue, puis cliquer sur **Suivant** et enfin sur **Terminer**.

### Réservation d'une adresse IP pour une machine spécifique :

1. Dans le **Gestionnaire DHCP**, dérouler l'étendue créée à droite et cliquer droit sur **Réservations**, puis sélectionner **Nouvelle réservation**.
2. Ajouter le **nom du périphérique**, l'**adresse IP réservée** (par exemple : `172.20.0.10`), ainsi que son **adresse MAC**.
3. Choisir **DHCP** dans les types supportés.

---

## 2. Configuration des cartes réseau des VMs

Pour que le système fonctionne entre plusieurs machines virtuelles (VMs), il est nécessaire de configurer un **réseau interne**. Voici les étapes :

1. Aller dans les **paramètres des VMs**.
2. Dans la section **Réseau**, choisir le mode d'accès **Réseau interne**.
3. Sélectionner le même réseau pour les deux VMs (par exemple : `intnet`).

Cela permet à vos VMs de communiquer entre elles via le réseau interne.
