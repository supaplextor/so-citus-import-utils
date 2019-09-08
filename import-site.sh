#!/bin/bash

db=$1
if [ "${db}x" == x ]
then
	echo $0: ERROR: Only one database is required >&2
	exit 1
fi

./citus-dropdb-allnodes.sh $db
./so-createdb-master-and-nodes.sh $db
./soso-xml-pipe-copystdin.sh $db
