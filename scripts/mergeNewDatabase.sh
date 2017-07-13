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

echo -e "\nFinished merging master.db and newPush.db"
