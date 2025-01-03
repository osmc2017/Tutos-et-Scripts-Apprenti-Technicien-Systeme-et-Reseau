# Tutoriel : Installation, configuration et surveillance des journaux de Squid en mode HTTP uniquement

## **Introduction**
Squid est un serveur proxy populaire qui gère les connexions HTTP et, si configuré, HTTPS. La surveillance des journaux de Squid permet d'analyser l'activité des clients, de détecter les problèmes et de comprendre comment le proxy est utilisé. Ce tutoriel vous guide pour installer, configurer, surveiller et interpréter les journaux de Squid en temps réel. Nous ajoutons aussi une section pour automatiser le nettoyage des journaux et filtrer l’accès à certains sites.

Nous expliquons également l’importance du HTTP et des proxys HTTP dans un environnement réseau.

---

## **1. L’utilité du HTTP et des proxys HTTP**

### **Qu’est-ce que le HTTP ?**
- **HTTP (HyperText Transfer Protocol)** est le protocole utilisé pour la transmission de pages web et d'autres ressources sur Internet.
- Contrairement à HTTPS, HTTP ne crypte pas les données transmises, ce qui en fait un protocole moins sécurisé mais plus simple pour les communications internes sur un réseau privé.

### **Pourquoi utiliser un proxy HTTP ?**
1. **Cache de contenu :** Améliore les temps de chargement pour les utilisateurs en stockant localement les données fréquemment accédées.
2. **Contrôle d’accès :** Gère qui peut accéder à quelles ressources sur le réseau.
3. **Filtrage :** Bloque les contenus non autorisés ou inappropriés.
4. **Analyse du trafic :** Fournit des journaux pour analyser l’utilisation du réseau.

---

## **2. Installation de Squid**

### **Étape 1 : Installer Squid**
1. **Mettez à jour votre système :**
   ```bash
   sudo apt update
   sudo apt upgrade -y
   ```

2. **Installez Squid :**
   ```bash
   sudo apt install squid -y
   ```

3. **Vérifiez l’installation :**
   ```bash
   squid -v
   ```
   Cela doit afficher la version de Squid installée.

4. **Démarrez Squid :**
   ```bash
   sudo systemctl start squid
   sudo systemctl enable squid
   ```

5. **Vérifiez que Squid fonctionne :**
   ```bash
   sudo systemctl status squid
   ```
   Vous devriez voir "active (running)".

---

## **3. Configuration de Squid en HTTP uniquement**

1. **Sauvegardez le fichier de configuration d’origine :**
   ```bash
   sudo cp /etc/squid/squid.conf /etc/squid/squid.conf.bak
   ```

2. **Ouvrez le fichier de configuration :**
   ```bash
   sudo nano /etc/squid/squid.conf
   ```

3. **Ajoutez la configuration suivante :**
   ```plaintext
   # Squid configuration for HTTP proxy

   # Squid listens on port 3128 for HTTP traffic
   http_port 3128

   # Define ACLs
   acl localnet src 192.168.50.0/24  # Replace with your local network range
   acl Safe_ports port 80           # HTTP
   acl CONNECT method CONNECT

   # Allow local network traffic
   http_access allow localnet
   http_access allow localhost

   # Deny all other traffic
   http_access deny all

   # DNS servers
   dns_nameservers 8.8.8.8 8.8.4.4

   # Caching options
   cache_dir ufs /var/spool/squid 100 16 256
   cache_mem 64 MB
   maximum_object_size_in_memory 512 KB
   maximum_object_size 5 MB

   # Logs
   access_log /var/log/squid/access.log
   cache_log /var/log/squid/cache.log
   ```

4. **Sauvegardez et fermez le fichier :**
   - Appuyez sur `CTRL+O`, puis `Entrée` pour sauvegarder.
   - Appuyez sur `CTRL+X` pour quitter.

5. **Redémarrez Squid pour appliquer les modifications :**
   ```bash
   sudo systemctl restart squid
   ```

---

## **4. Surveiller les journaux de Squid en direct**

### **Accéder au journal des requêtes (access.log)**
Le fichier `access.log` vous permet de voir les requêtes HTTP passées par le proxy. Pour le suivre en temps réel :

```bash
sudo tail -f /var/log/squid/access.log
```

- **Colonnes principales :**
  - Temps de réponse.
  - Code de statut HTTP (ex. : 200, 403).
  - Type de requête (CONNECT, GET, etc.).
  - URL demandée par le client.

### **Accéder au journal du cache (cache.log)**
Le fichier `cache.log` contient des informations sur les erreurs ou le fonctionnement interne de Squid. Pour le suivre en direct :

```bash
sudo tail -f /var/log/squid/cache.log
```

- **Utilité :**
  - Diagnostiquer les problèmes de configuration.
  - Identifier les erreurs critiques dans Squid.

### **Filtrer les journaux avec grep**
Pour analyser des informations spécifiques dans les journaux :

- **Rechercher une URL spécifique :**
  ```bash
  sudo tail -f /var/log/squid/access.log | grep "example.com"
  ```

- **Afficher uniquement les requêtes bloquées :**
  ```bash
  sudo tail -f /var/log/squid/access.log | grep "TCP_DENIED"
  ```

- **Filtrer par adresse IP client :**
  ```bash
  sudo tail -f /var/log/squid/access.log | grep "192.168.50.35"
  ```

---

## **5. Filtrage des sites web avec Squid**
Squid permet de bloquer ou autoriser des sites web spécifiques en utilisant des listes de contrôle d'accès (ACL).

### **Bloquer un site web spécifique**
1. **Ajoutez une ACL pour le site à bloquer :**
   Dans le fichier `/etc/squid/squid.conf`, ajoutez :
   ```plaintext
   acl blocked_sites dstdomain .example.com
   http_access deny blocked_sites
   ```
   - `dstdomain` : Utilisé pour correspondre aux domaines.
   - `.example.com` : Bloque tout sous-domaine de `example.com`.

2. **Redémarrez Squid :**
   ```bash
   sudo systemctl restart squid
   ```

### **Bloquer plusieurs sites avec une liste**
1. **Créez un fichier contenant les domaines à bloquer :**
   ```bash
   sudo nano /etc/squid/blocked_sites.txt
   ```
   Ajoutez les domaines, un par ligne :
   ```plaintext
   .example.com
   .facebook.com
   .youtube.com
   ```

2. **Ajoutez l'ACL dans le fichier de configuration de Squid :**
   ```plaintext
   acl blocked_sites dstdomain "/etc/squid/blocked_sites.txt"
   http_access deny blocked_sites
   ```

3. **Redémarrez Squid :**
   ```bash
   sudo systemctl restart squid
   ```

### **Autoriser uniquement certains sites web**
1. **Créez un fichier contenant les domaines autorisés :**
   ```bash
   sudo nano /etc/squid/allowed_sites.txt
   ```
   Ajoutez les domaines, un par ligne :
   ```plaintext
   .example.com
   .myschool.edu
   .trustedsite.org
   ```

2. **Ajoutez l'ACL dans le fichier de configuration de Squid :**
   ```plaintext
   acl allowed_sites dstdomain "/etc/squid/allowed_sites.txt"
   http_access allow allowed_sites
   http_access deny all
   ```

3. **Redémarrez Squid :**
   ```bash
   sudo systemctl restart squid
   ```

---

## **6. Surveiller Squid via journalctl**
Si Squid est géré via systemd, vous pouvez utiliser `journalctl` pour accéder aux journaux systèmes en direct :

```bash
sudo journalctl -u squid -f
```

- **Avantages :**
  - Permet d’observer les démarrages, redémarrages et événements critiques de Squid.

---

## **7. Interpréter les journaux de Squid**

### **Codes de statut HTTP courants :**
- **200 :** Succès.
- **403 :** Accès refusé.
- **404 :** Page non trouvée.
- **503 :** Service temporairement indisponible.

### **Exemple d’entrée dans `access.log` :**
```plaintext
1672734281.123    254 192.168.50.35 TCP_MISS/200 12345 GET http://example.com/ - DIRECT/93.184.216.34 text/html
```
- **1672734281.123 :** Horodatage.
- **254 :** Temps de réponse (ms).
- **192.168.50.35 :** Adresse IP du client.
- **TCP_MISS/200 :** Le proxy a obtenu une réponse "200 OK" depuis l’Internet (pas dans le cache).
- **GET :** Type de requête.
- **http://example.com/ :** URL demandée.

---

## **8. Automatiser le nettoyage des journaux**
Les fichiers de journaux peuvent devenir volumineux au fil du temps. Automatiser leur nettoyage permet de maintenir votre serveur propre et efficace.

### **Configurer une tâche Cron pour le nettoyage**

1. **Ouvrez l'éditeur Cron pour l'utilisateur root :**
   ```bash
   sudo crontab -e
   ```

2. **Ajoutez la ligne suivante pour nettoyer les journaux quotidiennement à minuit :**
   ```bash
   0 0 * * * truncate -s 0 /var/log/squid/access.log /var/log/squid/cache.log
   ```

   - **Explication :**
     - `0 0 * * *` : Exécute la tâche tous les jours à minuit.
     - `truncate -s 0` : Réduit la taille des fichiers spécifiés à 0 octet (les vide sans les supprimer).

3. **Sauvegardez et fermez l'éditeur Cron.**

4. **Vérifiez les tâches Cron configurées :**
   ```bash
   sudo crontab -l
   ```
   Vous devriez voir la tâche ajoutée.

---

## **9. Conclusion**
Ce tutoriel vous a guidé dans l'installation et la configuration de Squid en tant que proxy HTTP, ainsi que dans la surveillance et la gestion des journaux. Vous avez également appris à filtrer l'accès à certains sites et à automatiser les tâches d'entretien.

