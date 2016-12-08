#!/bin/sh

conf_path="/etc/keystone/keystone.conf"

if [ $KEYSTONE_DATABASE_CONNECTION ]
then
    crudini --set $conf_path database connection $KEYSTONE_DATABASE_CONNECTION
fi

if [ $KEYSTONE_CACHE_MEMCACHE_SERVERS ]
then
    crudini --set $conf_path database memcache_servers $KEYSTONE_CACHE_MEMCACHE_SERVERS
fi

keystone-manage db_sync
keystone-manage fernet_setup --keystone-user root --keystone-group root
keystone-manage bootstrap

exec "$@"
