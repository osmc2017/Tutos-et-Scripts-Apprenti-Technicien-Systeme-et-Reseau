# Tutoriel : Configuration de Squid en Proxy HTTPS explicite

## **Introduction**
Dans ce tutoriel, nous configurons Squid pour agir comme un **proxy HTTPS explicite**, sans décryptage. Cela permet de tunnéliser les connexions HTTPS sans utiliser de certificats. Nous aborderons aussi l'analyse des journaux pour comprendre l'activité du proxy et résoudre les problèmes potentiels.

---

## **1. Pourquoi utiliser un proxy HTTPS explicite ?**

### **Avantages :**
1. **Simplicité :** Aucun certificat n'est nécessaire côté clients.
2. **Compatibilité :** Convient aux environnements où l'inspection du contenu HTTPS n'est pas requise.
3. **Gestion centralisée :** Toutes les connexions passent par le proxy, permettant une surveillance et un contrôle limités.

### **Limites :**
- Squid ne peut pas filtrer ou analyser le contenu des connexions HTTPS (uniquement le domaine).
- Nécessite une configuration explicite du proxy sur les clients.

---

## **2. Préparer Squid**

### **Vérifier l'installation de Squid**
Assurez-vous que Squid est installé et fonctionne :
```bash
sudo systemctl status squid
```
Si ce n'est pas le cas, installez Squid :
```bash
sudo apt update
sudo apt install squid -y
```

---

## **3. Configurer Squid pour HTTPS explicite**

1. **Sauvegardez la configuration actuelle :**
   ```bash
   sudo cp /etc/squid/squid.conf /etc/squid/squid.conf.bak
   ```

2. **Modifiez le fichier de configuration :**
   ```bash
   sudo nano /etc/squid/squid.conf
   ```

3. **Ajoutez ou modifiez les lignes suivantes :**
   ```plaintext
   # Squid configuration for HTTPS without interception

   # Listen on port 3128 for HTTP and HTTPS traffic
   http_port 3128

   # Define ACLs
   acl localnet src 192.168.50.0/24  # Remplacez par votre réseau local
   acl Safe_ports port 80            # HTTP
   acl Safe_ports port 443           # HTTPS
   acl Safe_ports port 8006          # Proxmox
   acl Safe_ports port 5001          # NAS
   acl CONNECT method CONNECT

   # Allow traffic to safe ports (HTTP/HTTPS)
   http_access allow CONNECT localnet Safe_ports

   # Allow local network traffic
   http_access allow localnet

   # Deny all other traffic
   http_access deny all

   # DNS servers
   dns_nameservers 8.8.8.8 8.8.4.4

   # Logs
   access_log /var/log/squid/access.log
   cache_log /var/log/squid/cache.log
   ```

4. **Sauvegardez et quittez l'éditeur :**
   - Appuyez sur `CTRL+O`, puis `Entrée` pour sauvegarder.
   - Appuyez sur `CTRL+X` pour quitter.

5. **Redémarrez Squid pour appliquer les modifications :**
   ```bash
   sudo systemctl restart squid
   ```

6. **Vérifiez que Squid écoute sur le port 3128 :**
   ```bash
   sudo netstat -tuln | grep 3128
   ```

---

## **4. Configurer les clients pour utiliser le proxy**

1. **Configurer manuellement le proxy sur les clients :**
   - Adresse : `192.168.50.x` (IP du serveur Squid).
   - Port : `3128`.

2. **Tester la connexion :**
   - Accédez à un site HTTPS (par exemple, `https://www.example.com`).
   - Vérifiez les journaux de Squid :
     ```bash
     sudo tail -f /var/log/squid/access.log
     ```

---

## **5. Comprendre les journaux de Squid**

### **Exemple de journaux**

#### **1. Requête HTTPS tunnélisée :**
```plaintext
1735897970.832      3 192.168.50.35 TCP_TUNNEL/200 2434 CONNECT 192.168.50.100:8006 - HIER_DIRECT/192.168.50.100 -
```
- **TCP_TUNNEL/200 :** Squid a établi un tunnel HTTPS avec succès.
- **192.168.50.35 :** Adresse IP du client.
- **192.168.50.100:8006 :** Serveur cible (Proxmox).
- **HIER_DIRECT :** Requête transmise directement au serveur.

#### **2. Requête HTTP non mise en cache :**
```plaintext
1735897973.826      1 192.168.50.35 TCP_MISS/200 1387 GET http://192.168.50.41/admin/api.php? - HIER_DIRECT/192.168.50.41 application/json
```
- **TCP_MISS/200 :** Squid a récupéré la ressource depuis le serveur cible.
- **GET :** Requête HTTP GET.
- **http://192.168.50.41/admin/api.php :** URL demandée.
- **HIER_DIRECT :** Requête transmise directement au serveur.

#### **3. Erreur de connexion :**
```plaintext
1735897975.018      0 192.168.50.35 NONE/503 0 CONNECT www.https:443 - HIER_NONE/- -
```
- **NONE/503 :** La connexion a échoué (problème de réseau ou de DNS).

---

## **6. Résolution des problèmes**

1. **DNS incorrect :**
   - Vérifiez les DNS configurés dans Squid :
     ```bash
     nslookup www.example.com
     ```
   - Assurez-vous que `dns_nameservers` pointe vers des serveurs fonctionnels (ex. : `8.8.8.8`).

2. **Ports non autorisés :**
   - Si des connexions échouent, ajoutez les ports nécessaires dans Squid :
     ```plaintext
     acl Safe_ports port 443
     acl Safe_ports port 8006
     acl Safe_ports port 5001
     http_access allow CONNECT localnet Safe_ports
     ```
   - Redémarrez Squid :
     ```bash
     sudo systemctl restart squid
     ```

3. **Problèmes d'accès local :**
   - Assurez-vous que Squid a les permissions pour accéder aux IP locales et aux ports nécessaires.
   - Testez la connexion directement depuis le serveur Squid :
     ```bash
     curl -v https://192.168.50.100:8006
     ```

---

## **7. Résumé et recommandations**
- Avec cette configuration, Squid fonctionne comme un proxy explicite pour HTTP et HTTPS.
- Les journaux permettent de surveiller l'activité et d'identifier les problèmes.
- Cette configuration est idéale pour un usage simple où l'inspection HTTPS n'est pas nécessaire.


