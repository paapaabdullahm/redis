# **REDIS (REmote DIctionary Server)**
&nbsp;  

>Redis is an open-source, networked, in-memory, key-value data store with optional durability. It is written in ANSI C. The development of Redis is sponsored by Redis Labs today; before that, it was sponsored by Pivotal and VMware. According to the monthly ranking by DB-Engines.com, Redis is the most popular key-value store. The name Redis means REmote DIctionary Server. Visit [**wiki page**](https://en.wikipedia.org/wiki/Redis) on Wikipedia.org.

&nbsp;  
# Example usage

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
