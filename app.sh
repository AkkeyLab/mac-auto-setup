#!/bin/bash
cat << EOS

 AkkeyLab

 The elapsed time does not matter.
 Because speed is important.

EOS

#
# Install web apps.
#
echo " ----- Install web apps ------"
brew cask install android-studio
#brew cask install genymotion
brew cask install google-chrome
brew cask install iterm2
brew cask install google-japanese-ime
echo " ------------ END ------------"

