# Documentation Utilisateur
---
## Sommaire

1) [Définition Security Onion : SIEM](https://github.com/WildCodeSchool/TSSR-2409-P1-G1-Plateforme-de-surveillance-de-securite/edit/main/USER_GUIDE.md#one-d%C3%A9finition-security-onion)
2) [Utilisation de Base](https://github.com/WildCodeSchool/TSSR-2409-P1-G1-Plateforme-de-surveillance-de-securite/edit/main/USER_GUIDE.md#two-utilisation-de-base)
3) [Utilisation avancée](https://github.com/WildCodeSchool/TSSR-2409-P1-G1-Plateforme-de-surveillance-de-securite/blob/main/USER_GUIDE.md#three-utilisation-avanc%C3%A9e)
4) [Installation/enrôlement d'un agent dans Security Onion](https://github.com/WildCodeSchool/TSSR-2409-P1-G1-Plateforme-de-surveillance-de-securite/blob/main/USER_GUIDE.md#4%EF%B8%8F%E2%83%A3-installationenr%C3%B4lement-dun-agent-dans-security-onion)
5) [FAQ : solutions aux problèmes connus et communs liés à l’utilisation](https://github.com/WildCodeSchool/TSSR-2409-P1-G1-Plateforme-de-surveillance-de-securite/blob/main/USER_GUIDE.md#5%EF%B8%8F%E2%83%A3-faq--solutions-aux-probl%C3%A8mes-connus-et-communs-li%C3%A9s-%C3%A0-lutilisation)



## :one: Définition Security Onion
Security Onion est un SIEM : Système de gestion des événements et des informations de sécurité. C'est un système centralisé qui permet une visibilité globale sur l'ensemble de l'activité du réseau et qui permet de régir aux menaces en temps réel.
Security Onion est une distribution Linux (basée sur Fedora) open source conçue pour la surveillance et l'analyse de la sécurité réseau. Elle est spécifiquement développée pour aider les organisations à détecter et à répondre aux menaces de sécurité en fournissant des outils puissants pour la surveillance du trafic réseau, l'analyse des journaux et la détection d'intrusions.  

Dans le diagramme ci-dessous, on peut voir l'architecture Security Onion simplifiée dans un réseau d'entreprise traditionnel avec un pare-feu, des postes de travail et des serveurs.  
Vous pouvez utiliser Security Onion pour surveiller le trafic nord/sud afin de détecter un adversaire entrant dans un environnement depuis le reseau internet, mais également surveiller le trafic est/ouest pour détecter les mouvements entre les terminaux.  
Security Onion peut collecter les journaux de vos serveurs et postes de travail afin que vous puissiez ensuite rechercher simultanément tous les journaux de votre réseau et de votre hôte.
![Architecture security onion](https://docs.securityonion.net/en/2.4/_images/network-horiz.png)


## :two: Utilisation de base
### Connexion
Une fois l'installation terminée, connectez vous avec l'adresse IP de votre installation Security Onion. Connectez vous à l'aide de l'adresse mail et du mot de passe spécifiés pendant l'installation.

![écran login](https://docs.securityonion.net/en/2.4/_images/37_login.png)  

  
Une fois connecté, vous remarquerez le menu principal sur la partie gauche avec les liens vers des outils d'analyste tels que Alerts, Dashboards, Hunts, Cases, Detections, PCAP, Kibana, CyberChef et ATT&CK Navigator. Le menu utilisateur est en haut à droite pour accéder à la doc et autres ressources et gérer les paramètres utilisateur.

![UserMenu](https://docs.securityonion.net/en/2.4/_images/94_usermenu.png)

### Alerts 
Security Onion comprend une interface Alerts qui vous donne un aperçu des alertes générées par Security Onion. Vous pouvez ensuite accéder rapidement aux détails, basculer vers Hunt ou l'interface PCAP et faire remonter les alertes vers les dossiers .

![Alerts](https://docs.securityonion.net/en/2.4/_images/50_alerts.png)


### Dashboards
Security Onion comprend une interface de tableaux de bord qui comprend un ensemble complet de tableaux de bord prédéfinis. Les informations sont paramétrables, comme l'intervalle de rafraichissement et l'inclusion/exclusion de certaines informations.

![Dashboards](https://docs.securityonion.net/en/2.4/_images/53_dashboards.png)

### Hunt
Il comprend également une interface proche de Dashboards. Mais dans Hunt les rêquetes sont plus ciblées que dans Dashboards et il est plutôt adapté à la recherche de menace.

![Hunt](https://docs.securityonion.net/en/2.4/_images/56_hunt.png)


### Cases
Cette interface est utilisée pour la gestion des cas. Elle permet de faire remonter les journaux de Alerts, Dashboards et Hunt. Elle permet ensuite d'affecter des analystes, de rajouter des commentaires et des pièces jointes et de suivre ce qui est observable.

![Cases](https://docs.securityonion.net/en/2.4/_images/57_0_cases.png)


### Detection
Cette interface sert à paramétrer les règles de détection.

![Detection](https://docs.securityonion.net/en/2.4/_images/57_detections.png)


### PCAP
PCAP permet d'accéder aux captures de paquets du réseau, qui ont été écrites par Suricata par exemple.

![PCAP](https://docs.securityonion.net/en/2.4/_images/62_pcap.png)


### Grid
Cette interface permet de voir l'état des noeuds du réseau.

![Grid](https://docs.securityonion.net/en/2.4/_images/39_grid.png)


### Downloads
Cette interface permet de télécharger ElasticAgent

![Downloads](https://docs.securityonion.net/en/2.4/_images/78_downloads.png)


### Administration
La partie administration permet de gérer les utilisateurs, les membres du réseau, la configuration et la clé de licence.

![Adminnistration](https://docs.securityonion.net/en/2.4/_images/81_users.png)


## :three: Utilisation avancée
  * #### Surveillance du traffic réseau
    Security Onion utilise des outils tels que **Suricata** et **Zeek**.
    
    >***Suricata :*** Cet outil va analyser le traffic sur une ou plusieurs interfaces réseaux en temps réel en fonction des règles activées. Il génère un fichier qui peut     
    ensuite être utilisé par Logstash ou ElasticSearch. Outil puissant pour la détection et prévention d'intrusion.
    
    >***Zeek :*** Cet outil est également un analyseur de traffic réseau, mais plus passif que Suricata. Il capture et analyse les paquets pour une utilisation ultérieur.
    
    
  * #### Analyse de journaux
    Il intègre des outils comme **ElasticSearch**, **Logstash** et **Kibana** appelés suite "ELK". Cette suite de logiciels permet de collecter n'importe quel format de données depuis n'importe quelle source pour les analyser.
    
    >***ElasticSearch :*** Moteur de recherche et d'analyse, il centralise le stockage de vos données et fournit une recherche rapide et pertinante. Choix idéal dans l'analyse des journaux. Il indexe, analyse et recherche les données ingérées.
    
    >***Logstash :*** Permet de collecter les données de diverses sources, de les transformer et de les envoyer. Il sert souvent de "pipeline" côté serveur, pour envoyer vers ElasticSearch. Il ingère, transforme et envoie les données à bonne destination.

    >***Kibana :*** Outil de visualisation des journaux analysés. Il propose différentes formes de graphiques et de rapports intuitifs utilisés pour naviguer de manière interactive dans de grandes quantités de données. Il visualise les résultats.

    
  
  * #### HoneyPots de détection d'intrusion
    Security Onion dispose d'un noeud HoneyPot qui imite les services, basé sur **OpenCanary**. Toute intrusion à ces services génère automatiquement une alerte.

    >***OpenCanary :*** Capable de simuler plusieurs services et applications susceptibles d'être ciblés par des attaquants tels que des serveurs SSH, HTTP, FTP...

## 4️⃣: Installation/enrôlement d'un agent dans Security Onion

Afin de centraliser, tester et visualiser les données récoltées par le serveur security Onion, nous avons besoin d'un agent.
Un agent est un logiciel déployé sur un système perttant de surveiller les activités, collecter des données et réaliser certaines tâches.
Nous avons besoin à minima d'un agent, et donc d'une nouvelle machine capable de communiquer avec les serveurs de gestion d'analyse.


### _Ajouter un agent_


* Dans le panel de gauche, se rendre dans Tools et ouvrir l'outil Elastic Fleet.

* Dans Elastic Fleet, cliquer sur "Add agent" et suivre les étapes indiquées. A l'étape 1, nous choisissons "endpoints-initial"

<p align="center">
<img src="https://github.com/WildCodeSchool/TSSR-2409-P1-G1-Plateforme-de-surveillance-de-securite/blob/main/Install_Screen_SecurityOnion/Elastic_Fleet.png" alt="Pictures" width="800" >
</p>

* A l'étape 2, garder sélectionnée l'option "Enroll in Fleet"

* A l'étape 3, il est question de choisir l'architecture sur laquelle installer l'agent.

* Dans notre cas, nous optons pour une machine Windows 10. Nous privilégierons l'installation manuelle afin d'affiner les options. 

* Conserver les informations présentes dans l'étape 3 (commandes, liens, token , …)



### _Récupérer l'exécutable de l'os (ici windows 10)_



* Dans le panel de gauche de l'interface de Security Onion, se rendre dans Downloads

* Télécharger le exe de Windows "so-elastic-agent"



### _Configurer le firewall_


* Depuis l'interface, se rendre dans le panel de gauche puis dans Amdministration, puis Configuration - Grid Configuration

* Sur la fenêtre de droite, cliquer sur "Allow Elastic Agent endpoints to send logs"


<p align="center">
<img src="https://github.com/WildCodeSchool/TSSR-2409-P1-G1-Plateforme-de-surveillance-de-securite/blob/main/Install_Screen_SecurityOnion/Agent_Firewall_config.png" alt="Pictures" width="800" >
</p>


* La fenêtre ouvre le menu firewall et son sous-dossier "hostgroups" où devrait se retrouver l'"elastic_agent_endpoint"

* Ajouter l'IP de la machine ayant le rôle d'agent dans la liste des "IP or CIDR blocks to allow access to this hostgroup"

* Le chevron vertical qui surplombe cette fenêtre cache un menu déroulant par le haut à partir duquel on peut appuyer sur le "synchronize grid"


<p align="center">
<img src="https://github.com/WildCodeSchool/TSSR-2409-P1-G1-Plateforme-de-surveillance-de-securite/blob/main/Install_Screen_SecurityOnion/Agent_synch_grid.png" alt="Pictures" width="800" >
</p>


* Une notification bleue devrait apparaître en haut de l'écran "synchronization has been initiated in the background; this process can take several minutes to complete"

 >***NB :*** avant les prochaines étapes, nous précisons que nous avons redémarré le serveur security onion. Vérifier que le serveur est bien en ligne avec un ping.


### _Installation de l'agent_


* Retourner sur le téléchargement du exe (le placer dans un répertoire adéquat), tenter un clic droit et "run as admin".

* L'exécution du exe so-elastic-agent peut ne pas fonctionner et produire un rapport d'erreur normalement disponible dans le même répertoire. Il sera appelé "SO-Elastic-Agent_Installer.log". Ce fichier dispose des infos de connexion entre l'agent et la "Fleet Hosts", les même que celles de la page Elastic Fleet.

* Prendre note du token associé à la tentative d'enrôlement.

* Dans notre cas nous ne souhaitons pas de connexion sécurisée entre notre agent et notre serveur puisqu'il s'agit d'un test et que nous ne disposons par ailleurs pas de certificat https.

* Toujours dans le cas de figure où l'agent n'est pas initialisé par l'exécution. Utiliser PowerShell, ouvrir l'invite et se rendre dans le répertoire du exe.

<p align="center">
<img src="https://github.com/WildCodeSchool/TSSR-2409-P1-G1-Plateforme-de-surveillance-de-securite/blob/main/Install_Screen_SecurityOnion/Agent_install_command.png" alt="Pictures" width="800" >
</p>


* Une fois dans le répertoire du fichier, lancer l'installation manuellement avec la commande suivante :
\
		 ```.\so-elastic-agent_windows_amd64.exe install --url=http://IPADRESS:PORT --enrollment-token="TOKEN" --insecure```
* Ceci devrait permettre l'installation de l'agent sans le mode sécurisé. 

* De retour dans l'interface, vérifier le Dashboard de Security Onion et choisir le filtre à côté du champ de recherche "Host Overview"

* Vérifier si de nouvelles données relatives au système de l'agent ont été collectées.  

[ressource utile](https://www.youtube.com/watch?v=cGmQMsFuAvw)

<br>

## 5️⃣ FAQ : solutions aux problèmes connus et communs liés à l’utilisation  
:interrobang: [Faq site officiel](https://docs.securityonion.net/en/2.4/faq.html#users-passwords)
