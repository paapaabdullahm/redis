FROM redis:5.0.7-buster
LABEL maintainer="Paapa Abdullah Morgan <paapaabdullahm@gmail.com>"

ENV REDIS_ENV=""

VOLUME /data
WORKDIR /data

EXPOSE 6379

CMD ["redis-server", "/etc/redis/custom.conf"]
