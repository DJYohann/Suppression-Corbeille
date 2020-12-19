#!/bin/bash

nbRepTotal=0
nbFileTotal=0
nbRep=0
nbFile=0

doc() {
cat << EOF 
Description : Script de suppression dans la corbeille

Utilisation : suppr arg
EOF
}

usage() {
	doc ; exit 0
}

erreur() {
	echo "Erreur : $1" >&2
}

if [ $# -eq 0 ] ; then 
	erreur "Argument manquant\n$0 -help pour aide" ; exit 1
fi 

while [ $# -ne 0 ] ; do 
	if [ "$1" = "-help" ] ; then
		usage
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

if [ "$nbRepTotal" -ne 0 ] && [ "$nbFileTotal" -ne 0 ] ; then 
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