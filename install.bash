export CXX=g++-4.8

nvm install 4 &&
  npm install -g npm@latest &&
  npm --version &&
  npm install -g bower grunt-cli &&
  gem --version &&
  gem install sass compass guard-livereload

composer config -g github-oauth.github.com ${GITHUB_OAUTH_TOKEN} &&
  composer global require -q drush/drush:^7.0 &&
  drush --version

git clone -q --depth 5 $BUILD_URL build &
git clone -q --depth 5 $MAKE_URL --branch=$MAKE_BRANCH make &
git clone -q --depth 5 ${ACCOUNTS_URL} accounts &
git clone -q --depth 5 ${UI_URL} ui &

git config --global user.email "ci@toila.net"
git config --global user.name "CI"
