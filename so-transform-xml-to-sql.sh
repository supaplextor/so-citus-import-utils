#!/bin/sh

/home/supaplex/bin/so2pg-badges.py . > badges.sql
/home/supaplex/bin/so2pg-comments.py . > comments.sql
/home/supaplex/bin/so2pg-posthistory.py . > posthistory.sql
/home/supaplex/bin/so2pg-postlinks.py . > postlinks.sql
/home/supaplex/bin/so2pg-posts.py . > posts.sql
/home/supaplex/bin/so2pg-tags.py . > tags.sql
/home/supaplex/bin/so2pg-users.py . > users.sql
/home/supaplex/bin/so2pg-votes.py . > votes.sql


