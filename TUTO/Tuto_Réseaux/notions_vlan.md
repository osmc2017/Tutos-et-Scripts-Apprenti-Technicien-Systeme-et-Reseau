Présentation des VLAN et de l'Agrégation dans la Mise en Réseau
1. Introduction aux VLAN
Les VLAN (Virtual Local Area Networks) permettent de segmenter un réseau physique en plusieurs réseaux logiques distincts. Cette technologie est essentielle pour optimiser la gestion des réseaux et améliorer leur sécurité.

Avantages des VLAN :
Isolation des flux : Chaque VLAN fonctionne comme un réseau indépendant, limitant la communication entre eux.
Amélioration de la sécurité : La segmentation empêche les utilisateurs non autorisés d'accéder à des informations sensibles.
Optimisation de la bande passante : Les données sont mieux structurées et acheminées de manière plus efficace.
Flexibilité : Les VLAN permettent de regrouper des utilisateurs répartis sur différents sites physiques sans besoin de modification matérielle.
Fonctionnement des VLAN :
Les VLAN utilisent généralement un protocole tel que 802.1Q pour identifier et marquer les paquets de données avec un identifiant VLAN (VLAN ID). Les commutateurs compatibles sont configurés pour gérer ces identifiants et segmenter le trafic en conséquence.

2. Agrégation dans la Mise en Réseau
L'agrégation dans les réseaux désigne la combinaison de plusieurs liaisons réseau pour former une connexion unique plus rapide et fiable.

Objectifs de l'agrégation :
Augmentation de la bande passante : La somme des liaisons agrégées permet une capacité de transmission accrue.
Tolérance aux pannes : Si une liaison tombe en panne, le trafic est automatiquement réacheminé via les liaisons restantes.
Optimisation de la charge : L'agrégation équilibre le trafic sur plusieurs chemins de communication.
Protocole d'Agrégation :
Un protocole courant pour l'agrégation de liens est le LACP (Link Aggregation Control Protocol), défini par la norme 802.3ad. Il permet de gérer dynamiquement les agrégats en fonction de la disponibilité des liaisons.

Ports Access et Trunk
Access Port :

Chaque port est assigné à un seul VLAN.
Transporte des paquets non tagués envoyés ou reçus depuis les appareils connectés.
Le commutateur tague les paquets en fonction du VLAN du port.
Trunk Port :

Utilisé pour connecter d'autres commutateurs pour la communication inter-switch.
Transporte des paquets tagués appartenant à plusieurs VLAN.
Applique l'isolation des VLAN.