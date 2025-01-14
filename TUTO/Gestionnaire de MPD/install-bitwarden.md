# Guide d'installation de Bitwarden sans Docker (Local et Non Accessible depuis Internet)

Ce guide explique comment installer Bitwarden sans Docker.

---

## Prérequis
1. **Système d'exploitation** : Debian 12 (ou autre distribution basée sur Debian).
2. **Accès root** au serveur.
3. **Serveur DNS local** : Configurez un domaine pour Bitwarden (par exemple, `bitwarden.bartinfo.com`).

---

## Étape 1 : Configuration DNS locale
1. Accédez à votre serveur DNS local (par exemple, Active Directory ou un autre gestionnaire DNS).
2. Ajoutez une **entrée DNS A** pour le domaine local de Bitwarden :
   - **Nom** : `bitwarden` (ou un autre nom, selon vos conventions).
   - **IP** : Adresse IP locale du serveur Debian où Bitwarden sera installé.

3. Si votre DNS prend en charge les enregistrements PTR (résolution inverse) :
   - Configurez une entrée PTR pour associer l'adresse IP locale au domaine `bitwarden.bartinfo.com`.

4. Vérifiez la résolution DNS depuis le serveur Debian :
   ```bash
   nslookup bitwarden.bartinfo.com
   ```
   - La sortie doit afficher l'adresse IP configurée pour le domaine `bitwarden.bartinfo.com`.

5. Si vous utilisez un routeur comme pfSense pour la gestion DNS locale :
   - Allez dans **Services > DNS Resolver > Overrides**.
   - Ajoutez une nouvelle entrée DNS Override :
     - **Host** : `bitwarden`.
     - **Domain** : `bartinfo.com`.
     - **IP Address** : L'adresse IP locale du serveur Bitwarden.
   - Sauvegardez et appliquez les changements.

---

## Étape 1 bis : Configuration DNS sur le serveur Debian

1. Éditez le fichier `/etc/resolv.conf` pour configurer le serveur DNS local :
   ```bash
   nano /etc/resolv.conf
   ```

2. Ajoutez ou modifiez les lignes suivantes :
   ```
   nameserver <IP-DU-SERVEUR-DNS-LOCAL>
   search bartinfo.com
   ```
   - **<IP-DU-SERVEUR-DNS-LOCAL>** : Adresse IP du serveur DNS (par exemple, le serveur Active Directory ou pfSense).
   - `search bartinfo.com` permet de compléter automatiquement les noms courts (par exemple, taper `bitwarden` au lieu de `bitwarden.bartinfo.com`).

3. Sauvegardez et fermez le fichier.

4. Testez la résolution DNS avec le domaine local :
   ```bash
   ping bitwarden.bartinfo.com
   ```

5. Pour rendre les modifications permanentes si le fichier `/etc/resolv.conf` est géré dynamiquement (par exemple par **systemd-resolved**) :
   - Modifiez `/etc/systemd/resolved.conf` :
     ```bash
     nano /etc/systemd/resolved.conf
     ```
   - Ajoutez ou modifiez les lignes suivantes :
     ```ini
     [Resolve]
     DNS=<IP-DU-SERVEUR-DNS-LOCAL>
     Domains=bartinfo.com
     ```
   - Redémarrez le service :
     ```bash
     systemctl restart systemd-resolved
     ```

---

## Étape 2 : Mise à jour du système
1. Mettez à jour les paquets :
   ```bash
   apt update && apt upgrade -y
   ```
2. Installez les outils nécessaires :
   ```bash
   apt install -y wget curl gnupg2 software-properties-common build-essential
   ```

---

## Étape 3 : Configurer Nginx avec HTTPS

### 1. Installer Nginx
```bash
apt install -y nginx
```

### 2. Générer un certificat auto-signé
```bash
openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
    -keyout /etc/ssl/private/bitwarden-selfsigned.key \
    -out /etc/ssl/certs/bitwarden-selfsigned.crt \
    -subj "/CN=bitwarden.bartinfo.com"
```

### 3. Configurer Nginx pour Bitwarden
1. Créez un fichier de configuration pour Bitwarden :
   ```bash
   nano /etc/nginx/sites-available/bitwarden
   ```

2. Ajoutez la configuration suivante :
   ```nginx
   server {
       listen 443 ssl;
       server_name bitwarden.bartinfo.com;

       ssl_certificate /etc/ssl/certs/bitwarden-selfsigned.crt;
       ssl_certificate_key /etc/ssl/private/bitwarden-selfsigned.key;

       location / {
           proxy_pass http://127.0.0.1:8000;
           proxy_set_header Host $host;
           proxy_set_header X-Real-IP $remote_addr;
           proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
           proxy_set_header X-Forwarded-Proto $scheme;
       }
   }

   server {
       listen 80;
       server_name bitwarden.bartinfo.com;

       return 301 https://$host$request_uri;
   }
   ```

3. Activez la configuration et redémarrez Nginx :
   ```bash
   ln -s /etc/nginx/sites-available/bitwarden /etc/nginx/sites-enabled/
   nginx -t
   systemctl reload nginx
   ```

---

## Étape 4 : Installation de Bitwarden_rs (Vaultwarden)
1. **Créer un utilisateur dédié** pour exécuter le service Bitwarden :
   ```bash
   adduser --system --home /opt/bitwarden --shell /bin/false bitwarden
   ```

2. **Téléchargez le binaire Vaultwarden** :
   ```bash
   wget https://github.com/dani-garcia/vaultwarden/releases/latest/download/vaultwarden-x86_64-unknown-linux-musl.tar.gz
   ```

3. **Extrayez les fichiers** :
   ```bash
   tar -xvf vaultwarden-x86_64-unknown-linux-musl.tar.gz -C /opt/bitwarden
   ```

4. **Attribuez les permissions** :
   ```bash
   chown -R bitwarden:bitwarden /opt/bitwarden
   ```

---

## Étape 5 : Configurer le service systemd
1. Créez un fichier de service pour Vaultwarden :
   ```bash
   nano /etc/systemd/system/bitwarden.service
   ```

2. Collez la configuration suivante :
   ```ini
   [Unit]
   Description=Bitwarden Server (Vaultwarden)
   After=network.target

   [Service]
   User=bitwarden
   Group=bitwarden
   ExecStart=/opt/bitwarden/vaultwarden
   WorkingDirectory=/opt/bitwarden
   Restart=always
   Environment="WEB_VAULT_ENABLED=true"

   [Install]
   WantedBy=multi-user.target
   ```

3. Rechargez systemd et démarrez le service :
   ```bash
   systemctl daemon-reload
   systemctl start bitwarden
   systemctl enable bitwarden
   ```

4. Vérifiez que le service est en cours d'exécution :
   ```bash
   systemctl status bitwarden
   ```

---

## Étape 6 : Tester l'installation
1. Accédez à votre serveur Bitwarden depuis un navigateur à l'adresse :
   ```
   https://bitwarden.bartinfo.com
   ```
2. Acceptez le certificat auto-signé pour accéder à l'interface.

---



