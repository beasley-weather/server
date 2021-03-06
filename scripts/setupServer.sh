#!/bin/bash

# this scripts turns any computer (running a Debian OS, tested on Ubuntu 16.04)
# connected into the internet into the 
# "Beasley Weather Station Database and Server"

SERVER_USER=badger
SERVER_SCRIPTS_DIR=/home/$SERVER_USER/beasley-weather-station/server/scripts
SERVER_ETC_DIR=/home/$SERVER_USER/beasley-weather-station/server/etc
BACKUP_SCRIPT=$SERVER_SCRIPTS_DIR/backupDailyWeather.sh
SERVER_CRON_TAB_FILE=serverCronTabFile.cron

# exit at the first failure
set -e

echo -e "\n"

while true; do
    read -p "Do you wish to setup SERVER as Beasley Weather Staion? [y/n]" yn
    case $yn in
        [Yy]* )
			echo "Continuing with SERVER setup..." 
			break;;
        [Nn]* ) exit;;
        * ) echo "Please answer yes or no.";;
    esac
done

echo -e "\nInstall utilities..."
sudo apt-get install iwatch

echo -e "\nInstall weewx dependencies..."
sudo apt-get install python-configobj python-cheetah python-serial python-usb

# get weewx from the internet and install it
echo -e "\nGoing to download and install weewx, but only if I don't find it in your downloads directory..."
if [ ! -f /home/badger/Downloads/weewx_3.6.2-1_all.deb ];
	then
	wget http://weewx.com/downloads/released_versions/weewx_3.6.2-1_all.deb
    mkdir -p /home/badger/Downloads
	mv weewx_3.6.2-1_all.deb /home/badger/Downloads/weewx_3.6.2-1_all.deb
	sudo dpkg -i /home/badger/Downloads/weewx_3.6.2-1_all.deb
fi

# Configure and run weewx and serve the information from master.db to the public
# http://weewx.com/docs/usersguide.htm#Running_as_a_daemon 
# Uncomment the following:
#util/init.d/weewx.debian
#cp util/init.d/weewx.debian /etc/init.d/weewx
#chmod +x /etc/init.d/weewx
#update-rc.d weewx defaults 98

# 1. create cronjob for the script that backs up the sqlite3 database every 24 hours
# 2. create cronjob for the script that watches (iwatch) the filesystem for new database pushes from the bbg
# ex. * * * * 0-7 date >> ~/projects/date.txt
echo -e "\nSetup cron jobs for backing up data and merging new databases (filesystem watcher)..."
sudo crontab -u $SERVER_USER $SERVER_ETC_DIR/$SERVER_CRON_TAB_FILE

