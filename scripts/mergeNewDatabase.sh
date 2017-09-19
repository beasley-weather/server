#!/bin/bash

echo -e "\nAbout to merge master.db and newPush.sb..."

SERVER_USER=kyle
STATION_ROOT_DIR=/home/$SERVER_USER/beasley-weather-station
WEEWX_CONFIG_FILE_DIR=$STATION_ROOT_DIR/beasley-weather-station
SERVER_SCRIPTS_DIR=$STATION_ROOT_DIR/server/scripts
SERVER_DB_DIR=$STATION_ROOT_DIR/server/db
DATA_GENERATOR_SCRIPT=$STATION_ROOT_DIR/data-generator/data_generator.py

# Example how to run sqlite3 commands from a script
# echo "select * from archive;" > sqlite3Script.sql
# sqlite3 sqlite3database.db < sqlite3Script.sql

# merge master.db + newPush.db = master.db

cd $SERVER_DB_DIR

# create 2 test databases
$DATA_GENERATOR_SCRIPT -p 24 -t 0 ./master.db temp sin
$DATA_GENERATOR_SCRIPT -p 24 -t 25 ./newPush.db wind square

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
sudo cp -v $SERVER_DB_DIR/master.db /var/lib/weewx/weewx.sdb

# use the new weewx.sdb file and generate a new "report" (index.html)
# The [[FTP]] tags in the weewx.conf are setup so that the newly
# generated report is sent straight to the server which dishes out
# the webpages to the public 
# xxx KA there is an issue with this next line!
#sudo wee_reports $WEEWX_CONFIG_FILE_DIR/weewx.conf

echo -e "\nFinished merging master.db and newPush.db"


