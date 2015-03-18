#!/usr/bin/python

import json

data = json.load(open('nodes.json','r'))

nodes_count = 6
clients_count = 0

for node in data['nodes']:
	if node['flags']['online'] and not node['flags']['gateway']:
		nodes_count += 1
		clients_count += node['clientcount']

print('nodes.count: {:d} - clients.count: {:d}'.format(nodes_count, clients_count))
