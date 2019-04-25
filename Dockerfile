FROM nginx:1-alpine

COPY default.conf /etc/nginx/conf.d/
COPY nginx.conf /etc/nginx/
COPY docker-entrypoint.sh /
RUN chmod +x /docker-entrypoint.sh
ENV CLIENT_MAX_BODY_SIZE 20M

ENTRYPOINT ["/docker-entrypoint.sh"]
CMD ["nginx", "-g", "daemon off;"]
