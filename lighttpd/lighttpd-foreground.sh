#!/bin/sh
set -e

# Lightttpd gets grumpy about PID files pre-existing
pidfile="/var/run/lighttpd.pid"
if [ -f $pidfile ]; then
  rm -f /var/run/lighttpd.pid
fi

exec lighttpd -D -f /etc/lighttpd/lighttpd.conf
