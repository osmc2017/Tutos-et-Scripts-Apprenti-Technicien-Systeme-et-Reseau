#!/bin/sh

#	ATELIER SCRIPT DOSSIER

#Si l'utilisateur ne tape aucune info on créé le dossier project avec tout son contenu:

        if [ -z $1 ]
                then
                nomDeProjet="project"
                mkdir project
                mkdir ~/project/src
                mkdir ~/project/test
                touch ~/project/README.md
                echo "# project's readme" >> ~/project/README.md
                echo "le nom n'a pas été fourni, un dossier $nomDeProjet a été créé"

#Si le dossier demandé existe on a un message d'erreur et on quitte le script
        elif [ -d $1 ]
                then
                echo "votre dossier $1 existe déjà"

#Enfin si aucune des conditions du dessus n'est rempli on créer le dossier demandé avec tout le contenu
        else
                mkdir "$1"
                mkdir ~/"$1"/src
                mkdir ~/"$1"/test
                touch ~/"$1"/README.md
                echo "# $1t's readme" >> ~/"$1"/README.md

                echo "votre dossier $1 a bien été créé"
        fi
