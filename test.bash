# --------
# Test #accounts
# --------
cd ~/clone/accounts &&
  composer install &&
  ./vendor/bin/phpunit &&

# --------
# Test #ui
# --------
cd ~/clone/ui &&
  grunt ngconstant:testing &&
  grunt build &&
  grunt jshint &&
  grunt test
