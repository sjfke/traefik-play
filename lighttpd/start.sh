#!/bin/sh
set -e

# Lightttpd gets grumpy about PID files pre-existing
# rm -f /usr/local/apache2/logs/httpd.pid

exec lighttpd -D -f /etc/lighttpd/lighttpd.conf
