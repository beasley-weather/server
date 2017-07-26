#!/bin/bash

echo -e "\nAbout to merge master.db and newPush.sb..."

# Example how to run sqlite3 commands from a script
# echo "select * from archive;" > sqlite3Script.sql
# sqlite3 sqlite3database.db < sqlite3Script.sql

# merge master.db + newPush.db = master.db

# create 2 test databases
../data-generator/data_generator.py -p 24 -t 0 ./master.db temp sin
../data-generator/data_generator.py -p 24 -t 25 ./newPush.db wind square

# merge two databases using an SQL script
sqlite3 master.db < sqlite3ScriptMerge.sql

# xxx KA look below for where to save the merged database
# This section defines various databases.
#[Databases]
#   
#   # A SQLite database is simply a single file
#   [[archive_sqlite]]
#       database_type = SQLite
#       database_name = weewx.sdb
#AND
## Directory in which the database files are located
#        SQLITE_ROOT = /var/lib/weewx
# move master database to the location specified in weewx.conf
cp -v master.db /var/lib/weewx/weewx.sdb

# use the new weewx.sdb file and generate a new "report" (index.html)
# The [[FTP]] tags in the weewx.conf are setup so that the newly
# generated report is sent straight to the server which dishes out
# the webpages to the public 
wee_reports weewx.conf

echo -e "\nFinished merging master.db and newPush.db"


