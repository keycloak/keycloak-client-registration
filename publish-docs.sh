#!/bin/bash

PUBLISH_DIR="publish"

npm run docs
git clone https://github.com/bucharest-gold/keycloak-client-registration.git $PUBLISH_DIR
cd $PUBLISH_DIR
git checkout gh-pages
rsync -r ../docs/* .
git diff --exit-code > /dev/null

if [ $? -gt 0 ]; then
  git add .
  git commit -a -m "Update docs"
  git push origin gh-pages
else
  echo "No changes to publish"
fi

cd ..
rm -rf $PUBLISH_DIR