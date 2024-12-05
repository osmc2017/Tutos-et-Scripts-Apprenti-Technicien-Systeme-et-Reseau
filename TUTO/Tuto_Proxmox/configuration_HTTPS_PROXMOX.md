# Tutoriel : Configurer HTTPS avec un Certificat SSL Let's Encrypt sur Proxmox

Ce tutoriel décrit comment configurer un certificat SSL Let's Encrypt sur un serveur Proxmox et automatiser le renouvellement du certificat à l'aide de Certbot et de cron.

Bien remplacer 'tonnom' par le nom de ddns désiré.
---

## Étape 1 : Préparer le serveur Proxmox

### 1.1 Vérifier l'accès à Internet

Avant de commencer, assurez-vous que votre serveur Proxmox a accès à Internet. Utilisez la commande suivante pour tester la connectivité :

```bash
ping google.com
```

Cela vérifiera que votre serveur Proxmox peut accéder à Internet, ce qui est nécessaire pour communiquer avec les serveurs Let's Encrypt et obtenir un certificat SSL.

### 1.2 Ouvrir les ports nécessaires

Assurez-vous que les ports nécessaires sont ouverts sur votre routeur pour permettre à Let's Encrypt de valider votre domaine. Vous devez ouvrir au moins les ports suivants :

- **Port 80** : Utilisé pour la validation du certificat via le HTTP Challenge de Let's Encrypt.
- **Port 443** : Utilisé pour les connexions HTTPS.

Si vous utilisez un **Dynamic DNS (DDNS)**, comme `tonnom.ddns.net`, vous devez rediriger les ports 80 et 443 de votre routeur vers l'adresse IP locale de votre serveur Proxmox.

---

## Étape 2 : Installer Certbot sur Proxmox

Certbot est l'outil officiel de Let's Encrypt pour obtenir des certificats SSL. Voici comment l'installer sur Proxmox :

1. **Mettre à jour les paquets** :
   Ouvrez un terminal sur votre serveur Proxmox et mettez à jour les paquets disponibles :

   ```bash
   apt update
   ```

2. **Installer Certbot** :

   Installez Certbot avec la commande suivante :

   ```bash
   apt install certbot
   ```

3. **Vérifier l'installation de Certbot** :

   Une fois l'installation terminée, vous pouvez vérifier que Certbot est installé correctement en exécutant :

   ```bash
   certbot --version
   ```

---

## Étape 3 : Obtenir un certificat Let's Encrypt

Une fois Certbot installé, vous pouvez obtenir un certificat SSL pour votre serveur Proxmox. Suivez ces étapes :

### 3.1 Utiliser Certbot pour obtenir un certificat

Exécutez la commande suivante pour demander un certificat SSL pour votre domaine DDNS `tonnom.ddns.net`. Assurez-vous que le port 80 est redirigé sur votre routeur.

```bash
certbot certonly --standalone -d tonnom.ddns.net
```

- `--standalone` indique à Certbot d'utiliser le mode standalone pour valider votre domaine en utilisant le port 80.
- `-d tonnom.ddns.net` spécifie le domaine pour lequel le certificat doit être généré.

### 3.2 Vérification et résultats

Si tout se passe bien, Certbot générera un certificat et l'enregistrera dans le répertoire `/etc/letsencrypt/live/`.

Vous devriez voir les fichiers suivants :
- **fullchain.pem** : Le certificat public.
- **privkey.pem** : La clé privée associée.

---

## Étape 4 : Configurer Proxmox pour utiliser le certificat SSL

Maintenant que vous avez obtenu le certificat, vous devez configurer Proxmox pour l'utiliser pour HTTPS.

### 4.1 Copier les fichiers du certificat

Copiez les fichiers du certificat Let's Encrypt dans les répertoires nécessaires à Proxmox :

```bash
cp /etc/letsencrypt/live/tonnom.ddns.net/fullchain.pem /etc/pve/local/pve-ssl.pem
cp /etc/letsencrypt/live/tonnom.ddns.net/privkey.pem /etc/pve/local/pve-ssl.key
```

### 4.2 Redémarrer le service Proxmox

Une fois les fichiers copiés, redémarrez le service Proxmox pour appliquer le nouveau certificat SSL :

```bash
systemctl restart pveproxy
```

---

## Étape 5 : Vérifier l'accès en HTTPS

1. Ouvrez votre navigateur et accédez à votre serveur Proxmox via HTTPS :
   ```bash
   https://tonnom.ddns.net:8006
   ```

2. Vérifiez que le certificat est valide en observant le cadenas dans la barre d'adresse de votre navigateur.

---

## Étape 6 : Automatiser le renouvellement du certificat

Les certificats Let's Encrypt sont valides pendant 90 jours. Pour automatiser leur renouvellement, nous allons utiliser cron.

### 6.1 Ouvrir la crontab pour édition

Ouvrez la crontab de l'utilisateur courant pour ajouter une tâche cron qui exécutera le renouvellement tous les jours à 3h du matin :

```bash
crontab -e
```

### 6.2 Ajouter la tâche cron

Ajoutez la ligne suivante dans l'éditeur de la crontab pour automatiser le renouvellement et redémarrer le service Proxmox après chaque renouvellement :

```bash
0 3 * * * certbot renew --quiet && systemctl restart pveproxy
```

- `0 3 * * *` : Exécute la tâche tous les jours à 3h00 du matin.
- `certbot renew --quiet` : Vérifie si le certificat doit être renouvelé. L'option `--quiet` supprime les messages inutiles.
- `&& systemctl restart pveproxy` : Si le certificat est renouvelé, cette commande redémarre le service Proxmox pour appliquer le nouveau certificat.

### 6.3 Sauvegarder et quitter l'éditeur

Enregistrez et quittez l'éditeur de la crontab. Si vous utilisez `vi`, appuyez sur `Esc` puis tapez `:wq`. Si vous utilisez `nano`, appuyez sur `Ctrl+X`, puis `Y` pour enregistrer et `Enter` pour quitter.

### 6.4 Vérifier la tâche cron

Pour vérifier que votre tâche cron a été ajoutée correctement, exécutez la commande suivante :

```bash
crontab -l
```

---

## Étape 7 : Tester le renouvellement du certificat

Avant d'attendre le renouvellement automatique, vous pouvez tester que tout fonctionne correctement en exécutant manuellement la commande suivante :

```bash
certbot renew --quiet
```

Cela renouvellera le certificat si nécessaire et redémarrera le service `pveproxy` pour appliquer le nouveau certificat.

---

## Conclusion

Vous avez maintenant configuré avec succès un certificat SSL Let's Encrypt sur votre serveur Proxmox et automatisé son renouvellement grâce à Certbot et cron. Votre serveur Proxmox sera désormais accessible de manière sécurisée via HTTPS, et le renouvellement du certificat sera géré automatiquement tous les 90 jours.

Si vous rencontrez des problèmes, consultez les journaux de Certbot ou de Proxmox pour plus d'informations.