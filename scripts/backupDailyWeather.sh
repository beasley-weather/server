#!/bin/bash

# setupServer.sh runs this file in a cron job that runs and 12pm (lunch) everyday
# store the diff between master.db and master_24_hours_ago.db into a third database: Weather-Data-24-Hours-MM-DD-YYYY-LAT-LONG.db

# xxx KA in SQLite scripting you can do ".backup %DB% FILE" tp backup a db