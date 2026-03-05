#!/bin/sh
set -e

# Clean up and pre-existing PID files
pidfile="/var/run/lighttpd.pid"
if [ -f $pidfile ]; then
  rm -f /var/run/lighttpd.pid
fi

exec lighttpd -D -f /etc/lighttpd/lighttpd.conf "$@"
