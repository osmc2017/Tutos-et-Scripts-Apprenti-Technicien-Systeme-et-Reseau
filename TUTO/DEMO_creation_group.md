DEMO SCRIPT CREATION GROUPE
-----------------------------------------------------------------------------------------------------------------------------------------------------------
									CONSIGNE
-----------------------------------------------------------------------------------------------------------------------------------------------------------

Ecrire un script chargé de créer des groupes en prenant comme arguments au lancement du script les noms de groupes à créer

Si aucun arguments n'est entré au lancement du script alors un message invite à relancer le script en donnant des noms de groupes

Pour chaque arguments le script doit vérifier si le groupe existe déjà, auquel cas un message indique l'existence de ce groupe

Pour chaque groupe créé, un message doit indiquer si la création a aboutie ou alors un message si la création n'a pas aboutie

-----------------------------------------------------------------------------------------------------------------------------------------------------------
								   CREATION DU SCRIPT
-----------------------------------------------------------------------------------------------------------------------------------------------------------

> touch createGroup.sh						=> création du fichier
> chmod +x createGroup.sh     ou chmod 774 createGroup.sh	=> on donne les droit exécution au fichier
> export PATH=$PATH:/createGroup.sh				=> permet d'exécuter le script avec PATH
> sudo nano createGroup.sh					=> on édite le script

#!/bin/bash

# Check de la présence d'arguments 				=> énoncé 2
if test $# -eq 0;  (test = []) => if [ $# -eq 0];		=> on vérifie si les argument sont égal à 0
then
	echo "relancez le script en rajoutant des args"		=> on affiche le message indiquant de relancer le script
	exit 1							=> fin du script
fi


# Boucle qui check les noms de groupes (arguments)		=> énoncé 3

for group in "$@";						=> $@ liste les arguments alors que $# qui compte
do 
	if cat /etc/group | grep -q "^$group:";			=> On vérifie en comparant les argument (variable group) avec le dossier group si le groupe existe déjà

	then
		echo "Le groupe $group existe déjà" 		=> On signal si un groupe existe déjà
	else 
		# Création du nouveau groupe
		groupadd $group					=> créé un groupe pour tous les arguments
		
		#check de la création 				=> énoncé 4
		if test $? -eq 0;
		then 						=> si le résultat précédant est egal à 0
			echo "La création de $group à réussi"	=> message confirmant la création du groupe
		else
			echo "La création de $group n'a pas réussi"
		fi
	fi
done

------------------------------------------------------------------------------------------------------------------------------------------------------------
									NOTES et AIDES	
------------------------------------------------------------------------------------------------------------------------------------------------------------

$# vérifie si il y a des arguments (On peut vérifier ce que c'est en faisant echo $#)
Pour lister les groupes et les utilisateurs on peut aller dans /etc/group pour groupe et passwd pour USER avec un CAT^		
la commande groups liste les utilisateurs
pour ne pas afficher la sortie du filtre grep $group on a rajouté &> /dev/null	=> on appel ça le black whole	=> &> indique la sortie 1 et 2
 if grep -q "^$group:" /etc/group; 		=> pas besoin d'utiliser cat de cette facon

groupadd et useradd => pour ajouter un groupe ou un utilisateur	avec un répertoire ////  avec adduser pas de répertoire => pour du système		
$?  => permet de vérifier si la dernière commande à fonctionner => 0 si ok