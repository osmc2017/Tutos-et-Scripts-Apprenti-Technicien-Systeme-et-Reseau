# DNS SUR WINDOWS SERVER

## 1. Installation du Serveur DNS

- Ouvrir le Gestionnaire de Serveur et aller dans Ajouter des rôles et fonctionnalités.
- Sélectionner le rôle Serveur DNS et lancer l’installation.
- Cliquez sur "Installer" pour lancer l'installation.

## 2. Configuration pour Résolution de Noms de Domaine Externes (Internet)

- Par défaut, le serveur DNS ne résout que les noms de domaines locaux. Pour qu’il résolve aussi les noms de domaines externes :
- Ouvrir la console DNS Manager.
- Aller dans l’onglet Redirecteurs0 et cliquer sur Modifier.
- Ajouter les serveurs DNS publics, par exemple ceux de Google : `8.8.8.8 et 8.8.4.4`
- Enregistrer les modifications.

Maintenant, le serveur DNS redirigera les demandes pour des domaines externes (comme "google.com") vers les serveurs DNS configurés en redirecteurs.

## 3. Création d'une Zone de Recherche Directe (Nom de Domaine → Adresse IP)

- Dans la console DNS, clic droit sur "Zones de Recherche Directe" et Nouvelle Zone.
- Choisir "Zone Principale" pour gérer cette zone sur ce serveur.
- Nommer la zone (par ex. : wilders.lan).
- Laisser l’option par défaut pour le fichier de zone.
- Désactiver les mises à jour dynamiques pour plus de sécurité, surtout si Active Directory n’est pas installé.
- Cliquer sur Terminer pour créer la zone.

## 4. Création d'une Zone de Recherche Inverse (Adresse IP → Nom de Domaine)

Dans la console DNS, clic droit sur "Zones de Recherche Inverse" et Nouvelle Zone.
Choisir "Zone Principale" pour cette zone.
Sélectionner l’option IPv4.
Entrer l’identifiant de réseau (par ex. 172.20.0).
Windows créera automatiquement un fichier de zone au format in-addr.arpa.dns.
Désactiver les mises à jour dynamiques pour plus de sécurité.
Cliquer sur Terminer pour créer la zone.

## 5. Configuration de la Zone de Recherche Directe

### 5.1 Création d’Enregistrements DNS

#### 5.1.1. Enregistrement A ou AAAA (associer un sous-domaine à une adresse IP (IPv4 ou IPv6))

- Dans la zone de recherche directe, clic droit > "Nouvel Hôte (A ou AAAA)".
- Spécifier le sous-domaine (nom du serveur) et l’adresse IP (IP de notre DHCP)
- Cocher Créer l’enregistrement de pointeur associé (PTR) pour ajouter un pointeur dans la zone de recherche inverse.
- Cliquer sur "Ajouter l’hôte".

#### 5.1.2. Enregistrement CNAME
- Dans la zone de recherche directe, clic droit > "Nouvel Alias (CNAME)".
- Entrer le nom d’alias (ex. : dns) et parcourir pour sélectionner l’enregistrement cible.
- Cliquer sur OK pour enregistrer.

## 6. Test des Enregistrements DNS Créés
Pour vérifier la configuration DNS, utilisez la commande nslookup :

- nslookup sousdomawilderine.domaine.extension : pour connaître l’adresse IP associée à un domaine.

- Vider le cache DNS avant de tester avec ipconfig /flushdns pour garantir des résultats à jour.

Exemple de commande :
```SERVEUR : C:\Users\Administrator>nslookup client1.wilders.lan
Server: ns1.wilders.lan
Address: 172.16.10.100

Name: client1.wilders.lan
Address: 172.16.10.200

CLIENT : C:\Users\Client-01>nslookup ns1.wilders.lan
Server: ns1.wilders.lan
Address: 172.16.10.100

Name: ns1.wilders.lan
Address: 172.16.10.100 