# circleci
Avatar New York's Docker CircleCI Templates

## Files
* /circle.yml - CircleCI configuration
* /bin/deploy.sh - auto deployment to deployhq
* /tests/config/docker-compose.yml - generic dockerenv configuration (should match staging env)
* /tests/config/settings.database.php - generic drupal settings file
* /tests/data/db.sql.gz - site database dump gzip'd

## Test Branches

### Drupal 
* master - php53/mysql55 - drupal

### DeployHQ Only (without tests)
* deployhq_only - no testing, deploy's stage only
