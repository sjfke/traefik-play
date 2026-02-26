#!/bin/sh

# chmod a+w /dev/pts/0
# exec lighttpd -D -f /etc/lighttpd/lighttpd.conf
exec /sbin/rc-service lighttpd start
