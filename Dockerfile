FROM redis:4.0
LABEL maintainer="Abdullah Morgan paapaabdullahm@gmail.com"

VOLUME /data

EXPOSE 6379

ENTRYPOINT ["redis-server"]
