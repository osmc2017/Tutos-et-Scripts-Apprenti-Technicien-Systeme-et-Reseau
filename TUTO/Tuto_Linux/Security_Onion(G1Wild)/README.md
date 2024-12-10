# TSSR-2409-P1-G1-Plateforme-de-surveillance-de-security Onion
[<img src="https://lh3.googleusercontent.com/UazHdVqQ4K1X4EsZAyXgDw9r688Sl73N652uk8Ez2OZGg25qQGXx3qJFFhBl10J1Z2XAprBos4S-qaiBtiKAnA" alt="Pictures" width="100" >](https://www.marmiton.org/recettes/recette_soupe-a-l-oignon_10891.aspx)
 <br><br>

SOMMAIRE

1. [Présentation du projet](#i-présentation-du-projet)
2. [Objectif final](#ii-objectif-final)
3. [Introduction : mise en contexte](#iii-introduction--mise-en-contexte)
4. [Membres du groupe de projet (rôles par sprint)](#iv-membres-du-groupe-de-projet-rôles-par-sprint)
5. [Choix techniques](#V-choix-techniques)
6. [Difficultés rencontrées](#vi-difficultés-rencontrées)
7. [Solutions trouvées et/ou alternatives](#vii-solutions-trouvées-etou-alternatives)
8. [Améliorations possibles : suggestions d'améliorations futures](#viii-améliorations-possibles--suggestions-daméliorations-futures)

<br><br>

  ## I. Présentation du projet: 

 - Le projet consiste à présenter un serveur ( Security Onion ) qui sécurisera le client

  ## II. Objectif final:

 - Bénéficiez d'une visibilité complète sur le réseau et le client afin de détecter toutes intrusions grâce aux outils d’analyse  ( en cours ) 

 ## III. Introduction : mise en contexte

- Création du serveur Security Onion et d'un agent

- Création du ou des clients 

- Sécurisation du Client
#
- La sécurisation du client grâce au serveur est essentielle car il gère des informations sensibles telles que les données utilisateur, la logique métier et les communications avec les bases de données et les API.( Interfaces de Programmation d'Applications ) ou ensembles de règles et de protocoles qui permettent à différentes applications ou systèmes de communiquer entre eux.


## IV. Membres du groupe de projet (rôles par sprint):

      -Scrum Master > Nicolas

        - Product Owner > Freddy

           -Collaborateurs > William et François

## V. Choix techniques

 
### Os d'installation:

* Le SIEM Security Onion 2.4.110 repose sur la distribution Fedora Linux.
* Allocation de ressources pour une installation en standalone:
  * Architecture x86-64 / standard Intel ou processeur AMD 64-bit
  * 4 coeurs
  * 16Go de Ram
  * minimum 100Go d'espace disque (200Go officiellement).
  * 2 cartes réseau

### OS rôle client

Nous avons opté pour les systèmes d'exploitation windows 10 et linux ubuntu pour, dans un premier temps, représenter au maximum la configuration standard de l'utilisateur. 

## VI. Difficultés rencontrées


### Limitations matérielles:

Le premier obstacle se situe au niveau d'allocation de ressources nécessaires pour la stabilité du SIEM.
La version standalone, privilégiée pour bénéficier d'une solution complète, ne peut s'installer sur des configurations standards (de 16Go Ram et inférieur).
Des tests de versionns plus légères n'ont pas abouti aux résultats escomptés.
Généralement l'installation nous notifie d'une allocation de ressources trop faible.

### Configuration réseau:

La configuration réseau a besoin d'être anticipée. Le parcours de l'installation propose plusieurs types de connexions.
Cependant les options à venir en dépendent et ces étapes déterminent la flexibilité avec laquelle peut s'établir la connexion à l'hôte.
De même, c'est à cette étape qu'il est préférable de savoir quels types de machines seront présentes sur le réseau, machines virtuelles ou non et si VM, connexion à la machine hôte ou non.

## VII. Solutions trouvées et/ou alternatives  

### Solution matérielle:

Les tentatives d'installation sur virtualBox n'étant pas concluantes, nous avons opté pour un support d'installation et virtualisation par proxmox.
<p align="center">
<a href="https://www.proxmox.com/en/">
 <img src="https://github.com/WildCodeSchool/TSSR-2409-P1-G1-Plateforme-de-surveillance-de-securite/blob/main/Install_Screen_SecurityOnion/proxmox.png" alt="picture" width="50" >
</p>
Proxmox est un environnement virtuel d'installation qui repose sur l'hypersiveur linux KVM (hyperviseur libre de type 1).

### Solution configuration réseau:

Après plusieurs essais et type de connexions, l'accès par pont semble permettre plus de flexibilité à l'installation et nous a permis de tester la connexion au serveur.

## VIII. Améliorations possibles : suggestions d'améliorations futures

 #### D'autres pistes de configurations réseau ou d'environnements de test seront envisagées lorsque la solution sera plus amplement comprise et stable.
 #### Une documentation plus fournie sur la manipulation de l'interface
 #### Une documentation plus fournie sur la configuration des outils à disposition dans la version Standalone
 #### Une installation de clients et d'agents supplémentaires pour tester l'analyse de données à plus grande échelle et dans des environnements variés.
 
