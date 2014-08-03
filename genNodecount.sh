#!/bin/bash
if [ "$2." == "." ] ; then
	date=`date +%x\ %X`
else
	date=$2
fi
cat <<EOF
<!DOCTYPE html>
<html>
	<head>
		<title>FFPB NodeCount</title>
		<link rel="stylesheet" type="text/css" href="http://nodecount.paderborn.freifunk.net/nodecount.css">
		<link href='http://fonts.googleapis.com/css?family=Special+Elite|Nova+Square' rel='stylesheet' type='text/css'>
		<meta http-equiv="refresh" content="60">
	</head>
<body>
	<div id="container">
		<div id="nodecount">$(($1))
</div>
		<p>#ffpb Knoten online</p>
		<!--p>Bei 100 gibt's Nussecken f&uuml;r's Team!</p-->
		<p id="timestamp">`date +%x\ %X`</p>
	</div>
</body>
EOF
