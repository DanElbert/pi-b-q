#!/bin/bash
### BEGIN INIT INFO
# Provides:          pi-b-q-harvester
# Required-Start:    $remote_fs $syslog
# Required-Stop:     $remote_fs $syslog
# Default-Start:     2 3 4 5
# Default-Stop:      0 1 6
# X-Interactive:     true
# Short-Description: Start/stop pi-b-q harvester daemon
### END INIT INFO

#PATH=/sbin:/usr/sbin:/bin:/usr/bin

HARVESTER="source /usr/local/rvm/scripts/rvm && rvm use 2.2.1 && bundle exec /var/www/pi-b-q/bin/harvester_control"
APP_DIR="/var/www/pi-b-q"
APP_NAME="pi-b-q harvester"
USER="pi"
ENV_FILE=/etc/default/harvester

export RAILS_ENV=production

# Source the env file if it exists
[ -f "$ENV_FILE" ] && . $ENV_FILE

. /lib/lsb/init-functions

case "$1" in
  start)
    echo "Starting $APP_NAME"
    cd $APP_DIR
    su $USER -c "$HARVESTER start"
    ;;
  stop)
    echo "Stopping $APP_NAME"
    cd $APP_DIR
    su $USER -c "$HARVESTER stop"
    ;;
  restart)
    echo "Restarting $APP_NAME"
    cd $APP_DIR
    su $USER -c "$HARVESTER restart"
    ;;
  *)
    echo "Usage: $0 start|stop|restart" >&2
    exit 3
    ;;
esac