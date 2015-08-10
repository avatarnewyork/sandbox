#!/bin/bash

# Replace variables in the varnish config file

replace_vars() {
  OUTPUT=$(echo $1 | sed -e 's/.source//');
  SOURCE=$1

  eval "cat <<EOF
$(<$SOURCE)
EOF
  " > $OUTPUT
}

replace_vars "/home/ubuntu/$CIRCLE_PROJECT_REPONAME/tests/config/docker-compose.yml.source"
