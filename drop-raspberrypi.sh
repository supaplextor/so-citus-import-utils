#!/bin/bash

db=raspberrypi

# x86 worker nodes, 2gb ram, 32gb flash
#for node in `echo claw compute{04,06,10,12,14,16,18,20,22,24,26,28,30}`

# compute207 is offline

# amd64 worker nodes, 32gb ram, 240gb ssd
for node in `echo claw compute{200,201,202,203,204,205,206,208,209,210,211}`

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

