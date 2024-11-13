#ENONCE
#------------------------------------------------------------------------------------------------------

#Le script prend en argument un nom de projet
#créer un dossier NomDeProjet. Si le dossier existe déjà, affiche une erreur et sort du script.
#Dans ce dossier créer:
#1 dossier Source
#1 dossier Test
#1 fichier README.txt avec dedans : # nomDeProjet's readme
#Si NomDeProjet n'est pas fourni le nom par defaut sera Project
#Un message précise qu'il n'est pas fourni

#-------------------------------------------------------------------------------------------------------
#					SCRIPT
#-------------------------------------------------------------------------------------------------------

#Variables:
$NomDeProjet = "project"

# On vérifie si le nom est fourni
if ($args)
	{
	$NomDeProjet = $args
	}
else
	{
	Write-Host "Le nom de projet n'a pas été fourni, le nom par défaut sera $NomDeProjet"
	}

# On vérifie si le dossier existe déjà => erreur si il existe
if (-Test-Path -path .\chemin\$NomDeProjet)
	{
	Write-Host "Le projet $NomDeProjet existe déjà"
	exit 1
	}
# Si il n'existe pas on créé les fichiers
else
	{
	New-Item -path .\chemin\$NomDeProjet -ItemType Directory | Out-Null
	New-Item -path .\chemin\$NomDeProjet\Source -ItemType Directory | Out-Null
	New-Item -path .\chemin\$NomDeProjet\Test -ItemType Directory | Out-Null
	New-Item -path .\chemin\$NomDeProjet\README.txt -ItemType "file" -Value "# $NomDeProjet 's readme" | Out-Null
	}