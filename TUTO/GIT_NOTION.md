	GIT/GITHUB NOTION
----------------------------------------------------------------------------------

GIT/GITHUB C'EST QUOI: 
- Git est un système de contrôle de version
- Git t'aide à conserver l'historique de tes fichiers et à fournir des outils pour travailler en équipe sur les mêmes fichiers de manière concurrente
- Github est une plateforme en ligne qui propose des services tels que l'hébergement de code mais c'est aussi un lieu social où tu peux participer à des projets open source, partager et découvrir de nouveaux projets.

UN REPOSITORY/ REPO: Un GitHub Repository est un espace de stockage et de gestion de code source pour un projet donné. C’est l’élément le plus basique de GitHub. Il contient l’ensemble des fichiers, du code source, de la documentation et de tout autre contenu nécessaire pour ce projet.
UN COMMIT: consiste à enregistrer les modifications dans un repo
UN PUSH: consiste à envoyer d'un dépôt local vers un distant
UN PULL: permet de récupérer depuis GITHUB vers local
UNE BRANCH: est une copie d'un MAIN qui peut être modifié sans affecter la MAIN
PULL REQUEST: une demande de modification de la MAIN part une BRANCH
MERGE: une fusion d'une branche avec la principal
FETCH: 

------------------------------------------------------------------------------------
				COMMANDE DE BASE GIT
------------------------------------------------------------------------------------

>git init => permet de transformer un dossier local en projet git local
>git add => permet de placer un fichier dans un répertoire intermédiaire (staging)
git add "nomdufichier" => permet de créer un nouveau fichier
>git commit => permet de réaliser un commit
>git log -p => affiche les modifications
>git remote add origin <remote_url> => permet d'informer le dêpot local qu'il y a un dépôt distant
>git remote -v => permet de vérifier que le local et le distant sont liés
>git push origin main => permet de mettre à jour le dépôt distant sur la branch main
>git pull origin main => permet de récupérer en local les modif de la branche main effectué à distance => équivalent d'un fecth puis d'un merge
>git clone <remote_url> --- => permet de récupérer un projet distant en local => peut également être renommé à la fin
>git status => permet de vérifier ou en ai le dépôt
>git add . => permet de déplacer le travail effectué dans la zone de staging avant de faire des commits officiel
>git branch "nomdelabranche" => permet de créer une nouvelle branche
>git switch "nomdelabranche" => permet de passer su rune autre branch


.gitignore => fichier permettant de dire qu'elle fichier peut être modifié

------------------------------------------------------------------------------------
					CONNEXION EN SSH (linux)
------------------------------------------------------------------------------------
> sudo apt install gh				#instal GitHub CLI
> gh						#vérifier si tout est ok
> gh auth login					#permet de s'authentifier
=> choose GitHub.com
=> choose SSH
=> generate a SSH KEY =>yes
=> Paraphrase => X
=> Webbrowser

