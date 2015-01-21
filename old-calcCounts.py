#!/usr/bin/python

import json

data = json.load(open('nodes.json','r'))

nodes_count = 0
clients_count = 0

for node in data['nodes']:
	if node['flags']['online'] and not node['flags']['gateway'] and not node['flags']['client']:
		nodes_count += 1
	
for link in data['links']:
	if link['type'] == 'client':
		clients_count += 1

print('nodes.count: {:d} - clients.count: {:d}'.format(nodes_count, clients_count))
