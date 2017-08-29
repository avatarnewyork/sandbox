#!/bin/bash

DOCKERENV_APACHE_TAG=${DOCKERENV_APACHE_TAG:-latest}
DOCKERENV_MYSQL_TAG=${DOCKERENV_MYSQL_TAG:-latest}

if [[ -z "$PLATFORM_SCRIPT" ]]; then PLATFORM_SCRIPT="drupal.sh"; fi;

# Softlink html for drupal8/symfony (web exists, public doesn't)
if [[ -d ~/$CIRCLE_PROJECT_REPONAME/web && ! -d ~/$CIRCLE_PROJECT_REPONAME/public ]]; then
    cd ~/$CIRCLE_PROJECT_REPONAME
    ln -sr web html
fi

# Setup Volume / Mount points
if [ ${PLATFORM_SCRIPT} == 'drupal8.sh' ]; then
    VOLUME_MOUNT="/home/ubuntu/$CIRCLE_PROJECT_REPONAME"
    WEB_ROOT='/var/www'
else
    VOLUME_MOUNT="/home/ubuntu/$CIRCLE_PROJECT_REPONAME/public"
    WEB_ROOT='/var/www/html'
fi
       
   
# Replace variables in the varnish config file

replace_vars() {
  OUTPUT=$(echo $1 | sed -e 's/.source//');
  SOURCE=$1

  eval "cat <<EOF
$(<$SOURCE)
EOF
  " > $OUTPUT
}

replace_vars "/home/ubuntu/$CIRCLE_PROJECT_REPONAME/circle/config/docker-compose.yml.source"
