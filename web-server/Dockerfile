# syntax docker/dockerfile:1.2
FROM nginx:latest
# COPY ./site-content/index.html /usr/share/nginx/html/index.html
# COPY ./etc/nginx.conf /etc/nginx/
# remove default.conf
# RUN rm -f /etc/nginx/conf.d/default.conf
COPY ./etc/static.conf /etc/nginx/conf.d/default.conf
COPY html/* /usr/share/nginx/web/
COPY static/* /usr/share/nginx/web/static/
COPY themes/* /usr/share/nginx/web/themes/