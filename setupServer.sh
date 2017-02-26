#!/bin/bash

# this scripts turns any computer (running a Debian OS, tested on Ubuntu 16.04)
# connected into the internet into the 
# "Beasley Weather Station Database and Server"

SERVER_SCRIPTS_DIR=/home/kyle/projects/beasley_weather_station/server # the place where we store setupServer.sh and server.sh
BACKUP_SCRIPT=$SERVER_SCRIPTS_DIR/backupDailyWeather.sh
SERVER_SCRIPT=$SERVER_SCRIPTS_DIR/server.sh

# exit at the first failure
set -e

echo "Install utilities..."
sudo apt-get install iwatch

echo "Install weewx dependencies..."
sudo apt-get install python-configobj python-cheetah python-serial python-usb

# get weewx from the internet and install it
echo "Going to download and install weewx, but only if I don't find it in your downloads directory..."
if [ ! -f ~/Downloads/weewx_3.6.2-1_all.deb ];
	then
	wget http://weewx.com/downloads/weewx_3.6.2-1_all.deb
	mv weewx_3.6.2-1_all.deb ~/Downloads/weewx_3.6.2-1_all.deb 
	sudo dpkg -i ~/Downloads/weewx_3.6.2-1_all.deb 
fi

# Configure and run weewx and serve the information from master.db to the public
# http://weewx.com/docs/usersguide.htm#Running_as_a_daemon 
# Uncomment the following:
#util/init.d/weewx.debian
#cp util/init.d/weewx.debian /etc/init.d/weewx
#chmod +x /etc/init.d/weewx
#update-rc.d weewx defaults 98

# xxx KA TODO create crontab file for the user

# 1. create cronjob for the script that backs up the sqlite3 database every 24 hours
# 2. create cronjob for the script that watches (iwatch) the filesystem for new database pushes from the bbg
# ex. * * * * 0-7 date >> ~/projects/date.txt
echo "Setup cron jobs for backing up data and merging new databases (filesystem watcher)..."
crontab -r # remove current/older cron file
#crontab -l > newCronFile                               # store current crontab
#echo "00 12 * * 0-7 $BACKUP_SCRIPT" >> newCronFile     # add new line into the cron file: 1.
#echo "@hourly * * * 0-7 $SERVER_SCRIPT" >> newCronFile # add new line into the cron file: 2.
#crontab newCronFile                                    # install new cron file
#rm newCronFile
crontab serverCronTabFile.cron

