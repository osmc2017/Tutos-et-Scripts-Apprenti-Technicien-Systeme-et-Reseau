					ENONCE
---------------------------------------------------------------------------------------------------

un script doit demander à l'utilisateur si il veut un cafe, un the ou un chocolat.
SI il ne veut rien il tape x et le script se termine
Si il veut une des trois boissons il a le message voici votre"boisson" et le script se termine
Si il ne choisi pas ou met autre chose il a le message votre choix n'est pas valide puis retour sur le 1er message

-------------------------------------------------------------------------------------------------
					EXPLICATION
---------------------------------------------------------------------------------------------
étape 1
Question: souhaitez vous un cafe, un the ou un chocolat. SI vous ne souhaitez rien tapez x
Réponse de l'user

etape 2 
si l'utilisateur choisi cafe => voici votre café
et si l'utilisateur choisi the => voici votre thé
et si l'utilisateur choisi chocolat => voici votre chocolat
et si l'utilisateur tape x => Merci aurevoir
ou l'utilisateur se trompe on revient au début

----------------------------------------------------------------------------------------------------
					SCRIPT
----------------------------------------------------------------------------------------------------
#! /bin/bash

#on déclare les variables dans boissons
boissons=("cafe" "the" "chocolat")

#variable vide pour le choix de l'user
choix=""


while [ "$choix" != "x" ]; do													#on debute la boucle avec qui dit si choix n'est pas egale a x fait...								
	read -p "Question: souhaitez vous un cafe, un the ou un chocolat. SI vous ne souhaitez rien tapez x: " choix		#on pose la question à l'utilisateur de rentrer une valeur dans choix

	if [ "$choix" == "x"]; 													#si choix = x alors fin
	then
		echo "Merci au revoir!"

	elif [[ " {$boisson[*]} " == *" $choix "* ]];										#si choix = une des boisssons de la variable alors message de boisson servi
	then
		echo "voici votre $choix"
	else 
		echo "Choix non valide"												#si rien ne correspond la boucle redémarre
fi 

done





