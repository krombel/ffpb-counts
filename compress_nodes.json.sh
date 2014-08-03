#!/bin/bash
tarname="`date +%Y-%m-%d`_nodes.json" 
mv nodes.json.old nodes.json.old2
tar -czvf $tarname.nodes.json.old.tar.gz nodes.json.old2/*
rm nodes.json.old2 -r
