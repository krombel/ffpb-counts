#/bin/bash

# for other Skripts
aktChanged=0

[ -d Nodecount ] || mkdir Nodecount
[ -d Clientcount ] || mkdir Clientcount

aktFreifunkNodes=0
maxFreifunkNodes=0
if [ -f Nodecount/maxNodecount.txt ] ; then
	maxFreifunkNodes=`cat Nodecount/maxNodecount.txt`
fi

aktFreifunkClients=0
maxFreifunkClients=0
if [ -f Clientcount/maxClientcount.txt ] ; then
	maxFreifunkClients=`cat Clientcount/maxClientcount.txt`
fi

while true; do
	while ! wget http://map.paderborn.freifunk.net/nodes.json -O nodes.json -q ; do
		echo "nodes.json is not downloadable. Try again in 1 second"; sleep 1; done

	jsonDate=`date -r "nodes.json" +%s`
	tmpCounts=`python calcCounts.py`
	aktFreifunkNodes=`echo $tmpCounts | awk '{print $2}'`
	aktFreifunkClients=`echo $tmpCounts | awk '{print $5}'`
	
	# save aktCounts (for the use in other Skripts)
	echo $aktFreifunkNodes > Nodecount/aktNodecount.txt
	echo $aktFreifunkClients > Clientcount/aktClientcount.txt

	# print generated informations
	echo "`date '+%x, %X' -d @$jsonDate`: Nodecount:   akt: $aktFreifunkNodes; max: $maxFreifunkNodes"
	echo "`date '+%x, %X' -d @$jsonDate`: Clientcount: akt: $aktFreifunkClients; max: $maxFreifunkClients"

	./genNodecount.sh $aktFreifunkNodes > Nodecount/aktNodecount.html
	./genClientcount.sh $aktFreifunkClients > Clientcount/aktClientcount.html

	if [ $aktFreifunkNodes -gt $maxFreifunkNodes ] ; then
		echo "new Nodecount-Highscore: $aktFreifunkNodes"
		cp Nodecount/aktNodecount.html Nodecount/Nodecount.$aktFreifunkNodes.html
		ln -s -f Nodecount.$aktFreifunkNodes.html Nodecount/maxNodecount.html
		maxFreifunkNodes=$((aktFreifunkNodes))
		echo $maxFreifunkNodes > Nodecount/maxNodecount.txt
	fi

	if [ $aktFreifunkClients -gt $maxFreifunkClients ] ; then
		echo "new Client-Highscore: $aktFreifunkClients"
		cp Clientcount/aktClientcount.html Clientcount/Clientcount.$aktFreifunkClients.html
		ln -s -f Clientcount.$aktFreifunkClients.html Clientcount/maxClientcount.html
		maxFreifunkClients=$((aktFreifunkClients))
		echo $maxFreifunkClients > Clientcount/maxClientcount.txt
	fi

	# this value is checked by other Skripts
	if [ $aktChanged -eq 0 ] ; then
		echo 1 > changevalue.txt
		aktChanged=1
	else
		echo 0 > changevalue.txt
		aktChanged=0
	fi
	
	# if you don't want to load the complete Website for this informations, you can use this one.
	echo "Nodecount: akt: $aktFreifunkNodes; max: $maxFreifunkNodes" > tmpCounts.txt
        echo "Clientcount: akt: $aktFreifunkClients; max: $maxFreifunkClients" >> tmpCounts.txt
	echo "Last update: `date '+%d.%m.%Y, %X' -d @$jsonDate`" >> tmpCounts.txt

	## Backup nodes.json
	#[ -d nodes.json.old ] || mkdir nodes.json.old
	#mv nodes.json "nodes.json.old/`date '+%Y%m%d%H%M%S'`.nodes.json"

	# sleep till 3 seconds after the next generation of the file
	updateIntervall=60 # seconds
	aktDate=`date +%s`
	sleep $(($jsonDate-$aktDate+$updateIntervall+3));
done
