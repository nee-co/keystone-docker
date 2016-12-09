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
      OS_BOOTSTRAP_SERVICE_NAME: keystone
      OS_BOOTSTRAP_REGION_ID: RegionOne
      OS_BOOTSTRAP_ADMIN_URL: http://keystone:5000/v3
      OS_BOOTSTRAP_PUBLIC_URL: http://keystone:5000/v3
      OS_BOOTSTRAP_INTERNAL_URL: http://keystone:5000/v3
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
