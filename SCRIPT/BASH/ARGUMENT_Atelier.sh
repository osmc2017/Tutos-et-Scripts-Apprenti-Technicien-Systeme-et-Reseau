#!/bin/bash

	#ATELIER ARG

# On vérifie le 1er argument

if [ $1 != "+" -a $1 != "-" ]
then
	echo "Vous devez entrer un operateur (+ ou -)"
exit 1
fi


# Test de verification des 2eme et 3eme du script

if [[ $2 -lt 0 || $2 -gt 10 || $3 -lt 0 || $3 -gt 10 ]]
then 
	echo "Vous n'avez pas rentrer de chiffre en 2eme et 3eme argument"
exit 1
fi


# Fonction qui fait les additions

addition()
        {
        resultat=$(($1 + $2));
        echo "l'addition de vos arguments est = $resultat";
        }


# Fonction qui fait les soustractions

soustraction()
        {
        resultat=$(($1 - $2));
        echo "la soustraction de vox arguments est = $resultat";
	if [ $resultat -lt 0 ]
	then
		echo "votre resultat est négatif
	fi
        }


# Test de vérification du + ou - sur arg1

if [ $1= "+" ]
        then
        addition $2 $3

elif [ $1="-" ]
        then
        soustraction $2 $3

if 
