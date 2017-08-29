#!/bin/bash

# drupal config file
cp ~/$CIRCLE_PROJECT_REPONAME/circle/config/settings.local.php ~/$CIRCLE_PROJECT_REPONAME/web/sites/default/

# Create files dir with write permission
mkdir -m 777 ~/$CIRCLE_PROJECT_REPONAME/web/sites/default/files ~/$CIRCLE_PROJECT_REPONAME/vendor 
sudo chown -R 48:users ~/$CIRCLE_PROJECT_REPONAME/vendor ~/$CIRCLE_PROJECT_REPONAME/web

# Chmod 755
chmod 775 ~/$CIRCLE_PROJECT_REPONAME ~/$CIRCLE_PROJECT_REPONAME/config/sync ~/$CIRCLE_PROJECT_REPONAME/web ~/$CIRCLE_PROJECT_REPONAME/web/modules ~/$CIRCLE_PROJECT_REPONAME/web/themes

# Composer Install
~/$CIRCLE_PROJECT_REPONAME/circle/bin/phprun config -d memory_limit=-1 /usr/bin/composer.phar install --working-dir=/var/www --prefer-source --no-interaction

# Cache Clear
~/$CIRCLE_PROJECT_REPONAME/circle/bin/phprun config -d memory_limit=-1 /var/www/vendor/bin/drush --root=/var/www/web cr all

