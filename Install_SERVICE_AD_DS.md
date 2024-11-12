# Installer le rôle AD DS Windows server 22


Une fois la vm windows server démarré (et à jour) on ajoute le rôle AD DS à notre serveur en suivant les étapes suivantes:

- cliquer sur Add Roles and Features
- chose Role-based or …
- chose your server
- select Active Directory Domain Services and click Add Features dans la fenêtre contextuelle puis cliquer sur Next
- on passe les Features en appuyant sur next
- On clique sur next une nouvelle fois dans la section AD DS 
- et maintenant on clique sur install sans avoir besoin de redémarrer
- En laissant l’écran ouvert, à la fin du processus, on peut lire « Configuration requise. Installation réussie sur SERVEUR » et surtout la ligne « Promouvoir ce serveur en contrôleur de domaine » : c’est sur cette phrase qu’il faut cliquer pour convertir le serveur en contrôleur de domaine du réseau (Si on a raté cet écran, on peut y accéder par le Gestionnaire de serveur, en cliquant sur l’icône « drapeau » à gauche de « Gérer »)
- cliquer sur Add a new Forest et ajouter un nom de domaine root (wilders.lan pour nous) puis on appuie sur next;
- Dans forest functional level et domain functional level on choisi en fonction des machines qui seront dans notre domaine ( on met su Windows serveur 2012 R2 pour l'exercice ) pour nous car on aura que des machines récentes. On défini un MDP pour DSRM (Azerty1 pour nous)et on appuie sur next;
- on ne coche pas create DNS delegation et on next;
- On vérifie notre NETBIOS domain NAme (wilders pour nous) et on next;
- On valide l’emplacement de la base de données AD DS, des journaux d’historique et pour SYSVOL et next;
- On vérifie que tout est ok et next;
- On vérifie que les prérequis sont bon et on install.

-------------------------------------------------------------------------------------------------------------------------------------
# Créer une unité d'organisation 

- Aller dans l'onglet AD DS et clique droit sur votre server puis `Active Directory Users and Computers`
- clique droit sur le nom de domaine puis Nouveau et Organizational Unit et nommé l'organisation (Wilders_students
 dans l'exo)et OK.

---------------------------------------------------------------
# Créer un groupe d'utilisateur

- Aller dans l'onglet AD DS et clique droit sur votre server puis `Active Directory Users and Computers`
- clique droit sur l'unité d'organisation puis Nouveau et Group et nommé le groupe (Students) et OK.

---------------------------------------------------------------
# Créer un utilisateur au sein du groupe students

- Aller dans l'onglet AD DS et clique droit sur votre server puis `Active Directory Users and Computers`
- clique droit sur l'unité d'organisation puis Nouveau et User, remplir les infos nécessaires, indiquer un mdp et finis.
-clique droit sur le nouvel utilisateur puis add to a group;
- choisir la localisation du groups et entrer le nom du group.