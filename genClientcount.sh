#!/bin/bash
if [ "$2." == "." ] ; then
	date=`date +%x\ %X`
else
	date="$2"
fi
cat <<EOF
<!DOCTYPE html>
<html>
	<head>
		<title>FFPB ClientCount</title>
		<link rel="stylesheet" type="text/css" href="/nodecount.css">
		<link href='http://fonts.googleapis.com/css?family=Special+Elite|Nova+Square' rel='stylesheet' type='text/css'>
		<meta http-equiv="refresh" content="60">
	</head>
<body>
	<div id="container">
		<div id="nodecount">$(($1))
</div>
		<p>#ffpb Clients online</p>
		<p id="timestamp">$date</p>
	</div>
</body>
EOF
