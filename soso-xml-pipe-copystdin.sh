#!/bin/bash
#
#
# This transforms the xml within the 7z archive, via stdio into psql
# and imports it. db need not be "localhost" per a proper pg_hba.conf

set -x

#	 		 ../stackoverflow/raspberrypi.stackexchange.com.7z
#db=stackoverflow

db=raspberrypi
db_host=claw

for Ref in Badges PostHistory PostLinks Posts Tags Users Votes
do
ref=$(echo "$Ref" | awk '{print tolower($0)}' )

	if [ "${db}" == "stackoverflow" ]
	then
		7z e -so ../stackoverflow/stackoverflow.com-${Ref}.7z |\
		./so-${ref}-xml-to-psql.py |\
		psql -U postgres -h ${db_host} ${db}
	else
#	 		 ../stackoverflow/raspberrypi.stackexchange.com.7z
		7z e -so ../stackoverflow/${db}.stackexchange.com.7z ${Ref}.xml |\
		./so-${ref}-xml-to-psql.py |\
		psql -U postgres -h ${db_host} ${db}
	fi
done
