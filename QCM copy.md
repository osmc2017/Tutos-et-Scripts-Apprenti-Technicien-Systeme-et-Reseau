

### **Divers et Connaissances Avancées**


51. Pourquoi l’authentification multi-facteurs est-elle essentielle en entreprise ?  
cela permet de garantir plus de sécurité en doublant l'authentification

52. Quel est le rôle d’un pare-feu de nouvelle génération ?  
Un pare feu permet de bloquer le trafic entrant et sortant et de rediriger les ports. On utilise généralement la méthode du moindre privilèges et on autorise les services et les ports en fonction du besin

53. Comment fonctionne une attaque par déni de service distribué (DDoS) ?  
...

54. Quels sont les avantages du chiffrement asymétrique par rapport au chiffrement symétrique ?  
un chiffrement assymétrique génère deux clés différentes une privée et une publique qui ne peuvent pas fonctionner l'une sans l'autre alors que le symétrique génère la meme clé

55. Pourquoi faut-il éviter les mots de passe trop courts ?  
Ils sont plus facile a déchiffrer car moins de combinaison possible

56. Pourquoi utiliser la redondance dans une infrastructure réseau ?  
La redondance permet d'assurer le QoS et de maintenir le service opérationnel en cas de défaillance.

57. Pourquoi segmenter un réseau est-il une mesure de sécurité efficace ?  
Cela permet de séparer les flux et si un segment (vlan) est corrompu il n'affecte pas les autres.

58. Quels sont les principaux services d’authentification en entreprise ? 

59. Sélectionnez les outils utilisés en cybersécurité :  

   - A) Nmap  ok
   - B) Excel  non
   - C) OpenVAS  ok
   - D) VLC  non
   - E) Burp Suite  ok


### **Réseau**

60. Quelle commande permet de tester la connectivité entre deux machines sur un réseau ?
on utilise le ping

61. Quel protocole est utilisé pour l’attribution automatique d’adresses IP ?  
le DHCP

62. Quelles sont les principales différences entre un proxy et un reverse proxy ?  
...

63. Sélectionnez **deux** technologies permettant d’isoler le trafic réseau :  

   - A) VLAN  oui
   - B) DMZ  oui
   - C) NAT  non
   - D) ARP  non
   - E) DHCP  non

64. Quel est le rôle d’un serveur DNS secondaire ?  
le DNS secondaire permet de garder en cache les donnée du principal et répond à sa place en fonction de la demande. Cela allège donc le principal

65. Pourquoi un réseau Wi-Fi ouvert est-il un risque de sécurité ?  
Car n'importe qui peut se connecter au réseau de l'entreprise et potentiellmeent attaqué tout le réseau

67. Comment fonctionne une attaque ARP Spoofing ?  
...

68. Quels sont les **trois** principaux avantages d’IPv6 par rapport à IPv4 ?  

   - A) Plus d’adresses disponibles  oui
   - B) Sécurité intégrée  non 
   - C) Plus rapide  oui
   - D) Meilleur chiffrement  non
   - E) Remplace entièrement IPv4  oui

69. Associez les protocoles aux ports correspondants :  

   | Protocole | Port |
   |-----------|------|
   | SSH       | 22    |
   | SMTP      | 25    |
   | HTTPS     | 443    |
   | RDP       | 3389    |
   | DHCP      | 67-68    |


### **Linux**

70. Quelle commande permet de créer un utilisateur sous Linux ?  
adduser 

71. Comment modifier le propriétaire d’un fichier sous Linux ?  
en utilisant la commande chmod

72. Quelle est la différence entre `sed` et `awk` sous Linux ?  
...

73. Sélectionnez **trois** commandes permettant de gérer les processus sous Linux :  
   - A) `top`  oui
   - B) `kill`  oui
   - C) `ps`  oui
   - D) `grep`  non
   - E) `chmod`  non

74. Quelle commande permet de vérifier l’espace disponible sur une partition Linux ?  
df -h

75. Quel fichier contient les tâches planifiées par cron sous Linux ?  
crontab

76. Comment afficher les dix premières lignes d’un fichier sous Linux ?  

77. Associez les commandes Linux à leur usage :  

   | Commande | Usage |
   |----------|-------|
   | `mv`     | déplacer ou renommer     |
   | `rmdir`  | supprimer directory     |
   | `cat`    | afficher contenu fichier     |
   | `uptime` | ...     |
   | `echo`   | affiche ce qu'il y a a la suite entre ""     |

### **Active Directory**

78. Quel est le rôle de l’UAC (User Account Control) dans Windows ?  
c'est lui qui gère les utilisateurs

79. Comment afficher la liste des utilisateurs d’un domaine Active Directory ?  
en se allant dans user et computer et en filtrant les utilisateurs

80. Quelles sont les **deux** principales différences entre un utilisateur standard et un administrateur de domaine ? 

   - A) Accès à toutes les machines du domaine  non
   - B) Accès limité aux fichiers partagés  non
   - C) Possibilité de modifier les stratégies de groupe  oui pour l'admin
   - D) Pas d’accès aux imprimantes réseau  non
   - E) Peut modifier les mots de passe des utilisateurs  oui pour l'admin

81. Quelle est la différence entre un domaine et une forêt dans Active Directory ?  
une foret est un ensemble de domaine (si il y en a plusieurs) et un domaine est un ensemble d'arbre

82. Quelle est la commande PowerShell pour créer un utilisateur Active Directory ?  
...

83. Associez les rôles Active Directory à leurs fonctions :  

   | Rôle AD | Fonction |
   |---------|----------|
   | DC      | c'est le chef d'orchestre de l'AD        |
   | FSMO    | c'est les 5 rôle principaux de la gestion de l'AD        |
   | OU      | permet la gestion des utilisateurs et des machines        |
   | GPO     | permet de gérer les policy d'un domaine        |
   | LDAP    | c'est l'annuaire de l'ad        |


### **Supervision et Sécurité**

84. Quelle solution est utilisée pour détecter des anomalies réseau en temps réel ?  
on utilise Wireshark

85. Comment fonctionne une attaque brute force sur un mot de passe ?  
On lance des séries de mdp en suivant un annuaire

86. Sélectionnez **trois** outils de supervision réseau :  

   - A) Nagios  oui
   - B) Splunk  oui
   - C) Zabbix  non
   - D) Putty  non
   - E) Wireshark  oui

87. Comment fonctionne un certificat SSL/TLS ?  
il demande une authentification a la machine qui se connecte.

88. Quelle est la commande permettant d’analyser l’historique des connexions sous Linux ?  
...

89. Quel type d’attaque exploite une vulnérabilité dans un service non mis à jour ?  
un vers ou un virus

90. Pourquoi la gestion des logs est-elle essentielle en cybersécurité ?  
elle permet de surveillez les connexion ou l'activité du réseau et en cas d'anomalie ou de quelque chose d'anormal de s'en rendre compte

91. Quels sont les **deux** moyens de sécuriser un serveur SSH ?  

   - A) Désactiver l’utilisateur root  oui
   - B) Activer les connexions par mot de passe  non
   - C) Utiliser l’authentification par clé  oui
   - D) Activer le port par défaut  non
   - E) Désactiver le protocole TLS  non


### **Divers et Connaissances Générales**

92. Quel est le rôle d’un serveur de supervision réseau ?  
il permet de centraliser les logs

93. Quels sont les **trois** types de RAID les plus courants ?  

   - A) RAID 0  
   - B) RAID 1  oui
   - C) RAID 5  oui
   - D) RAID 10  oui
   - E) RAID 50  

94. Qu’est-ce que l’authentification Kerberos ?  
c'est l'authentification géré par l'AD....

95. Comment fonctionne le Load Balancing ?  
c'est l'équilibrage de réseau; si on connecte deux réseau externe au réseau interne il va permettre d'additionner les capacités des deux réseaux et proposer un meilleur réseau. Il permet également en cas de panne de passer de l'un a l'autre sans affecter la qualité du réseau

96. Sélectionnez **trois** services cloud couramment utilisés en entreprise :  

   - A) AWS  oui
   - B) Azure  oui
   - C) Google Drive  non
   - D) Steam  non
   - E) OneDrive  oui

97. Quelle est la différence entre une machine virtuelle et un conteneur Docker ?  
Une Vm c'est une machine complète qui est virtualisé (OS et les services associé). un conteneur c'est une application qui tourne sur un système sans aucun autre service que le minimum nécessaire pour le faire tourner

98. Pourquoi est-il recommandé d’utiliser un VLAN pour isoler les services critiques ?  
car il n'est pas accessible par les autres vlan du réseau si on le souhaite.

99. Comment un pare-feu peut-il filtrer le trafic réseau ?  
en utilisant des règle de port

100. Qu’est-ce qu’une adresse MAC et quel est son rôle ?  
c'est l'identité d'une carte / périphérique réseau. Il est unique et permet d'identifier une machine sur le réseau