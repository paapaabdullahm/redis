# **REDIS (REmote DIctionary Server)**
&nbsp;  

>Redis is an open-source, networked, in-memory, key-value data store with optional durability. It is written in ANSI C. The development of Redis is sponsored by Redis Labs today; before that, it was sponsored by Pivotal and VMware. According to the monthly ranking by DB-Engines.com, Redis is the most popular key-value store. The name Redis means REmote DIctionary Server. Visit [**wiki page**](https://en.wikipedia.org/wiki/Redis) on Wikipedia.org.

&nbsp;  
# Important Note!

>Transparent Huge Pages (THP) is a Linux memory management system that reduces the overhead of Translation Lookaside Buffer (TLB) lookups on machines with large amounts of memory by using larger memory pages.

>However, database workloads often perform poorly with THP, because they tend to have sparse rather than contiguous memory access patterns. You should disable THP on Linux machines to ensure best performance with Redis or MongoDB.

&nbsp;  
## Disable Transparent Huge Pages (THP)**

**Open rc.local file**

$ sudo vim /etc/rc.local

&nbsp;  
**Add following content before "exit 0"**

```shell

if test -f /sys/kernel/mm/transparent_hugepage/enabled; then
   echo never > /sys/kernel/mm/transparent_hugepage/enabled
fi
if test -f /sys/kernel/mm/transparent_hugepage/defrag; then
   echo never > /sys/kernel/mm/transparent_hugepage/defrag
fi

```
  
&nbsp;  
## Set vm.overcommit_memory = 1

>This is done to avoid the WARNING: "overcommit_memory is set to 0! Background save may fail under low memory condition".

&nbsp;  
**Open sysctl.conf file**

$ sudo vim /etc/sysctl.conf

&nbsp;  
**Add following content to it**

`vm.overcommit_memory = 1`

&nbsp;  
**For this to immediately take effect, run the ff command:**

$ sudo sysctl vm.overcommit_memory=1 
  
&nbsp;  
# Example Usage

&nbsp; 
**with docker run** 

`$ docker run --name some-redis -d redis`

&nbsp;  
**with persistent storage**

`$ docker run --name some-redis -d redis redis-server --appendonly yes`

&nbsp;  
**connect to it from an application**

`$ docker run --name some-app --link some-redis:redis -d application-that-uses-redis`

&nbsp;  
**via redis-cli**

`$ docker run -it --link some-redis:redis --rm redis redis-cli -h redis -p 6379`

&nbsp;  
**want to use your own redis.conf**

```shell
$ docker run -v /myredis/conf/redis.conf:/usr/local/etc/redis/redis.conf \
  --name myredis redis redis-server /usr/local/etc/redis/redis.conf
```

&nbsp;  
**with docker-compose.yml file** 

```shell
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
