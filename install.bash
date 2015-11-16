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
