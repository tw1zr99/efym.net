 # hadolint ignore=DL3006
FROM nginx:1.29.0

# NOTE: Remove default configuration and copy efym.net static files
RUN rm -rf /etc/nginx/conf.d/default.conf
COPY public/ /usr/share/nginx/html/
COPY docker/nginx-site.conf /etc/nginx/conf.d/
