#!/bin/bash
##
## Start up script for httpd on CentOS docker container
##

## Initialise any variables being called:
# Set the correct timezone
TZ=${TZ:-UTC}
USER=$USER
UID=$UID
setup=/config/httpd/.setup

if [ ! -f "${setup}" ]; then
  rm -f /etc/localtime
  cp /usr/share/zoneinfo/$TZ /etc/localtime
  adduser -u $UID $USER
  sed -i "s/user=/user=$USER/g" /etc/supervisord.d/couchpotato.ini
  touch $setup
fi

## Start up httpd daemon via supervisord
/usr/bin/supervisord -n -c /etc/supervisord.conf
