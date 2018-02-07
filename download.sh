#!/bin/bash
cat << EOS

 noumi0k

 The elapsed time does not matter.
 Because speed is important.

EOS

#
# Memorize user pass
#
read -sp "Your Password: " pass;

#
# Install homebrew.
#
echo " --------- Homebrew ----------"
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
brew update
brew upgrade --all --cleanup
brew -v
echo " ------------ END ------------"

#
# Install git
#
echo " ------------ Git ------------"
brew install git
git --version
echo " ------------ END ------------"

#
# noumi0k/mac-auto-setup.git
#
echo " ------------ noumi0k/mac-auto-setup.git ------------"
git clone https://github.com/noumi0k/mac-auto-setup.git ~/mac-auto-setup
echo " ------------ END ------------"
