# Installation et Configuration de GLPI sur Ubuntu Server

## 👉 Préparation de la VM
1. **Téléchargez une image ISO d’Ubuntu Server 22** : Vous pouvez la trouver [ici](https://ubuntu.com/download/server).
2. **Créez une VM avec l’hyperviseur de votre choix** (comme VirtualBox) et configurez-la :
   - **RAM** : 2 Go minimum.
   - **Disque dur** : 20 Go minimum.
   - **Réseau** : Mode "bridge" pour permettre à la VM de communiquer avec le réseau local et la box internet.
3. **Ajoutez l’ISO d’Ubuntu Server** comme disque de démarrage.

---

## 👉 Installation d’Ubuntu Server
1. Démarrez la VM et suivez les étapes suivantes :
   - Au menu **GNU GRUB**, choisissez **Try or Install**.
   - Sélectionnez la langue : **Français**.
   - À l’écran **Mise à jour du programme d’installation**, sélectionnez **Continuer sans mettre à jour**.
   - Configurez le clavier : choisissez **French** pour les deux options.
   - Sélectionnez le type d’installation : **Ubuntu Server**.
   - Pour la connexion réseau, attendez l’auto-configuration et cliquez sur **Terminer**.
   - Configuration du proxy : laissez vide et cliquez sur **Terminer**.
   - Miroir d’archives : laissez par défaut et cliquez sur **Terminer**.
   - Configuration du stockage : choisissez **Utiliser un disque entier**, puis **Terminé** deux fois.
   - Confirmez le message d’action avec **Continuer**.
2. Configurez le profil utilisateur :
   - **Nom complet** : entrez un nom.
   - **Nom de la machine** : entrez **glpi-server**.
   - **Nom d’utilisateur** : entrez **wilder**.
   - **Mot de passe** : entrez-le deux fois (clavier en QWERTY à cette étape !).
3. Désactivez la configuration SSH et validez avec **Terminé**.
4. Dans l’écran des options logicielles, ne cochez rien et cliquez sur **Terminé**.
5. Attendez que l’installation se termine, redémarrez, retirez l’ISO et appuyez sur Entrée.
6. Connectez-vous avec l’utilisateur **wilder** et le mot de passe choisi (clavier en AZERTY cette fois-ci).
7. Vérifiez la configuration réseau avec la commande :

   ```bash
   ip a
   ```
   Si tout est correct, prenez un snapshot de votre VM.

---

## 👉 Configuration et Installation de GLPI

### Mise à jour du système
Effectuez une mise à jour de vos paquets :
```bash
sudo apt-get update && sudo apt-get upgrade
```

### Installation des prérequis

#### Apache
Installez Apache :
```bash
sudo apt-get install apache2 -y
```
Activez Apache au démarrage :
```bash
sudo systemctl enable apache2
```

#### MariaDB (Base de données)
Installez MariaDB :
```bash
sudo apt-get install mariadb-server -y
```
Configurez MariaDB en sécurisant l’installation :
```bash
sudo mysql_secure_installation
```
Répondez Y à toutes les questions et définissez un mot de passe root.

Configurez la base de données GLPI :
```bash
mysql -u root -p
```
Entrez le mot de passe root, puis exécutez :
```sql
create database glpidb character set utf8 collate utf8_bin;
grant all privileges on glpidb.* to glpi@localhost identified by 'motDePasse';
flush privileges;
quit;
```

#### PHP et modules nécessaires
Installez PHP et ses modules :
```bash
sudo apt-get install php libapache2-mod-php -y
sudo apt-get install php-{ldap,imap,apcu,xmlrpc,curl,common,gd,json,mbstring,mysql,xml,intl,zip,bz2} -y
```
Configurez PHP dans le fichier php.ini :
```bash
sudo nano /etc/php/8.1/apache2/php.ini
```
Modifiez les paramètres suivants :
```ini
memory_limit = 64M
file_uploads = on
max_execution_time = 600
session.auto_start = 0
session.use_trans_sid = 0
```
Enregistrez et fermez.

### Récupération et configuration de GLPI
Téléchargez GLPI :
```bash
wget https://github.com/glpi-project/glpi/releases/download/10.0.2/glpi-10.0.2.tgz
```
Créez un répertoire GLPI et extrayez les fichiers :
```bash
sudo mkdir /var/www/glpi
sudo tar -xzvf glpi-10.0.2.tgz
sudo cp -R glpi/* /var/www/glpi/
```
Ajustez les permissions :
```bash
sudo chown -R www-data:www-data /var/www/glpi
sudo chmod -R 775 /var/www/glpi
```

### Configuration Apache
Ajoutez une configuration spécifique pour GLPI :

Modifiez le fichier 000-default.conf :
```bash
sudo nano /etc/apache2/sites-available/000-default.conf
```
Ajoutez cette configuration avant `</VirtualHost>` :
```apache
Alias /glpi /var/www/glpi

<Directory /var/www/glpi>
    Options Indexes FollowSymLinks
    AllowOverride All
    Require all granted
</Directory>
```
Redémarrez Apache :
```bash
sudo systemctl restart apache2
```

---

## 👉 Accéder à GLPI

1. Dans un navigateur web, entrez l’adresse suivante (se mettre sur le même réseau IP en réseau interne par exemple):
```
http://<IP_du_serveur>/glpi
```
Par exemple, `http://192.168.0.10/glpi`.

Suivez les étapes de l'installation via l'interface web.


2. Dans les fenêtres graphiques de configuration :  
- **Langue** : Sélectionnez **Français**.  
- **Licence** : Acceptez la licence GPL en cochant la case **J'ai lu et accepté...**.  
- Cliquez sur **Installer**.  

3. Si tout est en ordre, dans la fenêtre suivante, cliquez sur **Continuer**.

4. **Configuration de la base de données MariaDB** :  
- **Serveur SQL** : `127.0.0.1`  
- **Utilisateur** : `glpi`  
- **Mot de passe** : Mot de passe défini lors de la configuration de la base de données pour l'utilisateur `glpi`.  


Votre installation de GLPI est maintenant opérationnelle ! 🎉
