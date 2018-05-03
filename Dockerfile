FROM redis:4.0.9

MAINTAINER pam79 <paapaabdullahm@gmail.com>

VOLUME /data

EXPOSE 6379

ENTRYPOINT ["redis-server"]
