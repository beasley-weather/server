#!/bin/bash

# run this command any time to get a report card for what parts are currently active on the server-side
echo "*****Check if the cron jobs are running (backup and server)..."
crontab -l

# more checks ...
echo ""
echo "*****Check if the iwatch is alive to wait for the new database push..."
pgrep iwatch