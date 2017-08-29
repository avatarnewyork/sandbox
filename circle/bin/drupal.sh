#!/bin/bash

# drupal config file
cp ~/$CIRCLE_PROJECT_REPONAME/circle/config/settings.database.php ~/$CIRCLE_PROJECT_REPONAME/public/sites/default/

# Create files dir with write permission
mkdir -m 777 ~/$CIRCLE_PROJECT_REPONAME/public/sites/default/files

# (optional) run drush update db to all - uncomment below
# ~/$CIRCLE_PROJECT_REPONAME/circle/bin/phprun -t ${DOCKERENV_APACHE_TAG} config /usr/share/pear/drush/drush.php -y -r /var/www/html updatedb
