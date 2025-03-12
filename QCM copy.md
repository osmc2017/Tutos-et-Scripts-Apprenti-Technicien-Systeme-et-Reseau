# QCM - Administration Système, Réseau, Linux et Active Directory

# QCM - Administration Système, Réseau, Linux et Active Directory

## **QCM Réseau, Linux et Active Directory**

### **Réseau**

1. Quelle est la différence entre une adresse IP privée et une adresse IP publique ?
un reseau privée et dédié a un réseau interne et n'est pas routable sur internet contrairement a un réseau publique qui lui est destiné a être accessible sur internet

2. Quel est le rôle d’un routeur dans un réseau ?  
le routeur permet de mettre en lien des réseau différent

3. Comment fonctionne le protocole ARP ?  
le protocole arp permet de lier des adresse mac a des adresses ip

4. Quelle est la différence entre un switch et un hub ?  
un switch etabli une table mac et une fois la table etabli il redirige les flux sur les bon port. un hub envoi chaque requete sur tous les ports.

5. Pourquoi utiliser le protocole STP (Spanning Tree Protocol) dans un réseau ?  
...

6. Quel est l’intérêt d’utiliser une DMZ dans une architecture réseau ?  
une DMZ permet d'isoler un serveur sur un réseau pour qu'il soit accessible depuis l'exterieur snas rendre le reseau interne vulnerable.

7. Quelles sont les principales différences entre IPv4 et IPv6 ?  
IPV4 est une adresse sur 32 bits et IPv6 sur 128 bit. Ce qui fait qu'il y a beaucoup plus d'adresse disponible avec la v6

8. À quoi sert une table de routage ?  
La table de routage permet d'indiquer les routes a prendre pour acceder a d'autre réseau. 

9. Quelle est la fonction principale du protocole BGP ?  
...

10. Pourquoi utilise-t-on NAT dans un réseau d’entreprise ?  
le NAT permet de masquer sous une adresse unique tout le réseau privé de l'entreprise. cela permet d'éviter les conflis d'adresse ip quand on veut associer plusieurs site. Ca permet egalement d'eviter la penurie d'addresse IPv4

11. Effectuez la conversion de l'adresse IPv4 suivante en binaire : **192.168.1.10**  
1100000 10101000 00000001 00001010

12. Quel est le masque de sous-réseau par défaut pour une adresse **192.168.1.0/24** ?  
255.255.255.0

13. Effectuez la conversion de l'adresse IPv4 suivante en hexadécimal : **172.16.0.1**  
0xAC 0x10 0x00 0x01

14. Convertissez l’adresse binaire suivante en décimal : **11000000.10101000.00000001.00000001**  
192.168.1.1

15. Associez les numéros de ports aux protocoles et aux types de transport (TCP/UDP) :

   | Port | Protocole | TCP/UDP |
   |------|-----------|---------|
   | 22   | ssh       | TCP     |
   | 443  | IMAP      | TCP     |
   | 53   | DNS       | TCP et UDP       |
   | 3389 | RDP       | TCP     |
   | 80   | HTTP      | TCP     |
   | 25   | SMTP      | TCP     |
   | 465  | SMTPS     | TCP     |
   | 123  | STP       | UDP     |
   | 389  | LDAP      | TCP     |


16. Sélectionnez **deux** protocoles qui fonctionnent en mode **sans connexion** :  
   - A) TCP  
   - B) UDP  ok
   - C) HTTP  
   - D) ICMP  
   - E) FTP  ok


17. Quels sont les **trois** avantages d’un VLAN dans un réseau d’entreprise ?  
   - A) Amélioration de la sécurité  ok
   - B) Augmentation de la vitesse du CPU  
   - C) Optimisation de la bande passante ok 
   - D) Simplification de la configuration des périphériques  ok
   - E) Amélioration du refroidissement du serveur  


### **Linux**

18. Quelle commande permet d’afficher les processus en cours sous Linux ?  
...

19. Comment lister les fichiers d’un répertoire sous Linux ?  
ls

20. Quelle commande Linux permet de modifier les permissions d’un fichier ?  
chmod

21. Comment afficher l’espace disque utilisé sous Linux ?  
lsblk

22. Quel fichier sous Linux stocke les informations des utilisateurs du système ?  
passwd

23. À quoi sert la commande `grep` sous Linux ?  
c'est un filtre

24. Quelle est la différence entre un lien symbolique et un lien dur ?  
...

25. Convertissez en hexadécimal l'adresse IP suivante : **192.168.1.1**  
0xC0 0xA8 0x01 0x01

26. Associez les commandes Linux à leurs fonctions :

   | Commande Linux | Fonction |
   |---------------|----------|
   | `ls`          | affiche contenu du fichier        |
   | `chmod`       | donne les droit       |
   | `df -h`       | ?        |
   | `ps aux`      | ?        |
   | `grep`        | filtre      |
   | `tail -f`     | ?        |


### **Active Directory**

27. Quel est le rôle principal d’Active Directory ?  
Active directory permet de centraliser les services necessaire tel que GPO, OU, utilisateurs,... via un anuaire LDAP

28. Quelle est la fonction des GPO (Group Policy Objects) dans un domaine Active Directory ? 
les GPO permettent de definir les règles de l'infra comme les regles de sécurité, les autorisations de connexion, les fond d'eran, les appli installé,...

29. Quelle commande permet de forcer la synchronisation des GPO sur un poste Windows ?  
gpupdate /force

30. À quoi sert un contrôleur de domaine dans Active Directory ?  
c'est le chef d'orchestre du domaine. c'est lui qui est responsable de l'anuaire

31. Quelle est la commande pour joindre un ordinateur à un domaine Active Directory ?  
...
32. Comment limiter les droits d’un utilisateur sur un poste Windows via Active Directory ?  
via une GPO

### **Scripting et Automatisation (Linux et Windows)**

33. Quelle est la différence entre un script Bash et un script PowerShell ?  
BAsh est un langage utilisé sur linux alors que powershell est pour microsoft

34. Quelle commande permet d’afficher du texte dans un script Bash ?  
echo ""
35. Comment exécuter un script PowerShell sous Windows ?  
via la commande /.ps1

36. Comment définir une variable dans un script Bash ?  
NomdeVariable=variable
et on l'appelle avec $NomdeVariable

37. Quelle est l’utilité des boucles `for` en scripting ?  
ca permet de répété une commande tant qu'une condition n'est pas valid

38. Associez les outils à leurs fonctions :


   | Outil         | Fonction |
   |--------------|----------|
   | Wireshark    | analyse de réseau        |
   | Zabbix       | outils de supervision        |
   | Fail2Ban     | ?        |
   | Metasploit   | outils de supervision         |
   | SIEM         | ?        |
   | SNMP         | permet de surveiller le réseau        |

### **Supervision et Sécurité des Systèmes**

39. Quel outil est couramment utilisé pour la supervision réseau et système ?  
On utilise généralement wireshark pour annalysé le réseau et zabbix pour le système

40. Quelle est la différence entre SNMP v2 et SNMP v3 ?  
snmp v3 et sécurisé

41. Quelle commande sous Linux permet de voir les connexions réseau actives ?  
ip a

42. Quel est le rôle d’un IDS dans un réseau ?  
il permet d'analyser le réseau et de prévénir en cas de faille
43. Qu’est-ce qu’un honeypot et quel est son rôle en cybersécurité ?  

44. Pourquoi utiliser un SIEM dans une infrastructure informatique ?  

45. Quel protocole est utilisé pour chiffrer une connexion SSH ?  

46. Quel est l’avantage de la journalisation des événements système ?  

47. Quelle est l’utilité de Fail2Ban sous Linux ?  

48. Comment analyser un fichier de logs sous Linux ?  

49. Pourquoi surveiller les logs des systèmes et équipements réseau ?  

50. Comment fonctionne un VPN et quels sont ses avantages ?  

### **Divers et Connaissances Avancées**


51. Pourquoi l’authentification multi-facteurs est-elle essentielle en entreprise ?  

52. Quel est le rôle d’un pare-feu de nouvelle génération ?  

53. Comment fonctionne une attaque par déni de service distribué (DDoS) ?  

54. Quels sont les avantages du chiffrement asymétrique par rapport au chiffrement symétrique ?  

55. Pourquoi faut-il éviter les mots de passe trop courts ?  

56. Pourquoi utiliser la redondance dans une infrastructure réseau ?  

57. Pourquoi segmenter un réseau est-il une mesure de sécurité efficace ?  

58. Quels sont les principaux services d’authentification en entreprise ? 

59. Sélectionnez **trois** outils utilisés en cybersécurité :  

   - A) Nmap  
   - B) Excel  
   - C) OpenVAS  
   - D) VLC  
   - E) Burp Suite  


### **Réseau**

60. Quelle commande permet de tester la connectivité entre deux machines sur un réseau ?

61. Quel protocole est utilisé pour l’attribution automatique d’adresses IP ?  

62. Quelles sont les principales différences entre un proxy et un reverse proxy ?  

63. Sélectionnez **deux** technologies permettant d’isoler le trafic réseau :  
   - A) VLAN  
   - B) DMZ  
   - C) NAT  
   - D) ARP  
   - E) DHCP  

64. Quel est le rôle d’un serveur DNS secondaire ?  

65. Pourquoi un réseau Wi-Fi ouvert est-il un risque de sécurité ?  

67. Comment fonctionne une attaque ARP Spoofing ?  

68. Quels sont les **trois** principaux avantages d’IPv6 par rapport à IPv4 ?  

   - A) Plus d’adresses disponibles  
   - B) Sécurité intégrée  
   - C) Plus rapide  
   - D) Meilleur chiffrement  
   - E) Remplace entièrement IPv4  

69. Associez les protocoles aux ports correspondants :  

   | Protocole | Port |
   |-----------|------|
   | SSH       | ?    |
   | SMTP      | ?    |
   | HTTPS     | ?    |
   | RDP       | ?    |
   | DHCP      | ?    |


### **Linux**

70. Quelle commande permet de créer un utilisateur sous Linux ?  

71. Comment modifier le propriétaire d’un fichier sous Linux ?  

72. Quelle est la différence entre `sed` et `awk` sous Linux ?  

73. Sélectionnez **trois** commandes permettant de gérer les processus sous Linux :  
   - A) `top`  
   - B) `kill`  
   - C) `ps`  
   - D) `grep`  
   - E) `chmod`  

74. Quelle commande permet de vérifier l’espace disponible sur une partition Linux ?  

75. Quel fichier contient les tâches planifiées par cron sous Linux ?  

76. Comment afficher les dix premières lignes d’un fichier sous Linux ?  

77. Associez les commandes Linux à leur usage :  

   | Commande | Usage |
   |----------|-------|
   | `mv`     | ?     |
   | `rmdir`  | ?     |
   | `cat`    | ?     |
   | `uptime` | ?     |
   | `echo`   | ?     |

### **Active Directory**

78. Quel est le rôle de l’UAC (User Account Control) dans Windows ?  

79. Comment afficher la liste des utilisateurs d’un domaine Active Directory ?  

80. Quelles sont les **deux** principales différences entre un utilisateur standard et un administrateur de domaine ? 

   - A) Accès à toutes les machines du domaine  
   - B) Accès limité aux fichiers partagés  
   - C) Possibilité de modifier les stratégies de groupe  
   - D) Pas d’accès aux imprimantes réseau  
   - E) Peut modifier les mots de passe des utilisateurs  

81. Quelle est la différence entre un domaine et une forêt dans Active Directory ?  

82. Quelle est la commande PowerShell pour créer un utilisateur Active Directory ?  

83. Associez les rôles Active Directory à leurs fonctions :  

   | Rôle AD | Fonction |
   |---------|----------|
   | DC      | ?        |
   | FSMO    | ?        |
   | OU      | ?        |
   | GPO     | ?        |
   | LDAP    | ?        |


### **Supervision et Sécurité**

84. Quelle solution est utilisée pour détecter des anomalies réseau en temps réel ?  

85. Comment fonctionne une attaque brute force sur un mot de passe ?  

86. Sélectionnez **trois** outils de supervision réseau :  

   - A) Nagios  
   - B) Splunk  
   - C) Zabbix  
   - D) Putty  
   - E) Wireshark  

87. Comment fonctionne un certificat SSL/TLS ?  

88. Quelle est la commande permettant d’analyser l’historique des connexions sous Linux ?  

89. Quel type d’attaque exploite une vulnérabilité dans un service non mis à jour ?  

90. Pourquoi la gestion des logs est-elle essentielle en cybersécurité ?  

91. Quels sont les **deux** moyens de sécuriser un serveur SSH ?  

   - A) Désactiver l’utilisateur root  
   - B) Activer les connexions par mot de passe  
   - C) Utiliser l’authentification par clé  
   - D) Activer le port par défaut  
   - E) Désactiver le protocole TLS  


### **Divers et Connaissances Générales**

92. Quel est le rôle d’un serveur de supervision réseau ?  

93. Quels sont les **trois** types de RAID les plus courants ?  

   - A) RAID 0  
   - B) RAID 1  
   - C) RAID 5  
   - D) RAID 10  
   - E) RAID 50  

94. Qu’est-ce que l’authentification Kerberos ?  

95. Comment fonctionne le Load Balancing ?  

96. Sélectionnez **trois** services cloud couramment utilisés en entreprise :  

   - A) AWS  
   - B) Azure  
   - C) Google Drive  
   - D) Steam  
   - E) OneDrive  

97. Quelle est la différence entre une machine virtuelle et un conteneur Docker ?  

98. Pourquoi est-il recommandé d’utiliser un VLAN pour isoler les services critiques ?  

99. Comment un pare-feu peut-il filtrer le trafic réseau ?  

100. Qu’est-ce qu’une adresse MAC et quel est son rôle ?  
