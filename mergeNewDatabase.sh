#!/bin/bash

echo "About to merge master.db and newPush.sb..."

# Example how to run sqlite3 commands from a script
# echo "select * from archive;" > sqlite3Script.sql
# sqlite3 sqlite3database.db < sqlite3Script.sql

# merge master.db + newPush.db = master.db

# create 2 test databases
generator=../data-generator/data_generator.py
master_db=../data-generator/master.db
newPush_db=../data-generator/newPush.db

$generator -p 24 -t 0 $master_db temp sin
$generator -p 24 -t 25 $newPush_db wind square
cp $master_db .
cp $newPush_db .

# Run like this: 
sqlite3 master.db < sqlite3ScriptMerge.sql

echo "Finished merging master.db and newPush.db"
