#!/bin/bash

db=stackoverflow

for node in `echo claw compute{04,06,10,12,14,16,18,20,22,24}`
do
# create the database
	createdb -w -h $node -U postgres $db
	echo $?
# add citus extension to the database
	psql -w -h $node -U postgres $db -c 'CREATE extension citus;'
	echo $?
	if [ "claw" != "$node" ]
	then
# add compute worker node to distribution list
		psql -h claw -U postgres $db -c 'SELECT * from master_add_node('\'$node\'','\'5432\'');'
		echo $?
	fi
done

psql -w -h claw -U postgres $db < create_distributed_table.sql
# create tables
# add tables to distribution list

		# psql -w -h claw -U postgres $db -c 'SELECT * from create_distributed_table('\'$node\'', '\'5432\'');'
		# echo $?
