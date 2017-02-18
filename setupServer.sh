#!/bin/bash

# this scripts turns any computer (running a Debian OS, tested on Ubuntu 16.04)
# connected into the internet into the 
# "Beasley Weather Station Database and Server"

# exit at the first failure
set -e

# install weewx dependencies
sudo apt-get install python-configobj python-cheetah python-serial python-usb

# get weewx from the internet and install it
wget http://weewx.com/downloads/weewx_3.6.2-1_all.deb
mv weewx_3.6.2-1_all.deb ~/Downloads/weewx_3.6.2-1_all.deb 
sudo dpkg -i ~/Downloads/weewx_3.6.2-1_all.deb 

# run weewx
# http://weewx.com/docs/usersguide.htm#Running_as_a_daemon 
# Uncomment the following:
#util/init.d/weewx.debian
#cp util/init.d/weewx.debian /etc/init.d/weewx
#chmod +x /etc/init.d/weewx
#update-rc.d weewx defaults 98
