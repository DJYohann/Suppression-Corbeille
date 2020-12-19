#!/bin/bash

nbRepTotal=0
nbFileTotal=0
nbRep=0
nbFile=0

doc() {
cat << EOF 
Description : Script de suppression dans la corbeille

Utilisation : 

suppr arg(s) - déplace dans la corbeille le(s) argument(s) 
suppr -help  - affiche l'aide
EOF
}

if [ $# -eq 0 ] ; then 
	doc ; exit 1
fi 

while [ $# -ne 0 ] ; do 
	if [ "$1" = "-help" ] ; then
		doc ; exit 0
	fi

	if [ -e "$1" ]; then
		nbRep=$(find "$1" -type d | wc -l | tr -d " ")
		nbFile=$(find "$1" -not -type d | wc -l | tr -d " ")
		nbRepTotal=$((nbRepTotal + nbRep))
		nbFileTotal=$((nbFileTotal + nbFile))

		mv "$1" "/Users/$USER/.Trash"
	else 
		echo "$1 n'existe pas"
	fi

	shift
done

if [ "$nbRepTotal" -ne 0 ] || [ "$nbFileTotal" -ne 0 ] ; then 
	echo "Suppression effectuée"

	if [ "$nbRepTotal" -eq 0 ] ; then 
		echo "Déplacement de $nbFile fichier(s) dans la corbeille"
	elif [ "$nbFileTotal" -eq 0 ] ; then 
		echo "Déplacement de $nbRepTotal dossier(s) dans la corbeille"
	else 
		echo "Déplacement de $nbRepTotal dossier(s) et $nbFileTotal fichier(s) dans la corbeille"
	fi 
else 
	echo "Aucune suppression effectuée"
fi

exit 0