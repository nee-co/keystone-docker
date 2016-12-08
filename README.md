# keystone-docker

## Build
`docker build -t keystone .`

## Run Keystone via docker-compose
Example docker-compose.yml for Keystone:

```
version: "2"
services:
  keystone:
    image: keystone
    environment:
      OS_BOOTSTRAP_USERNAME: admin
      OS_BOOTSTRAP_PASSWORD: password
      KEYSTONE_DATABASE_CONNECTION: mysql://root:@keystone-database/keystone
      KEYSTONE_CACHE_HOST: keystone-cache:11211
    links:
      - keystone-cache
      - keystone-database
    ports:
      - 5000
      - 35357
    restart: always

  keystone-cache:
    image: memcached

  keystone-database:
    image: mysql
    environment:
      MYSQL_ALLOW_EMPTY_PASSWORD: "yes"
      MYSQL_DATABASE: keystone
```
