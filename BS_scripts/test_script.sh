#/bin/bash

# bei definition kein $
# ausführen von commands in variable mit $()
DATE=$(date +%T)
DEBUG="[debug]:"
ERROR="[error]:"
TRACE="[trace]:"

# bei aufruf mit $
echo "$DATE $DEBUG Hello there! :3"

# bei fehlerfall wird eigene meldung angezeigt
rm file 2> /dev/null || echo "$DATE $ERROR no removibus this filus!"

# loop like this

for INDEX in 1 2 3 4 5 6 7 8 9 10
do
    DATE=$(date +%T)
    echo "$DATE $TRACE chchchchchchchhcchchchchchchchchchcchchh zum $INDEX ten"
    sleep 1
done

array=(1 2 3)
array[0]=5

echo "array = ${array[@]}"
echo "num elments = ${#array[*]}"
# ausführen in neuer shell
# ; wichtig sonst synthax Fehler
echo "vor (): $DEBUG"
( DEBUG="()"; )
echo "nach () vor {}: $DEBUG"
# ausführen in gleicher shell
{ DEBUG="{}"; }
echo "nach {}: $DEBUG"

exit 1