#!/bin/bash
### BEGIN INIT INFO
# Provides:          pi-b-q passenger in standalone
# Default-Start:     2 3 4 5
# Default-Stop:      0 1 6
# X-Interactive:     true
# Short-Description: Start/stop pi-b-q web site
### END INIT INFO

#PATH=/sbin:/usr/sbin:/bin:/usr/bin

PASSENGER="passenger"
ADDRESS=0.0.0.0
PORT=80
ENVIRONMENT=production
APP_NAME=pi-b-q
APP_DIR="/var/apps/$APP_NAME/current"
USER="pi"
SET_PATH="cd $APP_DIR"
PRE_CMD="" # e.g. "SENDGRID_USERNAME=username"
CMD="$SET_PATH; $PRE_CMD $PASSENGER start -a $ADDRESS -p $PORT -e $ENVIRONMENT -d"

. /lib/lsb/init-functions
. /usr/local/rvm/scripts/rvm

rvm use 2.2.1

case "$1" in
  start)
    echo "Starting $APP_NAME passenger"
    echo "su - $USER -c \"$CMD\""
    su - $USER -c "$CMD"
    ;;
  stop)
    echo "Stopping $APP_NAME passenger"
    cd $APP_DIR
    $PASSENGER stop -p $PORT
    ;;
  restart)
    echo "Restarting $APP_NAME passenger"
    cd $APP_DIR
    $PASSENGER stop -p $PORT

    echo "su - $USER -c \"$CMD\""
    su - $USER -c "$CMD"
    ;;
  *)
    echo "Usage: $0 start|stop" >&2
    exit 3
    ;;
esac