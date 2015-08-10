#!/bin/bash

curl -H "Content-Type: application/json" -X POST -d '{"payload":{"new_ref":"'$CIRCLE_SHA1'","branch":"'$CIRCLE_BRANCH'","email":"software+circleci@'$CIRCLE_PROJECT_USERNAME'.com","clone_url":"git@github.com:'$CIRCLE_PROJECT_USERNAME'/'$CIRCLE_PROJECT_REPONAME'.git"}}' $DEPLOY_STAGE_URL
