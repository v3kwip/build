# --------
# Compress the source code
# --------
cd ~/clone
tar -czf ~/clone/drupal.tar.gz drupal
rm -rf ui/.git &&
tar -czf ~/clone/ui.tar.gz ui
rm -rf accounts/.git
tar -czf ~/clone/accounts.tar.gz accounts

# --------
# Clean the branch
# --------
mkdir ~/clone/build
cd ~/clone/build
git init
git remote add origin $BUILD_URL
git rm --cached -r *
rm -rf *

# --------
# Move the built source code to build git
# --------
mv ~/clone/drupal.tar.gz ./
mv ~/clone/accounts.tar.gz ./
mv ~/clone/ui.tar.gz ./
git add drupal.tar.gz
git add ui.tar.gz
git add accounts.tar.gz
git commit -m "Add drupal.tar.gz"
git commit -m "Add ui.tar.gz"
git commit -m "Add accounts.tar.gz"
git push --force origin master:builds
