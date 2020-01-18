## **REDIS (REmote DIctionary Server)**

Redis is an open-source, networked, in-memory, key-value data store with optional durability. It is written in ANSI C. The development of Redis is sponsored by Redis Labs today; before that, it was sponsored by Pivotal and VMware. According to the monthly ranking by DB-Engines.com, Redis is the most popular key-value store. The name Redis means REmote DIctionary Server. Visit [**wiki page**](https://en.wikipedia.org/wiki/Redis) on Wikipedia.org.

## Example Usage

#### With docker-compose.yml file

```sh
version: '3.7'

services:

  app-svc:
    image: node:latest
    container_name: app-svc
    ports:
      - "8000:8000"
    networks:
      - app-tier
      - cache-tier
    restart: always

  cache-svc:
    image: pam79/redis:v5.0.7
    container_name: cache-svc
    volumes:
      - type: bind
        source: ./redis.conf
        target: /etc/redis/custom.conf
      - type: volume
        source: chdata
        target: /data
    environment:
      - REDIS_ENV=dev
    ports:
      - "6379:6379"
    networks:
      - cache-tier
    restart: always

volumes:

  chdata:

networks:

  app-tier:
  
  cache-tier:
  ```

#### With docker run

```sh
$ docker run --name redis -d pam79/redis
```

#### With redis-cli via a .bashrc or .zshrc function

$ vim .bashrc
```sh
redis-cli() { docker run -it --rm pam79/redis redis-cli "$@"; }
```

#### Use the redis-cli like any other executable

Connect to the redis server
```sh
$ redis-cli --link redis -h redis -p 6379
```

Find redis cli version
```sh
$ redis-cli --version
```

Flush the redis database
```sh
$ redis-cli flushall
```

Getting input from other programs
```sh
$ redis-cli -x set foo < /etc/services
```

Run in an interactive REPL mode
```sh
$ redis-cli
127.0.0.1:6379> ping
PONG
```

Continuous stats mode to monitor Redis instances in real time
```sh
$ redis-cli --stat
```

#### Have your own redis.conf inside the redis server

```sh
$ docker run --name redis \
  -v ./redis.conf:/etc/redis/custom.conf \
  pam79/redis /etc/redis/custom.conf
```

## Important Note

Transparent Huge Pages (THP) is a Linux memory management system that reduces the overhead of Translation Lookaside Buffer (TLB) lookups on machines with large amounts of memory by using larger memory pages.

However, database workloads often perform poorly with THP, because they tend to have sparse rather than contiguous memory access patterns. You should disable THP on Linux machines to ensure best performance with Redis or MongoDB.

## Disable Transparent Huge Pages (THP)

#### Open rc.local file

```sh
$ sudo vim /etc/rc.local
```

#### Add following content before "exit 0"

```sh
if test -f /sys/kernel/mm/transparent_hugepage/enabled; then
  echo never > /sys/kernel/mm/transparent_hugepage/enabled
fi
if test -f /sys/kernel/mm/transparent_hugepage/defrag; then
  echo never > /sys/kernel/mm/transparent_hugepage/defrag
fi
```

#### Set vm.overcommit_memory = 1

This is done to avoid the WARNING: "overcommit_memory is set to 0! Background save may fail under low memory condition".

#### Open sysctl.conf file

```sh
$ sudo vim /etc/sysctl.conf
```

#### Add following content to it

```sh
vm.overcommit_memory = 1
```

#### For this to immediately take effect, run the ff command:

```sh
$ sudo sysctl vm.overcommit_memory=1
```
