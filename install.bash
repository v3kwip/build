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

git clone -q --depth 5 $BUILD_URL build &
git clone -q --depth 5 $MAKE_URL --branch=$MAKE_BRANCH make &
git clone -q --depth 5 ${ACCOUNTS_URL} accounts &
git clone -q --depth 5 ${UI_URL} ui &

git config --global user.email "ci@toila.net"
git config --global user.name "CI"

# ---------------------
# Node & tools
# ---------------------
export CXX=g++-4.8
nvm use 4 &&
  npm install -g npm@latest &&
  npm --version &&
  npm install -g bower grunt-cli &&
  gem --version &&
  gem install sass compass guard-livereload
