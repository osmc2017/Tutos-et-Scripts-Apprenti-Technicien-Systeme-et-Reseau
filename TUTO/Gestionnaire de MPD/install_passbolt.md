# Guide d'installation de Passbolt en local sur Debian 12

Ce guide détaille toutes les étapes pour installer et configurer Passbolt sur un serveur Debian 12 en local.

---

## Prérequis

1. Un serveur Debian 12 sur Proxmox.
2. Un serveur DNS Active Directory avec une entrée DNS configurée pour le domaine.
3. Accès root au serveur Debian 12.

---

## Étape 1 : Configuration DNS dans l'Active Directory

1. Ouvrez la console **Gestion DNS** sur le serveur AD.
2. Ajoutez un **nouvel enregistrement A** dans la zone DNS de votre domaine :
   - **Nom de l'hôte** : `passbolt`.
   - **Adresse IP** : L'adresse IP de votre serveur Debian.
3. (Optionnel) Ajoutez un enregistrement PTR pour la résolution inverse.
4. Vérifiez la résolution DNS depuis le réseau :
   ```bash
   nslookup passbolt.bartinfo.com
   ```

---

## Étape 2 : Configuration réseau sur le serveur Debian

1. Éditez le fichier `/etc/resolv.conf` :
   ```bash
   nano /etc/resolv.conf
   ```
2. Assurez-vous qu'il contient :
   ```
   domain bartinfo.com
   search bartinfo.com home.arpa
   nameserver <IP-DU-SERVEUR-DNS-AD>
   ```
3. Testez la résolution DNS :
   ```bash
   ping -c 4 passbolt.bartinfo.com
   ```

---

## Étape 3 : Génération d'un certificat auto-signé

1. Créez un certificat auto-signé pour HTTPS :
   ```bash
   openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout /etc/ssl/private/passbolt-selfsigned.key -out /etc/ssl/certs/passbolt-selfsigned.crt -subj "/CN=passbolt.bartinfo.com"
   ```
2. Configurez Nginx pour utiliser le certificat :
   ```bash
   nano /etc/nginx/sites-available/passbolt
   ```
   Ajoutez ou modifiez les lignes suivantes dans le fichier :
   ```nginx
   server {
       listen 443 ssl;
       server_name passbolt.bartinfo.com;

       ssl_certificate /etc/ssl/certs/passbolt-selfsigned.crt;
       ssl_certificate_key /etc/ssl/private/passbolt-selfsigned.key;

       # Autres configurations...
   }
   ```
3. Testez et rechargez Nginx :
   ```bash
   nginx -t
   systemctl reload nginx
   ```

---

## Étape 4 : Mise à jour du système Debian

1. Mettez à jour les paquets :
   ```bash
   apt update && apt upgrade -y
   ```
2. Installez les dépendances nécessaires :
   ```bash
   apt install -y wget gnupg2 ca-certificates lsb-release software-properties-common curl
   ```

---

## Étape 5 : Configuration du dépôt Passbolt

1. Téléchargez le script d'installation des dépendances :
   ```bash
   curl -LO https://download.passbolt.com/ce/installer/passbolt-repo-setup.ce.sh
   ```
2. Téléchargez le fichier SHA512SUM pour vérifier l'intégrité du script :
   ```bash
   curl -LO https://github.com/passbolt/passbolt-dep-scripts/releases/latest/download/passbolt-ce-SHA512SUM.txt
   ```
3. Vérifiez l'intégrité du script et exécutez-le :
   ```bash
   sha512sum -c passbolt-ce-SHA512SUM.txt && sudo bash ./passbolt-repo-setup.ce.sh || echo "Bad checksum. Aborting" && rm -f passbolt-repo-setup.ce.sh
   ```
4. Mettez à jour les paquets :
   ```bash
   apt update
   ```
5. Installez Passbolt :
   ```bash
   apt install -y passbolt-ce-server
   ```

---

## Étape 6 : Configuration de Passbolt

1. Lancez le script de configuration de Passbolt :
   ```bash
   passbolt-ce-server-configure
   ```
2. Lorsque le script demande :
   - **Nom de domaine** : Entrez `passbolt.bartinfo.com`.
   - **Configurer Nginx automatiquement ?** : Répondez **No**.
   - Configurez les autres paramètres (base de données, etc.) selon vos besoins.

---

## Étape 7 : Test et accès

1. Accédez à Passbolt depuis un navigateur à l'adresse :
   ```
   https://passbolt.bartinfo.com
   ```
2. Acceptez le certificat auto-signé si nécessaire.

---

## Étape 8 : Création de l'utilisateur administrateur

1. Une fois Passbolt accessible, suivez les instructions pour créer le premier utilisateur administrateur via l'interface web.

---


