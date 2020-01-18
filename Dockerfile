FROM redis:4.0
LABEL maintainer="Paapa Abdullah Morgan <paapaabdullahm@gmail.com>"

ENV REDIS_ENV=""

VOLUME /data
WORKDIR /data

EXPOSE 6379

CMD ["redis-server", "/etc/redis/custom.conf"]
