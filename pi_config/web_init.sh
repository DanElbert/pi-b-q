#!/bin/bash
### BEGIN INIT INFO
# Provides:          pi-b-q web
# Default-Start:     2 3 4 5
# Default-Stop:      0 1 6
# X-Interactive:     true
# Short-Description: Start/stop pi-b-q web
### END INIT INFO

#PATH=/sbin:/usr/sbin:/bin:/usr/bin

CMD="/var/www/pi-b-q/bin/web_control"
APP_DIR="/var/www/pi-b-q"
RAILS_ENV=production
APP_NAME="pi-b-q web"
USER="pi"
ENV_FILE=/etc/default/pi-b-q

# Source the env file if it exists
[ -f "$ENV_FILE" ] && . $ENV_FILE

. /lib/lsb/init-functions
. /usr/local/rvm/scripts/rvm

rvm use 2.2.1

case "$1" in
  start)
    echo "Starting $APP_NAME"
    echo "su - $USER -c \"$CMD start\""
    cd $APP_DIR
    su - $USER -c "$CMD start"
    ;;
  stop)
    echo "Stopping $APP_NAME"
    cd $APP_DIR
    su - $USER -c "$CMD stop"
    ;;
  restart)
    echo "Restarting $APP_NAME"
    cd $APP_DIR
    su - $USER -c "$CMD restart"
    ;;
  *)
    echo "Usage: $0 start|stop|restart" >&2
    exit 3
    ;;
esac