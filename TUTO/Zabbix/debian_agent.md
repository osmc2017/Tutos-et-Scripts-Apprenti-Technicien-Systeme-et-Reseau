# Guide Complet d'Installation du Client Zabbix (Zabbix Agent) sur Debian 12

## Introduction
Ce guide explique comment installer et configurer un client Zabbix (Zabbix Agent) sur une machine Debian 12 pour qu'il puisse communiquer avec un serveur Zabbix.

---

## Étape 1 : Ajouter le dépôt Zabbix

1. Télécharge le fichier de dépôt Zabbix correspondant à Debian 12 :
   ```bash
   wget https://repo.zabbix.com/zabbix/7.2/release/debian/pool/main/z/zabbix-release/zabbix-release_latest_7.2+debian12_all.deb
   ```

2. Installe le dépôt :
   ```bash
   dpkg -i zabbix-release_latest_7.2+debian12_all.deb
   ```

3. Mets à jour les dépôts :
   ```bash
   apt update
   ```

---

## Étape 2 : Installer le client Zabbix (Zabbix Agent)

1. Installe le paquet Zabbix Agent :
   ```bash
   apt install -y zabbix-agent
   ```

2. Vérifie que l’agent est installé :
   ```bash
   dpkg -l | grep zabbix-agent
   ```

---

## Étape 3 : Configurer le client Zabbix

1. Ouvre le fichier de configuration de l'agent :
   ```bash
   nano /etc/zabbix/zabbix_agentd.conf
   ```

2. Modifie les paramètres suivants :
   - **Server** : l’adresse IP ou le nom de domaine du serveur Zabbix.
   - **Hostname** : le nom de l’hôte (doit correspondre à ce qui est configuré sur le serveur Zabbix).

   Exemple :
   ```plaintext
   Server=<IP_du_serveur_Zabbix>
   Hostname=<Nom_de_votre_machine>
   ```

3. Sauvegarde et quitte le fichier (`Ctrl+O`, puis `Entrée`, et `Ctrl+X`).

---

## Étape 4 : Démarrer et activer le client Zabbix

1. Redémarre le service Zabbix Agent :
   ```bash
   systemctl restart zabbix-agent
   ```

2. Active le service au démarrage :
   ```bash
   systemctl enable zabbix-agent
   ```

3. Vérifie l’état du service :
   ```bash
   systemctl status zabbix-agent
   ```

---

## Étape 5 : Ajouter l’hôte sur le serveur Zabbix

1. Connecte-toi à l’interface web de Zabbix.
2. Va dans **Configuration > Hosts > Create host**.
3. Remplis les champs :
   - **Hostname** : doit correspondre à celui défini dans le fichier de configuration de l’agent.
   - **IP address** : l’adresse IP de la machine où l’agent est installé.
   - **Templates** : attache un modèle de surveillance adapté (exemple : **Template OS Linux by Zabbix agent**).

4. Sauvegarde la configuration.

---

## Étape 6 : Vérification

1. Retourne dans **Monitoring > Latest data** pour vérifier si les données de l’hôte remontent correctement.
2. Si les données ne remontent pas, vérifie les logs de l’agent :
   ```bash
   cat /var/log/zabbix/zabbix_agentd.log
   ```

---

## Conclusion
Le client Zabbix (Zabbix Agent) est maintenant installé et configuré sur votre machine Debian 12. Il est prêt à communiquer avec le serveur Zabbix et à transmettre les données de surveillance.
