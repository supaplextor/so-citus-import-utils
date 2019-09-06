#!/bin/bash

set -x

#db=stackoverflow
db=$1

if [ "${db}x" == x ]
then
	echo $0: ERROR: Only one database is required >&2
	exit 1
fi

# x86 worker nodes, 2gb ram, 32gb flash
#for node in `echo claw compute{04,06,10,12,14,16,18,20,22,24,26,28,30}`

# compute207 is offline

# amd64 worker nodes, 32gb ram, 240gb ssd
for node in `echo claw compute{200,201,202,203,204,205,206,208,209,210,211}`
do
# create the database
	createdb -w -h $node -U postgres $db
	echo $?
# add citus extension to the database
	psql -w -h $node -U postgres $db -c 'CREATE extension citus;'
	echo $?
	if [ "claw" != "$node" ]
	then
# add compute worker node to the distribution list
		psql -h claw -U postgres $db -c 'SELECT * from master_add_node('\'$node\'','\'5432\'');'
		echo $?
	fi
done


psql -h claw -U postgres $db -c 'SELECT * from master_get_active_worker_nodes() order by node_name asc;'

psql -w -h claw -U postgres $db < create_distributed_table.sql
# create tables
# add tables to distribution list

#		psql -w -h claw -U postgres $db -c 'SELECT * from create_distributed_table('\'$node\'', '\'5432\'');'
#		echo $?
