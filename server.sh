#!/bin/bash

# this only needs to be run once and then it dies. 
# Run it every 30 minutes to make sure that the processes it spawns are alive

# once setupServer.sh has been run successfully, this script will: 
# 1. detect new database files in the file system
# 2. merge new.db with master.db http://stackoverflow.com/questions/80801/how-can-i-merge-many-sqlite-databases
# 3. Backup the new 24 hours of data and store it on the other disk
# 4. Run weewx and serve the information from master.db to the public

NEW_DATABASE_FROM_BBG_DIRECTORY=.
MERGE_DATABASE_SCRIPT=mergeNewDatabase.sh

# start iwatch if it is dead
if ! pgrep -x "iwatch"
  then
  	# 1. and 2.
	echo "started iwatch for new database"
	iwatch -c ./$MERGE_DATABASE_SCRIPT -e create $NEW_DATABASE_FROM_BBG_DIRECTORY &
fi
