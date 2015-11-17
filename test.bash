# --------
# Test #accounts
# --------
# cd ~/clone/accounts && composer install -q && ./vendor/bin/phpunit &&

# --------
# Build & test #ui
# --------
cd ~/clone/ui &&
  export CXX=g++-4.8 &&
  npm install -q -g npm@latest &&
  npm install -q -g bower grunt-cli &&
  npm install -q && bower install -q &&
  gem install -q sass compass guard-livereload &&
  grunt set-env:qa && grunt ngconstant:qa &&
  grunt build && grunt jshint && # grunt test &&
  rm -rf .tmp
