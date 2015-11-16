# ---------------------
# Caching
# ---------------------
COMPOSER_HOME=${HOME}/cache/composer

mkdir -p ${HOME}/cache/drush/ &&
  CACHE_PREFIX=${HOME}/cache/drush/ &&
  export CACHE_PREFIX

# npm
export PREFIX="${HOME}/cache/npm/"
export PATH="${HOME}/cache/npm/bin/:${PATH}"
npm config set cache "${HOME}/cache/npm/"

# ---------------------
# PHP & Tools
# ---------------------
phpenv local 5.6
export PATH="${HOME}/.composer/vendor/bin:${PATH}"
composer config -g github-oauth.github.com ${GITHUB_OAUTH_TOKEN} &&
  composer global require -q drush/drush:^7.0 &&
  drush --version

git clone -q --depth 1 $BUILD_URL build &
git clone -q --depth 1 $MAKE_URL --branch=$MAKE_BRANCH make &
git clone -q --depth 1 $ACCOUNTS_URL accounts &
git clone -q --depth 1 $UI_URL ui &
git config --global user.email "ci@toila.net"
git config --global user.name "CI"

# ---------------------
# Node & tools
# ---------------------
export CXX=g++-4.8

npm install -q -g npm@latest &&
  npm install -q -g bower grunt-cli

# --------
# Build the UI
# --------
cd ~/clone/ui &&
  rm -rf .git &&
  npm install -q &&
  bower install -q &&
  gem install sass compass guard-livereload &&
  grunt set-env:testing &&
  grunt build &&
  rm -rf .tmp &&
  tar -czf ~/clone/ui.tar.gz ./

# --------
# Make drupal code base
# --------
drush make -q --concurrency=12 ~/clone/make/build.make ~/clone/drupal