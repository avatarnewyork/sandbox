#!/bin/bash

${DOCKERENV_WP_SUBDIR:=""}

export DOCKERENV_WP_SUBDIR

# wordpress db config file
cp ~/$CIRCLE_PROJECT_REPONAME/circle/config/wp-database-settings.php ~/$CIRCLE_PROJECT_REPONAME/public/${DOCKERENV_WP_SUBDIR}

# Create uploads dir with write permission
mkdir -m 777 -p ~/$CIRCLE_PROJECT_REPONAME/public/${DOCKERENV_WP_SUBDIR}wp-content/uploads

# Create cache dir
mkdir -m 777 -p ~/$CIRCLE_PROJECT_REPONAME/public/${DOCKERENV_WP_SUBDIR}wp-content/cache

# Update option siteurl
#docker run  -e "CIRCLE_SHA1=$CIRCLE_SHA1" -e "DOCKERENV_APACHE_TAG=$DOCKERENV_APACHE_TAG" -e "DOCKERENV_WP_SUBDIR=$DOCKERENV_WP_SUBDIR" --user=apache -i -t -w /var/www/ --volumes-from config_web_1 --link config_db_1:db_1  docker.io/avatarnewyork/dockerenv-apache:${DOCKERENV_APACHE_TAG} docker-umask-wrapper.sh /.composer/vendor/wp-cli/wp-cli/bin/wp --skip-plugins --path=/var/www/html/${DOCKERENV_WP_SUBDIR} option update siteurl "http://${CIRCLE_SHA1}.ngrok.io"

# Update option home
#docker run  -e "CIRCLE_SHA1=$CIRCLE_SHA1" -e "DOCKERENV_APACHE_TAG=$DOCKERENV_APACHE_TAG" -e "DOCKERENV_WP_SUBDIR=$DOCKERENV_WP_SUBDIR" --user=apache -i -t -w /var/www/ --volumes-from config_web_1 --link config_db_1:db_1  docker.io/avatarnewyork/dockerenv-apache:${DOCKERENV_APACHE_TAG} docker-umask-wrapper.sh /.composer/vendor/wp-cli/wp-cli/bin/wp --skip-plugins --path=/var/www/html/${DOCKERENV_WP_SUBDIR} option update home "http://${CIRCLE_SHA1}.ngrok.io"

mysql -uadmin --password='admin' -P3366 -h127.0.0.1 -e "update wp_options set option_value = 'https://"$CIRCLE_SHA1".ngrok.io/' where option_name in ('home', 'siteurl');" test

# Update all posts / image sources / links for domain
#docker run  -e "CIRCLE_SHA1=$CIRCLE_SHA1" -e "DOCKERENV_APACHE_TAG=$DOCKERENV_APACHE_TAG" -e "DOCKERENV_WP_SUBDIR=$DOCKERENV_WP_SUBDIR" --user=apache -i -t -w /var/www/ --volumes-from config_web_1 --link config_db_1:db_1  docker.io/avatarnewyork/dockerenv-apache:${DOCKERENV_APACHE_TAG} docker-umask-wrapper.sh /.composer/vendor/wp-cli/wp-cli/bin/wp --skip-plugins --path=/var/www/html/${DOCKERENV_WP_SUBDIR} search-replace --regex ".*.stage.avatarnewyork.com" "${CIRCLE_SHA1}.ngrok.io" wp_posts wp_postmeta wp_terms wp_options --skip-columns=guid
