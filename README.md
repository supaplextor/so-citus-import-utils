# so-citus-import-utils

Be sure you have the appropriate citus extension installed. https://github.com/citusdata/citus

Most of this runs on the cordinator (vs worker nodes).  Since the StackOverflow export is so large (even compressed), citus partitions tables over worker nodes to fan out the workload.  An insert query will affect one node, where a select query will aggregate table partitions (sharding actually), into one series of results.  This means the db application only needs to worry about the cordinator node when accessing each distributed database.

Forking https://github.com/badmonster-nc/stackoverflow_in_pg and using shell pipelines (stdin/stdout) vs local files.  Instead of so2pg scripts, these are -xml-to-psql.py scripts.

StackOverflow exports can be downloaded from https://archive.org/download/stackexchange

After citus extensions "make install". I usually clone things in ~/Projects/ or ~/usr/src/.  Unless an elegant solution is available, for the meantime hostnames are hardcoded in scripts.  This lab is just PoC, it's up to you to fix hostnames etc in these examples. This use case is to burn in citus with a real world data set.

The so archive of 7z files should reside in "stackoverflow/" or "../stackoverflow" relative to the "so-citus-import-utils" directory.

```
git clone https://github.com/supaplextor/so-citus-import-utils.git
./import-site math
```
