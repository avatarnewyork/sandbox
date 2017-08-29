# circleci
Avatar New York's Docker CircleCI Templates

## PreReqs
* Access to circleci
* mysqldump of your project, gzipped to a file called: db.sql.gz 

## CircleCI Instructions
1. create hotfix-circleci branch off maste
2. cd to project dir project
3. `git checkout --track -b hotfix-circleci origin/hotfix-circleci`
4. `git subtree add --squash --prefix=circle git@github.com:avatarnewyork/circleci.git master`
5. `mkdir /data`
6. copy your db dump to the /data dir.  For example, if it was under tmp: `cp /tmp/db.sql.gz [PROJECT_DIR]/data/`
7. Obtain the encruption password and encrypt db: `openssl aes-256-cbc -k "SECRET_PASSWORD_HERE" -in db.sql.gz -out db.sql.gz.enc`
8. `ln -s circle/circle.yml .`
9. `git add -f circle.yml data/db.sql.gz`
10. `git commit -a`
11. `git push origin hotfix-circleci`

### Optional Tests
1. cd to project dir project
2. `mkdir tests`
3. Add your tests to the tests dir and edit `circle.yml` accordingly

### Update to the latest
1. cd to project dir
2. `git subtree pull --squash --prefix=circle git@github.com:avatarnewyork/circleci.git master`


## Variables

### Required
* DEPLOY_STAGE_URL - deployhq autodeploy url

### Required for tests
* GHOST_API_KEY - ghost inspector API Key 
* GHOST_SUITE_ID - ghost inspector suite ID
* NGROK_TOKEN - NGROK Token for tunneling ghost inspector
* DOCKERENV_APACHE_TAG - define the image type (php53, php56, etc).  
* DOCKERENV_MYSQL_TAG - define the image type (mysql55, mysql50, etc).
 
### Optional
* OPENSSL_PASS - decrypts db
* PLATFORM_SCRIPT - if other than drupal.sh - i.e. wordpress.sh


## Files
* /circle.yml - CircleCI configuration
* /bin/deploy.sh - auto deployment to deployhq
* /config/docker-compose.yml - generic dockerenv configuration (should match staging env)
* /config/settings.database.php - generic drupal settings file

### External Files
* ../data/db.sql.gz.enc - this is the encrypted db dump that should reside in your project dir
* ../tests/* - this dir should contain any tests you wish to run

## Test Branches

### Drupal 
* master 

### DeployHQ Only (without tests)
* deployhq_only - no testing, deploy's stage only
