#! /bin/bash

#ENONCE: création d'un script de svg
#----------------------------------------------------------------------------------------------

#=> le script demande quel fichier l'utilisateur souhaite sauvegarder
#=> SI pas de fichier message d'erreur
#=> le script demande ensuite ou sauvegarder le fichier
#=> le script demande une confirmation
#=> SI le dossier n'existe pas il le créer
#=> le affiche un message quand la sauvegarde est correctement effectué
"=> le script demande si l'user veux sauvegarder un autre dossier

#----------------------------------------------------------------------------------------------
#					EXPLICATION
#---------------------------------------------------------------------------------------------

#> tu veux sauvegarder quel fichier?  ---
#> SI pas de fichier = error on recommence
#> Sinon => ou veux tu sauvegarder? ---
#> Tu es sur? ---
#> Si le dossier n'existe pas le créer
#> Sinon sauvegarder
#> message de confirmation
#> et veux tu recomencer (oui ou non)? ---
#> si réponse fausse on repose la question
#> si oui on reprend
#> Si non fin
#----------------------------------------------------------------------------------------------
#					SCRIPT
#----------------------------------------------------------------------------------------------


# VARIABLES
fichier_svg=""
dossier_svg=""


while true; do
    read -p "Quel fichier souhaitez-vous sauvegarder ? " fichier_svg  				# Quel fichier veux-tu sauvegarder

    if [ -f "$fichier_svg" ]; 
	then
        read -p "Dans quel dossier souhaitez-vous le sauvegarder ? " dossier_svg		#choix du dossier

        	if [ ! -d "$dossier_svg" ]; then
            	mkdir -p "$dossier_svg"								#création du dossier si il n'existe pas
            	echo "Le dossier $dossier_svg a été créé."					#confirmation

        	fi

        cp "$fichier_svg" "$dossier_svg"							#copie du fichier dans le dossier
        echo "Votre sauvegarde est terminée."							#confirmation


        while true; do
            read -p "Voulez-vous continuer (oui ou non) ? " oui_non				#demande de continuer nouvelle variable
            
            if [ "$oui_non" == "non" ]; then							#si non on arrete tout
                echo "Merci, au revoir."
                exit 0

            elif [ "$oui_non" == "oui" ]; then							#si oui on recommence
                echo "Vous allez continuer."
                break

            else
                echo "Il faut répondre par oui ou non."						#si erreur on recommence

            fi

        done

    else
        echo "Votre fichier n'existe pas."							#si fichier n'existe pas on recommence
    fi
done
