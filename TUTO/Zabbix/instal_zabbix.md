# Guide Complet d'Installation de NGINX et Zabbix sur Debian 12

## Introduction
Ce guide explique comment installer et configurer le serveur web NGINX ainsi que Zabbix 7.2 sur une machine Debian 12.

---

## Prérequis

### Matériel et logiciel
- **OS** : Debian 12
- **Ressources minimales** :
  - 2 CPU
  - 2 Go de RAM
  - 20 Go de stockage

### Accès
- Accès root sur la machine.
- Connexion Internet active.

---

## Étape 1 : Installer NGINX

1. Installer NGINX :
   ```bash
   apt install -y nginx
   ```
2. Activer NGINX pour qu’il démarre automatiquement au démarrage :
   ```bash
   systemctl enable nginx
   ```
3. Démarrer NGINX si ce n'est pas le cas :
   ```bash
   systemctl start nginx
   ```

4. Vérifier que NGINX est actif :
   ```bash
   systemctl status nginx
   ```
   Le service doit être affiché comme **actif (running)**.

5. Tester l'installation :
   - Ouvrir un navigateur web et accéder à l’adresse IP de votre serveur Debian :
     ```
     http://<IP_de_votre_serveur>
     ```
   - Vous devriez voir la page par défaut de NGINX indiquant que le serveur est opérationnel.

---

## Étape 2 : Installer le serveur Zabbix

1. Ajouter le dépôt officiel Zabbix :
   ```bash
   wget https://repo.zabbix.com/zabbix/7.2/release/debian/pool/main/z/zabbix-release/zabbix-release_latest_7.2+debian12_all.deb
   dpkg -i zabbix-release_latest_7.2+debian12_all.deb
   ```

2. Mettre à jour la liste des paquets et effectuer une mise à niveau si nécessaire :
   ```bash
   apt update && apt upgrade -y
   ```

3. Installer Zabbix Server, le frontend, et l’agent :
   ```bash
   apt install -y zabbix-server-mysql zabbix-frontend-php zabbix-nginx-conf zabbix-sql-scripts zabbix-agent
   ```

---

## Étape 3 : Installer et configurer MariaDB pour Zabbix

1. Installer MariaDB :
   ```bash
   apt install mariadb-server -y
   ```
2 a sup
2. Sécuriser MariaDB :
   ```bash
   mysql_secure_installation
   ```
   Répondre aux questions comme suit :
   - Définir un mot de passe root : Oui.
   - Supprimer les utilisateurs anonymes : Oui.
   - Interdire les connexions root à distance : Oui.
   - Supprimer la base de test : Oui.
   - Recharger les tables de privilèges : Oui.

3. Vérification du SGBD :
   ```bash
   systemctl status mysql
   ```

4. Créer la base de données Zabbix :
   ```bash
   mysql -u root -p
   ```
   Dans le shell MySQL, exécuter les commandes suivantes :
   ```sql
   CREATE DATABASE zabbix CHARACTER SET utf8mb4 COLLATE utf8mb4_bin;
   CREATE USER 'zabbix'@'localhost' IDENTIFIED BY 'MotDePasseSécurisé';
   GRANT ALL PRIVILEGES ON zabbix.* TO 'zabbix'@'localhost';
   FLUSH PRIVILEGES;
   EXIT;
   ```

5. Importer les schémas SQL dans la base de données Zabbix :
   ```bash
   zcat /usr/share/zabbix/sql-scripts/mysql/server.sql.gz | mysql --default-character-set=utf8mb4 -uzabbix -p zabbix
   ```
   Saisir le mot de passe défini pour l’utilisateur `zabbix`.

6. Désactivation de la possibilité de modifier la configuration de la BD par des acteurs malveillants :
   ```bash
   mysql -uroot -p
   ```
   Dans le shell MySQL, exécuter :
   ```sql
   SET GLOBAL log_bin_trust_function_creators = 0;
   QUIT;
   ```

---

## Étape 4 : Édition des fichiers de configuration et démarrage des services

1. **Configurer la base de données dans le fichier du serveur Zabbix** :
   Modifier le fichier `/etc/zabbix/zabbix_server.conf` :
   ```bash
   nano /etc/zabbix/zabbix_server.conf
   ```
   Ajouter ou modifier la ligne suivante :
   ```
   DBPassword=MotDePasseSécurisé
   ```

2. **Configurer PHP pour Zabbix dans NGINX** :
   Modifier le fichier `/etc/zabbix/nginx.conf` :
   ```bash
   nano /etc/zabbix/nginx.conf
   ```
   Ajouter ou modifier les lignes suivantes :
   ```nginx
   listen 8080;
   server_name <IP_de_votre_serveur>;
   ```

3. **Redémarrer et activer les services nécessaires** :
   Redémarrer les services :
   ```bash
   systemctl restart zabbix-server zabbix-agent nginx php8.2-fpm
   ```
   Activer les services pour qu’ils démarrent automatiquement :
   ```bash
   systemctl enable zabbix-server zabbix-agent nginx php8.2-fpm
   ```

---

## Étape 5 : Configuration de Zabbix dans l'interface Web

1. Accéder à l’interface web de Zabbix :
   - Ouvrir un navigateur et accéder à :
     ```
     http://<IP_de_votre_serveur>:8080/zabbix
     ```

2. Suivre les étapes de l’assistant de configuration :
   - **Vérification des prérequis** : S’assurer que toutes les dépendances sont satisfaites.
   - **Paramètres de la base de données** :
     - Nom de la base de données : `zabbix`
     - Utilisateur de la base de données : `zabbix`
     - Mot de passe : Le mot de passe défini précédemment.
     - Hôte : `localhost`
     - Port : `3306`
   - **Paramètres du serveur Zabbix** :
     - Nom du serveur : Choisir un nom descriptif, par exemple `Zabbix Server`.

3. Activer les locales nécessaires (résolution du problème `en_US.UTF-8`) :
   Si l'assistant indique un problème avec les locales, exécuter les commandes suivantes :
   ```bash
   nano /etc/locale.gen
   ```
   Décommenter la ligne suivante :
   ```
   en_US.UTF-8 UTF-8
   ```
   Ensuite, générer les locales et définir `en_US.UTF-8` comme par défaut :
   ```bash
   locale-gen
   update-locale LANG=en_US.UTF-8
   ```
   Redémarrer les services nécessaires :
   ```bash
   systemctl restart nginx php8.2-fpm
   ```

4. Finaliser l’installation :
   - Vérifier le résumé des paramètres.
   - Cliquer sur **Terminer** pour finaliser la configuration.

5. Se connecter à Zabbix :
   - Nom d’utilisateur : `Admin`
   - Mot de passe : `zabbix` (mot de passe par défaut).
   - Une fois connecté, changer immédiatement le mot de passe par défaut pour sécuriser le compte.

---

## Conclusion
NGINX, Zabbix et MariaDB sont maintenant installés et configurés sur votre machine Debian 12. Vous pouvez utiliser l’interface web de Zabbix pour surveiller vos équipements.
