## Documentation Administrateur de Security Onion

### :one: SOMMAIRE
- [Licence de cette documentation](https://github.com/WildCodeSchool/TSSR-2409-P1-G1-Plateforme-de-surveillance-de-securite/edit/main/INSTALL.md#two-licence-de-cette-documentation)
- [Prérequis techniques](https://github.com/WildCodeSchool/TSSR-2409-P1-G1-Plateforme-de-surveillance-de-securite/edit/main/INSTALL.md#three-pr%C3%A9requis-techniques-)
- [Étapes d'installation et de configuration de Security Onion 2.4](https://github.com/WildCodeSchool/TSSR-2409-P1-G1-Plateforme-de-surveillance-de-securite/edit/main/INSTALL.md#four-%C3%A9tapes-dinstallation-et-de-configuration-de-security-onion-24-)
- [FAQ]()

### :two: Licence de cette documentation
- Cette documentation est sous licence [CC BY 4.0](https://creativecommons.org/licenses/by/4.0/deed.fr)

### :three: Prérequis techniques :

**Security Onion (Standalone) :**
  - CPU architecturex86-64 architecture (standard Intel or AMD 64-bit processors)
  - CPUs : 4
  - RAM : 16 GB
  - Storage : 200 GB (testé avec 100)
  - NICs : 2

### :four: Étapes d'installation et de configuration de Security Onion 2.4 :

#### **A - Téléchargement de l'ISO :**

   - [Accédez au téléchargement](https://docs.securityonion.net/en/2.4/download.html)

#### **B - Vérifier l'intégrité de l'ISO :**

   - En BASH :
	```sha256sum securityonion-2.4.110-20241010.iso```
   - En CMD :
   	```certutil -hashfile securityonion-2.4.110-20241010.iso sha256```
   - En Powershell
	```Get-FileHash -Path "C:\ISO\securityonion-2.4.110-20241010.iso" -Algorithm SHA256```

#### **C - Lancement de l'installation :**

   - Insérer l'ISO dans la machine
   - Booter sur l'ISO

#### **D - Etapes d'installation**

##### :arrow_forward: D.1 - Lors de l'affichage du premier écran, sélectionner la première ligne  
:hourglass: Sans choix de votre part, la première ligne est automatiquement choisie au bout du décompte.
<br>
<img src="https://github.com/WildCodeSchool/TSSR-2409-P1-G1-Plateforme-de-surveillance-de-securite/blob/main/Install_Screen_SecurityOnion/001.png?raw=true" alt="Pictures" width="800" >
<br><br><br>

##### :arrow_forward: D.2 - Taper `yes` lorsque cela vous est demandé
<br>
<img src="https://github.com/WildCodeSchool/TSSR-2409-P1-G1-Plateforme-de-surveillance-de-securite/blob/main/Install_Screen_SecurityOnion/002.png?raw=true" alt="Pictures" width="800" >
<br><br><br>

##### :arrow_forward: D.3 - Renseigner le nom d'utilisateur pour vous connecter à la console  
:pencil2: *Pour notre démo nous utiliserons `admin`*
<br>
<img src="https://github.com/WildCodeSchool/TSSR-2409-P1-G1-Plateforme-de-surveillance-de-securite/blob/main/Install_Screen_SecurityOnion/003.png?raw=true" alt="Pictures" width="800" >
<br><br><br>

##### :arrow_forward: D.4 - Renseigner un mot de passe  
:warning: *Clavier qwerty par défaut*
<br>
<img src="https://github.com/WildCodeSchool/TSSR-2409-P1-G1-Plateforme-de-surveillance-de-securite/blob/main/Install_Screen_SecurityOnion/004.png?raw=true" alt="Pictures" width="800" >
<br><br><br>

##### :arrow_forward: D.5 - Re-valider le mot de passe
<br>
<img src="https://github.com/WildCodeSchool/TSSR-2409-P1-G1-Plateforme-de-surveillance-de-securite/blob/main/Install_Screen_SecurityOnion/005.png?raw=true" alt="Pictures" width="800" >
<br><br><br>

##### :arrow_forward: D.6 - Après plusieurs ligne de défilement, cette écran vous invite à redémarrer en pressant `Entrée`
<br>
<img src="https://github.com/WildCodeSchool/TSSR-2409-P1-G1-Plateforme-de-surveillance-de-securite/blob/main/Install_Screen_SecurityOnion/006.png?raw=true" alt="Pictures" width="800" >
<br><br><br>

##### :arrow_forward: D.7 - A cet écran, taper le nom d'utilisateur rensigner à l'étape 4.3
<br>
<img src="https://github.com/WildCodeSchool/TSSR-2409-P1-G1-Plateforme-de-surveillance-de-securite/blob/main/Install_Screen_SecurityOnion/007.png?raw=true" alt="Pictures" width="800" >
<br><br><br>

##### :arrow_forward: D.8 - Puis votre mot de passe de l'étape 4.4
<br>
<img src="https://github.com/WildCodeSchool/TSSR-2409-P1-G1-Plateforme-de-surveillance-de-securite/blob/main/Install_Screen_SecurityOnion/008.png?raw=true" alt="Pictures" width="800" >
<br><br><br>

##### :arrow_forward: D.9 - Sélectionner `Yes` pour continuer
<br>
<img src="https://github.com/WildCodeSchool/TSSR-2409-P1-G1-Plateforme-de-surveillance-de-securite/blob/main/Install_Screen_SecurityOnion/009.png?raw=true" alt="Pictures" width="800" >
<br><br><br>

##### :arrow_forward: D.10 - Sélectionner `Install` puis `ok`
<br>
<img src="https://github.com/WildCodeSchool/TSSR-2409-P1-G1-Plateforme-de-surveillance-de-securite/blob/main/Install_Screen_SecurityOnion/010.png?raw=true" alt="Pictures" width="800" >
<br><br><br>

##### :arrow_forward: D.11 - Sélectionner la version `STANDALONE` puis `ok`
<br>
<img src="https://github.com/WildCodeSchool/TSSR-2409-P1-G1-Plateforme-de-surveillance-de-securite/blob/main/Install_Screen_SecurityOnion/011.png?raw=true" alt="Pictures" width="800" >
<br><br><br>

##### :arrow_forward: D.12 - Renseigner `AGREE` dans le champ puis `ok`
<br>
<img src="https://github.com/WildCodeSchool/TSSR-2409-P1-G1-Plateforme-de-surveillance-de-securite/blob/main/Install_Screen_SecurityOnion/012.png?raw=true" alt="Pictures" width="800" >
<br><br><br>

##### :arrow_forward: D.13 - Choisir l'option adéquate puis `ok`  
:pencil2: *Dans notre démo nous prenons la version `Standard`*
<br>
<img src="https://github.com/WildCodeSchool/TSSR-2409-P1-G1-Plateforme-de-surveillance-de-securite/blob/main/Install_Screen_SecurityOnion/013.png?raw=true" alt="Pictures" width="800" >
<br><br><br>

##### :arrow_forward: D.14 - Renseigner un nom d'hôte pour le serveur  
:pencil2: *Dans notre démo nous laissons le choix proposé par défaut*
<br>
<img src="https://github.com/WildCodeSchool/TSSR-2409-P1-G1-Plateforme-de-surveillance-de-securite/blob/main/Install_Screen_SecurityOnion/014.png?raw=true" alt="Pictures" width="800" >
<br><br><br>

##### :arrow_forward: D.15 - Si vous avez gardé le choix précédent par défaut, sélectionner `Use Anyway`
<br>
<img src="https://github.com/WildCodeSchool/TSSR-2409-P1-G1-Plateforme-de-surveillance-de-securite/blob/main/Install_Screen_SecurityOnion/015.png?raw=true" alt="Pictures" width="800" >
<br><br><br>

##### :arrow_forward: D.16 - Renseigner une courte desciption de votre noeud puis `ok`  
:pencil2: *Ce renseignement n'est pas obligatoire, il est possible de laisser le champs vide puis `ok`*
<br>
<img src="https://github.com/WildCodeSchool/TSSR-2409-P1-G1-Plateforme-de-surveillance-de-securite/blob/main/Install_Screen_SecurityOnion/016.png?raw=true" alt="Pictures" width="800" >
<br><br><br>

##### :arrow_forward: D.17 - Sélectionner la carte réseau de gestion (celle pour vous connecter au webui) puis `ok`
<br>
<img src="https://github.com/WildCodeSchool/TSSR-2409-P1-G1-Plateforme-de-surveillance-de-securite/blob/main/Install_Screen_SecurityOnion/017.png?raw=true" alt="Pictures" width="800" >
<br><br><br>

##### :arrow_forward: D.18 - Sélectionner `STATIC` afin d'attribuer une adresse IP fixe à la carte de gestion puis `ok`  
:pencil2: *Il est possible de choisir `DHCP` durant une phase de test, mais NON en production.*
<br>
<img src="https://github.com/WildCodeSchool/TSSR-2409-P1-G1-Plateforme-de-surveillance-de-securite/blob/main/Install_Screen_SecurityOnion/018.png?raw=true" alt="Pictures" width="800" >
<br><br><br>

##### :arrow_forward: D.19 - Donner une adresse IP à l'interface de gestion en spécifiant le CIDR puis `ok`
<br>
<img src="https://github.com/WildCodeSchool/TSSR-2409-P1-G1-Plateforme-de-surveillance-de-securite/blob/main/Install_Screen_SecurityOnion/019.png?raw=true" alt="Pictures" width="800" >
<br><br><br>

##### :arrow_forward: D.20 - Spécifier la passerelle puis `ok`
<br>
<img src="https://github.com/WildCodeSchool/TSSR-2409-P1-G1-Plateforme-de-surveillance-de-securite/blob/main/Install_Screen_SecurityOnion/020.png?raw=true" alt="Pictures" width="800" >
<br><br><br>

##### :arrow_forward: D.21 - Spécifier le(s) server(s) DNS (il est possible de garder ceux par défaut) puis `ok`
<br>
<img src="https://github.com/WildCodeSchool/TSSR-2409-P1-G1-Plateforme-de-surveillance-de-securite/blob/main/Install_Screen_SecurityOnion/021.png?raw=true" alt="Pictures" width="800" >
<br><br><br>

##### :arrow_forward: D.22 - Spécifier un domaine de recherche DNS (il est possible de garder celui par défaut) puis `ok`
<br>
<img src="https://github.com/WildCodeSchool/TSSR-2409-P1-G1-Plateforme-de-surveillance-de-securite/blob/main/Install_Screen_SecurityOnion/022.png?raw=true" alt="Pictures" width="800" >
<br><br><br>

##### :arrow_forward: D.23 - Sélectionner l'option adéquate puis `ok`  
:pencil2: Dans notre démo nous prendrons `Direct`
<br>
<img src="https://github.com/WildCodeSchool/TSSR-2409-P1-G1-Plateforme-de-surveillance-de-securite/blob/main/Install_Screen_SecurityOnion/023.png?raw=true" alt="Pictures" width="800" >
<br><br><br>

##### :arrow_forward: D.24 - Sélectionner l'option adéquate puis `ok`  
:pencil2: Dans notre démo ce sera `Yes`)
<br>
<img src="https://github.com/WildCodeSchool/TSSR-2409-P1-G1-Plateforme-de-surveillance-de-securite/blob/main/Install_Screen_SecurityOnion/024.png?raw=true" alt="Pictures" width="800" >
<br><br><br>

##### :arrow_forward: D.25 - Ajouter le(s) différente(s) carte réseaux qui serviront au monitoring avec `barre espace` puis `ok`
<br>
<img src="https://github.com/WildCodeSchool/TSSR-2409-P1-G1-Plateforme-de-surveillance-de-securite/blob/main/Install_Screen_SecurityOnion/025.png?raw=true" alt="Pictures" width="800" >
<br><br><br>

##### :arrow_forward: D.26 - Renseigner une adresse mail qui servira à l'authentification sur la webui puis `ok`
<br>
<img src="https://github.com/WildCodeSchool/TSSR-2409-P1-G1-Plateforme-de-surveillance-de-securite/blob/main/Install_Screen_SecurityOnion/026.png?raw=true" alt="Pictures" width="800" >
<br><br><br>

##### :arrow_forward: D.27 - Taper un mot de passe puis `ok`
<br>
<img src="https://github.com/WildCodeSchool/TSSR-2409-P1-G1-Plateforme-de-surveillance-de-securite/blob/main/Install_Screen_SecurityOnion/027.png?raw=true" alt="Pictures" width="800" >
<br><br><br>

##### :arrow_forward: D.28 - Re-taper votre mot de passe puis `ok`
<br>
<img src="https://github.com/WildCodeSchool/TSSR-2409-P1-G1-Plateforme-de-surveillance-de-securite/blob/main/Install_Screen_SecurityOnion/028.png?raw=true" alt="Pictures" width="800" >
<br><br><br>

##### :arrow_forward: D.29 - Choisir l'option adéquate puis `ok`  
:pencil2: Dans notre démo ce sera `IP` (recommandé))
<br>
<img src="https://github.com/WildCodeSchool/TSSR-2409-P1-G1-Plateforme-de-surveillance-de-securite/blob/main/Install_Screen_SecurityOnion/029.png?raw=true" alt="Pictures" width="800" >
<br><br><br>

##### :arrow_forward: D.30 - Autorisez vous l'accès à la configuration via la webui, choisir `ok`
<br>
<img src="https://github.com/WildCodeSchool/TSSR-2409-P1-G1-Plateforme-de-surveillance-de-securite/blob/main/Install_Screen_SecurityOnion/030.png?raw=true" alt="Pictures" width="800" >
<br><br><br>

##### :arrow_forward: D.31 - Définir une adresse IP autorisée, ou une plage d'adresse en spécifiant le CIDR pour l'accès à la webui.
<br>
<img src="https://github.com/WildCodeSchool/TSSR-2409-P1-G1-Plateforme-de-surveillance-de-securite/blob/main/Install_Screen_SecurityOnion/031.png?raw=true" alt="Pictures" width="800" >
<br><br><br>

##### :arrow_forward: D.32 - Soutenez la communauté en validant `Yes`  
:pencil2: (Cette validation n'est pas obligatoire, dans notre démo nous choisissons `No`)
<br>
<img src="https://github.com/WildCodeSchool/TSSR-2409-P1-G1-Plateforme-de-surveillance-de-securite/blob/main/Install_Screen_SecurityOnion/032.png?raw=true" alt="Pictures" width="800" >
<br><br><br>

##### :arrow_forward: D.33 - Vérifier les informations, si ok appuyer sur `TAB` pour sélectionner `Yes` puis `Entrée`  
:warning: L'installation peut durer près d'une heure suivant votre configuration, ne pas interrompre celle-ci.
<br>
<img src="https://github.com/WildCodeSchool/TSSR-2409-P1-G1-Plateforme-de-surveillance-de-securite/blob/main/Install_Screen_SecurityOnion/033.png?raw=true" alt="Pictures" width="800" >
<br><br><br>

##### :arrow_forward: D.34 - Cette écran s'affiche à la fin de l'installation, il récapitule les informations de connexion, appuyer `TAB` puis `ok`
<br>
<img src="https://github.com/WildCodeSchool/TSSR-2409-P1-G1-Plateforme-de-surveillance-de-securite/blob/main/Install_Screen_SecurityOnion/034.png?raw=true" alt="Pictures" width="800" >
<br><br><br>

##### :arrow_forward: D.35 - Après le redémarrage du serveur, connecter vous avec le nom d'utilisateur de l'étape 4.3
<br>
<img src="https://github.com/WildCodeSchool/TSSR-2409-P1-G1-Plateforme-de-surveillance-de-securite/blob/main/Install_Screen_SecurityOnion/035.png?raw=true" alt="Pictures" width="800" >
<br><br><br>

##### :arrow_forward: D.36 - Puis votre mot de passe de l'étape 4.4
<br>
<img src="https://github.com/WildCodeSchool/TSSR-2409-P1-G1-Plateforme-de-surveillance-de-securite/blob/main/Install_Screen_SecurityOnion/036.png?raw=true" alt="Pictures" width="800" >
<br><br><br>

##### :arrow_forward: D.37 - Si votre connection est valide vous avez l'écran suivant, indiquant l'adresse de connexion de la webui
<br>
<img src="https://github.com/WildCodeSchool/TSSR-2409-P1-G1-Plateforme-de-surveillance-de-securite/blob/main/Install_Screen_SecurityOnion/037.png?raw=true" alt="Pictures" width="800" >
<br><br><br>

---

FAQ_Ressources

Slide 01 - Installer via le premier choix, sinon une installation plus avancéee est nécessaire.  
Slide 10 - Si vous choisissez `Configure Network`, cela configurera uniquement le réseau du serveur.  
Slide 11 - D'autres version sont disponible celon le besoin et le matériel disponible.  
Slide 13 - Le choix `Airgap` permet le déploiement du Security Onion dans un environnement sans accès internet.  
Slide 23 - Le choix `Proxy` est un mode connection alternatif pour le traffic (git, docker, wget, curl ..)  
Slide 29 - D'autres choix de connection au webui sont disponible, tel que `HOSTNAME` si un résolveur de nom est actif.  
Slide 36 - Le message `Hint: Num Lock on` s'affiche si votre pavé numérique est vérrouillé  



