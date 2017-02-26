#!/bin/bash

echo "About to merge master.db and newPush.sb..."

# Example how to run sqlite3 commands from a script
# echo "select * from archive;" > sqlite3Script.sql
# sqlite3 sqlite3database.db < sqlite3Script.sql

# merge master.db + newPush.db = master.db

# create 2 test databases
../data-generator/data_generator.py -p 24 ../data-generator/master.db temp sin
../data-generator/data_generator.py -p 24 ../data-generator/newPush.db wind square
cp ../data-generator/master.db .
cp ../data-generator/newPush.db .

# Run like this: 
sqlite3 master.db < sqlite3ScriptMerge.sql

echo "Finished merging master.db and newPush.db"