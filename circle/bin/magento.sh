#!/bin/bash

# copy the locale.xml.source file
cp ~/$CIRCLE_PROJECT_REPONAME/circle/config/local.xml.source ~/$CIRCLE_PROJECT_REPONAME/public/app/etc/

# set the media folder to be world writeable
chmod -R 777 ~/$CIRCLE_PROJECT_REPONAME/public/media

# dockerize the local.xml file from locale.xml.source
docker run --rm -i -t --volumes-from config_web_1 --link config_db_1:db_1 docker.io/avatarnewyork/dockerenv-apache:${DOCKERENV_APACHE_TAG} /var/www/circle/bin/dockerize_local.sh

# set the base domain's - add trailing slash
mysql -uadmin --password='admin' -P3366 -h127.0.0.1 -e "update core_config_data set value = 'https://"$CIRCLE_SHA1".ngrok.io/' where path = 'web/secure/base_url';" test
mysql -uadmin --password='admin' -P3366 -h127.0.0.1 -e "update core_config_data set value = 'http://"$CIRCLE_SHA1".ngrok.io/' where path = 'web/unsecure/base_url';" test

# reindex all
~/$CIRCLE_PROJECT_REPONAME/circle/bin/phprun /var/www/html/shell/indexer.php reindexall

# clear cache / sessions
rm -rf ~/$CIRCLE_PROJECT_REPONAME/public/var/cache/*
rm -rf ~/$CIRCLE_PROJECT_REPONAME/var/session/*
