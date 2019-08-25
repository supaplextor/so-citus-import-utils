#!/bin/bash

db=stackoverflow

for node in `echo claw compute{04,06,10,12,14,16,18,20,22,24}`
do
	createdb -w -h $node -U postgres $db
	echo $?
	psql -w -h $node -U postgres $db -c 'CREATE extension citus;'
	echo $?
	if [ "claw" != "$node" ]
	then
		psql -w -h claw -U postgres $db -c 'SELECT * from create_distributed_table('\'$node\'', '\'5432\'');'
		echo $?
		psql -h claw -U postgres $db -c 'SELECT * from master_add_node('\'$node\'','\'5432\'');'
		echo $?
	fi
done

psql -w -h claw -U postgres $db < create_distributed_table.sql
