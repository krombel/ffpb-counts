for type in Nodecount ; do
	cd ~/freifunk-counts/$type
	for file in $type.*0.html ; do
		echo "`date -r $file "+%d.%m.%y %X"` $type: `echo $file | cut -c 11-13`"
		echo "`date -r $file "+%s"` $type: `echo $file | cut -c 11-13`"
	done
done
