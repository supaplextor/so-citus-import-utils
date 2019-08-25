#!/bin/bash

set -x

db=stackoverflow

# for ref in badges posthistory postlinks posts tags users votes
for ref in badges
do
Ref=$(echo "$ref" | awk '{for (i=1;i<=NF;i++) $i=toupper(substr($i,1,1)) substr($i,2)} 1')

	7z e -so ../stackoverflow/stackoverflow.com-${Ref}.7z |\
	../stackoverflow_in_pg/python_src/so2pg-${ref}.py |\
	psql -U postgres -h claw ${db}
done
