# Installer le rôle AD DS sur Windows Server 2022

Une fois la machine virtuelle Windows Server démarrée (et à jour), on ajoute le rôle **Active Directory Domain Services (AD DS)** à notre serveur en suivant les étapes suivantes :

- Cliquer sur **Ajouter des rôles et fonctionnalités**.
- Choisir **Installation basée sur un rôle ou une fonctionnalité**.
- Sélectionner le serveur sur lequel installer le rôle.
- Sélectionner **Active Directory Domain Services** puis cliquer sur **Ajouter des fonctionnalités** dans la fenêtre contextuelle, puis cliquer sur **Suivant**.
- Passer les options de **Fonctionnalités** et cliquer sur **Suivant**.
- Cliquer sur **Suivant** une nouvelle fois dans la section **AD DS**.
- Cliquer sur **Installer** sans avoir besoin de redémarrer.
- En laissant l’écran ouvert, à la fin du processus, on peut lire **« Configuration requise. Installation réussie sur SERVEUR »** et surtout la ligne **« Promouvoir ce serveur en contrôleur de domaine »**. C’est sur cette phrase qu’il faut cliquer pour convertir le serveur en contrôleur de domaine du réseau. (Si cet écran est manqué, on peut y accéder via le **Gestionnaire de serveur**, en cliquant sur l’icône **« drapeau »** à gauche de **« Gérer »**).
- Cliquer sur **Ajouter une nouvelle forêt** et ajouter un nom de domaine racine (par exemple, **wilders.lan**), puis cliquer sur **Suivant**.
- Dans **Forest functional level** et **Domain functional level**, choisir en fonction des machines qui seront dans le domaine (on choisit **Windows Server 2012 R2** pour cet exercice, car toutes les machines seront récentes). Définir un mot de passe pour **DSRM** (par exemple **Azerty1**), puis cliquer sur **Suivant**.
- Ne pas cocher **Créer une délégation DNS**, puis cliquer sur **Suivant**.
- Vérifier le nom **NETBIOS** du domaine (par exemple, **wilders**), puis cliquer sur **Suivant**.
- Valider l’emplacement de la base de données **AD DS**, des journaux d’historique et de **SYSVOL**, puis cliquer sur **Suivant**.
- Vérifier que tout est correct et cliquer sur **Suivant**.
- Vérifier que les prérequis sont bons, puis cliquer sur **Installer**.

---

# Créer une unité d'organisation (OU)

- Aller dans l'onglet **AD DS**, clic droit sur votre serveur, puis sélectionner **Active Directory Users and Computers**.
- Clic droit sur le nom de domaine, puis choisir **Nouveau** > **Unité d'organisation** et nommer l'organisation (par exemple : **Wilders_students** pour cet exercice), puis cliquer sur **OK**.

---

# Créer un groupe d'utilisateurs

- Aller dans l'onglet **AD DS**, clic droit sur votre serveur, puis sélectionner **Active Directory Users and Computers**.
- Clic droit sur l'unité d'organisation, puis choisir **Nouveau** > **Groupe** et nommer le groupe (par exemple : **Students**), puis cliquer sur **OK**.

---

# Créer un utilisateur au sein du groupe **Students**

- Aller dans l'onglet **AD DS**, clic droit sur votre serveur, puis sélectionner **Active Directory Users and Computers**.
- Clic droit sur l'unité d'organisation, puis choisir **Nouveau** > **Utilisateur**, remplir les informations nécessaires, définir un mot de passe, puis cliquer sur **Terminer**.
- Clic droit sur le nouvel utilisateur, puis choisir **Ajouter au groupe**.
- Choisir la localisation du groupe et entrer le nom du groupe.
