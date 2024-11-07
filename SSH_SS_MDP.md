# DEMO SSH AVEC IDENTIFICATION AUTO
## UBUNTU -> UBUNTU


ON EXECUTE TERMINAL SUR LES DEUX MACHINES

- On vérifie qu'on a openssh serveur sur le client:
`sshd -V`                                  (*Pour vérifier si installé, si pas installer:*)

`sudo apt install openssh-server`

`sshd -V`								        (*Pour vérifier*)

`systemctl status ssh`							(*Si pas activé:*)

`systemctl enable ssh`							(*Rend actif au démarrage*)

`systemctl status ssh`

`systemctl status sshd`							(*Si tout est bon tout est vert et enable*)


- On met sur le même réseaux ip (VM en pont) et on redémarre le service 
`sudo systemctl restart Networking (ou NetworkManager)`

`ip a`									        (*Pour récupérer IP*)

`ping (adresse ip)`							    (*On vérifie si la communication est ok*)


- On se connecte depuis le serveur pour vérifier que tout est ok:
`ssh client@ip`							    (*On dit oui et on tape le mdp*)

`exit`


- On créé une clé ssh:
`ssh-keygen -t ecdsa`

`yes`

`passphrase pas obligé` 

`ls -a`								        (*Pour vérifier le fichier .ssh =>lieu de stockage de la clé ssh*)

- On déploie la clé ssh publique depuis le serveur vers le client:
`ssh-copy-id -i /home/user/.ssh/id_ecdsa.pub client@ip`

`on rentre le mdp` 							      (*Si tout est ok on se connecte*)


- On vérifie que la clé correspond sur les machines:
`cat /home/wcs/.ssh/id_ecdsa.pub`					(*Sur le serveur*)

`cat .ssh/auhorized-keys` 						    (*Sur le client*)


- On se connecte:
`ssh client@ip`							        (*SI tout est ok on entre pas de MDP*)

---
## WINDOWS -> WINDOWS


ON EXECUTE POWERSHELL EN ADMIN SUR LES DEUX MACHINES =`toujours un mdp sur le client pour ssh ok sur windows


- On vérifie les services clients: 

`get-service ssh-agent`


- On active la fonctionnalité client-ssh sur nos machines:

=>système =>fonctionnalités facultatives =`on vérifie client ssh


- On vérifie la fonctionnalité serveur-ssh sur le client

=>système.... =>ajouter une fonctionnalité =`serveur OpenSSH

- On vérifie le service sur le client avec

`get-service sshd`						(*Si pas activé:*)

`get-service sshd | Set-Service -StartupType automatic`			(*Puis on démarre:*)

`Restart-Service sshd`							(*On vérifie:*)

`get-service sshd`							(*Si tout est ok running*)


- On met sur le même réseaux ip (VM en pont) 
`ipconfig`								(*On récupère l'IP du client*)


- On test la connection SSH depuis le serveur:
`ssh client@ip powershell`					(*Si tout est bon on entre le MDP =>on précise PowerShell*)

`exit`

-sur le serveur, on créé la clef SSH:
`ssh-keygen -t ecdsa`							(*On va vérifier ou est la clé et si tout est ok:*)

`Set-Location c:\Users\client\.ssh\`

`get ChildItem`							(*On vérifie la clé*)


- On déploie la clé ssh publique depuis le serveur vers le client:
`On va la copier directement dans le fichier source:`

`get-content -path .\.ssh\id_ecdsa.pub	`				(*On copie*)

`ssh client@ip	`						(*On se connecte en ssh au client*)

`add-content -path .ssh\authorized_keys -value "la clé"`		(*On va vérifier dans le fichier du client*)


- On va dans programme data sur le client:

`C:\ProgramData\ssh\sshd_config`               			(*élément masqué dans affichage classique*)

`On commente la ligne MATCH group administrator`			(*On save et on redémarre le service:*)

`Restart-Service sshd`


- On se connecte en ssh et normalement pas de MDP:
`ssh client@ip`

---
## UBUNTU -> WINDOWS


ON EXCECUTE TERMINAL ET POWERSHELL EN ADMIN SUR LES MACHINES RESPECTIVES
=>Même vérification pour Openssh que précédemment


- On vérifie si on peut se connecter en ssh 
`ssh client@ip powershell`						(*Si tout est ok on quitte*)

`exit`


- On déploie la clé depuis ubuntu vers windows
`cat .ssh/idecdsa.pub`							(*On copie*)
`ssh client@ip`								(*On se connecte en ssh au client*)

`add-content -path .ssh\authorized_keys -value "la clé"`		(*On colle*)


- On va dans programme data sur le client:
`C:\ProgramData\ssh\sshd_config`					(*Elément masqué dans affichage classique*)

`On commente la ligne MATCH group administrator`			(*On save et on redémarre le service:*)

`Restart-Service sshd`


- On se connecte en ssh et normalement pas de MDP:
`ssh client@ip`

---
## WINDOWS -> UBUNTU


ON EXCECUTE TERMINAL ET POWERSHELL EN ADMIN SUR LES MACHINES RESPECTIVES
=>Même vérification pour Openssh que précédemment


- On vérifie si on peut se connecter en ssh 
`ssh client@ip` 							(*Si tout est ok on quitte*)
`exit`


- On déploie la clé depuis Windows vers Ubuntu
`get-content -path .\.ssh\id_ecdsa.pub`				(*On copie*)
`ssh client@ip`								(*On se connecte en ssh au client*)

`nano .ssh/authorized_keys	`					(*On colle*)


- On se connecte en ssh et normalement pas de MDP:
`ssh client@ip`
