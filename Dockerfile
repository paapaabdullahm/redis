FROM redis:4.0.9

MAINTAINER pam79 <paapaabdullahm@gmail.com>

#COPY redis.conf /usr/local/etc/redis/redis.conf

VOLUME /data

EXPOSE 6379

CMD ["redis-server"]
