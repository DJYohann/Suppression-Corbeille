#!/bin/zsh 

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
	if [ $1 = "-help" ] ; then
		usage
	fi

	nbRep=$(find $1 -exec file  {} \; | grep "directory" | wc -l | tr -d " ")
	nbFile=$(find $1 -exec file  {} \; | grep -v "directory" | wc -l | tr -d " ")

	mv $1 /Users/$USER/.Trash

	shift
done

echo "Suppression effectuée"
echo "Déplacement de $nbRep dossiers et $nbFile fichiers dans la corbeille"

exit 0