#!/bin/bash
#
#
# This transforms the xml within the 7z archive, via stdio into psql
# and imports it. db need not be "localhost" per a proper pg_hba.conf

set -x

db_host=claw
db=$1
db_=$(echo ${db} | tr . _)

if [ "${db}x" == x ]
then
	echo $0: ERROR: Only one database is required >&2
	exit 1
fi

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
# -rw-r--r-- 1 supaplex supaplex   580515510 May 17  2018 serverfault.com.7z
# -rw-r--r-- 1 supaplex supaplex   633733066 May 17  2018 askubuntu.com.7z
# -rw-r--r-- 1 supaplex supaplex   779895040 May 17  2018 superuser.com.7z
# -rw-r--r-- 1 supaplex supaplex   905215758 May 17  2018 stackoverflow.com-Votes.7z
# -rw-r--r-- 1 supaplex supaplex  1785724694 May 17  2018 math.stackexchange.com.7z
		if [ -e ../stackoverflow/${db}.stackexchange.com.7z ]
		then
			7z e -so ../stackoverflow/${db}.stackexchange.com.7z ${Ref}.xml |\
			./so-${ref}-xml-to-psql.py |\
			psql -U postgres -h ${db_host} ${db_}
		fi
		if [ -e ../stackoverflow/${db}.7z ]
		then
			7z e -so ../stackoverflow/${db}.7z ${Ref}.xml |\
			./so-${ref}-xml-to-psql.py |\
			psql -U postgres -h ${db_host} ${db_}
		fi
	fi
done

