source params.bash

# ---------------------
# Caching
# ---------------------
COMPOSER_HOME=${HOME}/cache/composer

mkdir -p ${HOME}/cache/ui/node_modules
mkdir -p ${HOME}/cache/ui/bower_components
mkdir -p ${HOME}/cache/drush

# drush caching
CACHE_PREFIX=${HOME}/cache/drush/ && export CACHE_PREFIX

# npm caching
export PREFIX="${HOME}/cache/npm/"
export PATH="${HOME}/cache/npm/bin/:${PATH}"
npm config set cache "${HOME}/cache/npm/"

# @TODO: gem caching?

# ---------------------
# PHP & Tools
# ---------------------
phpenv local 5.6
export PATH="${HOME}/.composer/vendor/bin:${PATH}"
composer config -g github-oauth.github.com ${GITHUB_OAUTH_TOKEN} &&
  composer global require -q drush/drush:^7.0 &&
  drush --version

git clone -q --depth 1 $MAKE_URL --branch=$MAKE_BRANCH make &&
git clone -q --depth 50 $ACCOUNTS_URL accounts &&
  cd accounts && git checkout $ACCOUNTS_URL_SHA && cd - &&
git clone -q --depth 50 $UI_URL ui &&
  cd accounts && git checkout $UI_URL_SHA && cd - &&
  ln -s ${HOME}/cache/ui/node_modules node_modules &&
  ln -s ${HOME}/cache/ui/bower_components bower_components
git config --global user.email "ci@toila.net"
git config --global user.name "CI"

# --------
# Make drupal code base
# --------
drush make -q --concurrency=12 ~/clone/make/build.make ~/clone/drupal
