# Tutoriel : Installation et Configuration de Pi-hole

Pi-hole est un bloqueur de publicités à l'échelle du réseau, agissant comme un serveur DNS qui filtre les publicités et le contenu indésirable pour tous les appareils connectés.

---

## **1. Pré-requis**

1. **Un appareil supporté :**

   - Un Raspberry Pi (recommandé).
   - Ou une machine virtuelle ou un serveur Linux (Debian/Ubuntu).

2. **Une connexion Internet active.**

3. **Accès root à l'appareil.**

4. **Un client SSH (si vous configurez à distance).**

---

## **2. Installation de Pi-hole**

1. **Mettre à jour votre système :**

   ```bash
   sudo apt update && sudo apt upgrade -y
   ```

2. **Exécuter le script d'installation automatique de Pi-hole :**

   ```bash
   curl -sSL https://install.pi-hole.net | bash
   ```

3. **Suivez les instructions interactives :**

   - Choisissez l'interface réseau à utiliser (généralement eth0 pour une connexion Ethernet).
   - **Sélectionnez Quad9 comme fournisseur DNS**, recommandé pour sa politique de respect de la vie privée des utilisateurs.
   - Acceptez les paramètres par défaut sauf indication contraire.

4. **Récupérez les informations importantes à la fin :**

   - L'URL d'administration (par défaut : `http://<ip_du_serveur>/admin`).
   - Le mot de passe d'administration.

---

## **3. Configuration du DHCP**

Pour fonctionner, Pi-Hole a besoin de "résoudre" les requêtes DNS des clients, il faut donc que ces derniers puissent savoir que c'est à lui qu'il faut les envoyer. Voici plusieurs solutions :

1. **Modifier les paramètres DNS dans le serveur DHCP de votre réseau**

   - Rendez-vous dans l'interface d'administration de votre routeur ou box.
   - Modifiez les paramètres DNS pour y mettre l'adresse IP de votre Pi-Hole.
   - Exemple : Si votre Pi-Hole a l'adresse `192.168.50.10`, configurez cette adresse dans la section DNS.

2. **Désactiver le serveur DHCP de votre routeur et utiliser celui de Pi-Hole**

   - Activez le serveur DHCP intégré de Pi-Hole via l'interface Web.

3. **Configurer manuellement chaque appareil pour qu'il utilise Pi-Hole comme serveur DNS**

   - Sur chaque appareil, modifiez les paramètres DNS pour pointer vers l'adresse IP de Pi-Hole.

### **Redémarrer les appareils clients**

Une fois la configuration effectuée, redémarrez vos appareils ou renouvelez leur configuration IP :

- Sur les postes Windows :
  ```bash
  ipconfig /renew
  ```
- Sur un poste Linux :
  ```bash
  dhclient
  ```
- Autres appareils : Éteignez-les et rallumez-les.

### **Vérification des paramètres**

Pour vérifier que les clients utilisent bien Pi-Hole comme DNS :

- Sur Windows :
  ```bash
  ipconfig /all
  ```
  Vous devriez voir l'adresse IP de votre Pi-Hole dans la section "Serveur DNS".

---

## **4. Accéder à l'interface Web**

1. **Ouvrez un navigateur web :**

   - Accédez à `http://<ip_du_serveur>/admin`.

2. **Connectez-vous avec le mot de passe fourni lors de l'installation.**

3. **Changez le mot de passe (optionnel) :**

   ```bash
   sudo pihole -a -p
   ```

---

## **5. Fonctionnalités supplémentaires**

1. **Ajouter des listes de blocage supplémentaires**

   - Allez dans l'interface Web de Pi-hole.
   - Naviguez vers **Group Management** > **Adlists**.
   - Ajoutez les listes suivantes, qui bloquent publicités et menaces sans perturber un usage courant :
     ```
     https://raw.githubusercontent.com/PolishFiltersTeam/KADhosts/master/KADhosts.txt
     https://raw.githubusercontent.com/FadeMind/hosts.extras/master/add.Spam/hosts
     https://v.firebog.net/hosts/static/w3kbl.txt
     https://adaway.org/hosts.txt
     https://v.firebog.net/hosts/AdguardDNS.txt
     https://v.firebog.net/hosts/Admiral.txt
     https://raw.githubusercontent.com/anudeepND/blacklist/master/adservers.txt
     https://v.firebog.net/hosts/Easylist.txt
     https://pgl.yoyo.org/adservers/serverlist.php?hostformat=hosts&showintro=0&mimetype=plaintext
     https://raw.githubusercontent.com/FadeMind/hosts.extras/master/UncheckyAds/hosts
     https://raw.githubusercontent.com/bigdargon/hostsVN/master/hosts
     https://v.firebog.net/hosts/Easyprivacy.txt
     https://v.firebog.net/hosts/Prigent-Ads.txt
     https://raw.githubusercontent.com/FadeMind/hosts.extras/master/add.2o7Net/hosts
     https://raw.githubusercontent.com/crazy-max/WindowsSpyBlocker/master/data/hosts/spy.txt
     https://hostfiles.frogeye.fr/firstparty-trackers-hosts.txt
     https://raw.githubusercontent.com/DandelionSprout/adfilt/master/Alternate%20versions%20Anti-Malware%20List/AntiMalwareHosts.txt
     https://osint.digitalside.it/Threat-Intel/lists/latestdomains.txt
     https://v.firebog.net/hosts/Prigent-Crypto.txt
     https://raw.githubusercontent.com/FadeMind/hosts.extras/master/add.Risk/hosts
     https://bitbucket.org/ethanr/dns-blacklists/raw/8575c9f96e5b4a1308f2f12394abd86d0927a4a0/bad_lists/Mandiant_APT1_Report_Appendix_D.txt
     https://phishing.army/download/phishing_army_blocklist_extended.txt
     https://gitlab.com/quidsup/notrack-blocklists/raw/master/notrack-malware.txt
     https://v.firebog.net/hosts/RPiList-Malware.txt
     https://v.firebog.net/hosts/RPiList-Phishing.txt
     https://raw.githubusercontent.com/Spam404/lists/master/main-blacklist.txt
     https://raw.githubusercontent.com/AssoEchap/stalkerware-indicators/master/generated/hosts
     https://urlhaus.abuse.ch/downloads/hostfile/
     https://zerodot1.gitlab.io/CoinBlockerLists/hosts_browser
     ```

2. **Autoriser des domaines spécifiques :**

   - Ajoutez des exceptions dans **Whitelist** si certains sites ne fonctionnent pas.

3. **Surveiller les journaux :**

   - Visualisez les requêtes bloquées et autorisées dans l'interface Web.
   - Accédez à l'historique complet via :
     ```bash
     pihole -t
     ```

---

## **6. Mise à jour et maintenance**

1. **Mettre à jour Pi-hole :**

   ```bash
   pihole -up
   ```

2. **Redémarrer Pi-hole :**

   ```bash
   sudo systemctl restart pihole-FTL
   ```

3. **Vérifier l'état de Pi-hole :**

   ```bash
   pihole status
   ```

---

## **7. Résolution des problèmes courants**

1. **Pi-hole ne bloque pas les publicités :**

   - Assurez-vous que les clients utilisent l'adresse IP du Pi-hole comme serveur DNS.
   - Redémarrez les appareils clients pour appliquer les nouveaux paramètres DNS.

2. **L'interface Web n'est pas accessible :**

   - Assurez-vous que le service Pi-hole est actif :
     ```bash
     sudo systemctl status pihole-FTL
     ```

3. **Les sites légitimes sont bloqués :**

   - Ajoutez ces domaines à la liste blanche via l'interface Web ou la ligne de commande :
     ```bash
     pihole -w <domaine>
     ```

---

Avec cette configuration, Pi-hole bloquera automatiquement les publicités et le contenu indésirable sur tous les appareils de votre réseau.
