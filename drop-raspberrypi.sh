#!/bin/bash

db=raspberrypi

for node in `echo compute{04,06,10,12,14,16,18,20,22,24,26,28,30}`
do
	(
	psql -h localhost -U postgres $db -c 'SELECT * from master_remove_node('\'$node\'','\'5432\'');'

	psql -h $node -U postgres $db -c '

	SELECT pg_terminate_backend(pg_stat_activity.pid)
	FROM pg_stat_activity
	WHERE pg_stat_activity.datname = '\'$db\''
	  AND pid <> pg_backend_pid();
	  
	'
	dropdb -w -h $node -U postgres $db 
	)&
done
wait

