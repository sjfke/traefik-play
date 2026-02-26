FROM alpine

RUN /sbin/apk add lighttpd lighttpd-mod_auth && rm -rf /var/cache/apk/*
# RUN rc-update add lighttpd default

COPY etc/lighttpd/* /etc/lighttpd/
COPY start.sh /usr/local/bin/
COPY html/ /var/www/localhost/htdocs/
COPY static/ /var/www/localhost/htdocs/static/
COPY themes/ /var/www/localhost/htdocs/themes/

EXPOSE 80

# CMD ["/usr/local/bin/start.sh"]
CMD ["start.sh"]
# CMD ["/bin/ash","-c","tail -f /dev/null"]