FROM alpine:latest

ARG depends="py-pip mariadb-client-libs"
ARG make_depends="build-base git python-dev libffi-dev linux-headers mariadb-dev openssl-dev"
ARG repository="https://git.openstack.org/openstack/keystone.git"
ARG tag="10.0.0"

WORKDIR /opt/keystone

RUN apk add --no-cache $depends\
 && apk add --no-cache $make_depends\
 && git clone $repository .\
 && git checkout -b $tag refs/tags/$tag\
 && pip install --upgrade pip\
 && pip install .\
 && pip install PyMySQL python-memcached uwsgi "kombu<4.0.0"\
 && mkdir -p /etc/keystone\
 && mv etc/* /etc/keystone/\
 && mv /etc/keystone/keystone.conf.sample /etc/keystone/keystone.conf\
 && sed -i "s/ admin_token_auth / /" /etc/keystone/keystone-paste.ini\
 && apk del --no-cache $make_depends\
 && rm -rf /opt/keystone

ADD docker-entrypoint.sh /usr/local/bin

ENTRYPOINT ["docker-entrypoint.sh"]

CMD uwsgi --socket :35357 --wsgi-file $(which keystone-wsgi-admin)

EXPOSE 5000 35357
