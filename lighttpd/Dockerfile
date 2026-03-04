FROM alpine

RUN /sbin/apk add lighttpd lighttpd-mod_auth && rm -rf /var/cache/apk/*
# lighttpd-doc
# RUN rc-update add lighttpd default

COPY etc/lighttpd/*.conf /etc/lighttpd/
COPY etc/lighttpd/conf.d /etc/lighttpd/conf.d
COPY etc/lighttpd/vhosts.d /etc/lighttpd/vhosts.d
COPY lighttpd-foreground.sh /usr/local/bin/
COPY html/ /var/www/localhost/htdocs/
COPY static/ /var/www/localhost/htdocs/static/
COPY themes/ /var/www/localhost/htdocs/themes/

EXPOSE 80

# CMD ["/usr/local/bin/lighttpd-foreground.sh"]
CMD ["lighttpd-foreground.sh"]
# CMD ["/bin/ash","-c","tail -f /dev/null"]