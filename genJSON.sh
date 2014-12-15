#!/bin/bash
if [ "$2." == "." ] ; then
	date=`date +%s`
else
	date="$2"
fi
cat <<EOF
{
	"count" : $(($1)),
	"timestamp" : $date
}
EOF
