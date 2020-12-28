#!/bin/bash
cat << EOS

 AkkeyLab

 The elapsed time does not matter.
 Because speed is important.

EOS

function command_exists {
  command -v "$1" > /dev/null;
}

#
# Install homebrew.
#
if ! command_exists brew ; then
  echo " --------- Homebrew ----------"
  /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
  brew update
  brew upgrade
  brew -v
  echo " ------------ END ------------"
fi

#
# Install git
#
if ! command_exists git ; then
  echo " ------------ Git ------------"
  brew install git
  git --version
  echo " ------------ END ------------"
fi

#
# mac-auto-setup.git
#
echo " ---- mac-auto-setup.git -----"
git clone https://github.com/AkkeyLab/mac-auto-setup.git
echo " ------------ END ------------"
