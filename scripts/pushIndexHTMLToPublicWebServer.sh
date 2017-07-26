#!/bin/bash

#pushIndexHTMLToPublicWebServer.sh

# this script runs on the Beasley Weather Station server and generates the 
# index.html webpage based on the master.db sqlite weather database.
# The index.html is sent to the web server which directly serves the public

SERVER_USER=badger
SERVER_DB_DIR=/home/$SERVER_USER/beasley-weather-station/server/db

# xxx KA please see [[FTP]] in the weewx.conf file for pushing results to remote server.