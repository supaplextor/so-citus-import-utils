#!/bin/bash
#
#
# This transforms the xml within the 7z archive, via stdio into psql
# and imports it. db need not be "localhost" per a proper pg_hba.conf

set -x

db=stackoverflow
db_host=claw

for ref in badges posthistory postlinks posts tags users votes
do
Ref=$(echo "$ref" | awk '{for (i=1;i<=NF;i++) $i=toupper(substr($i,1,1)) substr($i,2)} 1')

	7z e -so ../stackoverflow/stackoverflow.com-${Ref}.7z |\
	./so-${ref}-xml-to-psql.py |\
	psql -U postgres -h ${db_host} ${db}
done
