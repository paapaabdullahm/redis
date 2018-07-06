## **REDIS (REmote DIctionary Server)**

Redis is an open-source, networked, in-memory, key-value data store with optional durability. It is written in ANSI C. The development of Redis is sponsored by Redis Labs today; before that, it was sponsored by Pivotal and VMware. According to the monthly ranking by DB-Engines.com, Redis is the most popular key-value store. The name Redis means REmote DIctionary Server. Visit [**wiki page**](https://en.wikipedia.org/wiki/Redis) on Wikipedia.org.

## Example Usage

* #### With docker-compose.yml file

  ```shell
  app:
    image: foo/bar
    container_name: app
  
  redis:
    image: pam79/redis
    container_name: redis
    volumes:
      - chdata:/data
    ports:
      - "6379:6379"
    depends_on:
      - app
    networks:
      - default
  ```

* #### With docker run

  ```shell
  $ docker run --name redis -d pam79/redis
  ```

* #### Docker run with persistent storage

  ```shell
  $ docker run --name redis -d pam79/redis --appendonly yes
  ```

* #### With redis-cli via a .bashrc or .zshrc function

  $ vim .bashrc
  ```shell
  redis-cli() { docker run -it --rm pam79/redis redis-cli "$@"; }
  ```

* #### Use the redis-cli like any other executable

  e.g: Connect to the redis server
  ```shell
  $ redis-cli --link redis -h redis -p 6379
  ```

  e.g: Find redis version
  ```shell
  $ redis-cli --version
  ```

  e.g: Flush the redis database
  ```shell
  $ redis-cli flushall
  ```

  e.g: Getting input from other programs
  ```shell
  $ redis-cli -x set foo < /etc/services
  ```

  e.g: Run in an interactive REPL mode
  ```shell
  $ redis-cli
  127.0.0.1:6379> ping
  PONG
  ```

  e.g: Continuous stats mode to monitor Redis instances in real time
  ```shell
  $ redis-cli --stat
  ```

* #### Have your own redis.conf inside the redis server

  ```shell
  $ docker run --name myredis \
    -v /myredis/redis.conf:/etc/redis/redis.conf \
    pam79/redis /etc/redis/redis.conf
  ```

## IMPORTANT !!

Transparent Huge Pages (THP) is a Linux memory management system that reduces the overhead of Translation Lookaside Buffer (TLB) lookups on machines with large amounts of memory by using larger memory pages.

However, database workloads often perform poorly with THP, because they tend to have sparse rather than contiguous memory access patterns. You should disable THP on Linux machines to ensure best performance with Redis or MongoDB.

## Disable Transparent Huge Pages (THP)

* #### Open rc.local file

  ```shell
  $ sudo vim /etc/rc.local
  ```

* #### Add following content before "exit 0"

  ```shell
  if test -f /sys/kernel/mm/transparent_hugepage/enabled; then
     echo never > /sys/kernel/mm/transparent_hugepage/enabled
  fi
  if test -f /sys/kernel/mm/transparent_hugepage/defrag; then
     echo never > /sys/kernel/mm/transparent_hugepage/defrag
  fi
  ```

* #### Set vm.overcommit_memory = 1

  This is done to avoid the WARNING: "overcommit_memory is set to 0! Background save may fail under low memory condition".

* #### Open sysctl.conf file

  ```shell
  $ sudo vim /etc/sysctl.conf
  ```

* #### Add following content to it

  ```shell
  vm.overcommit_memory = 1
  ```

* #### For this to immediately take effect, run the ff command:

  ```shell
  $ sudo sysctl vm.overcommit_memory=1
  ```
