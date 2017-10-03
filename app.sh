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
brew cask install 1password
brew cask install android-file-transfer
brew cask install java
brew cask install android-studio
brew cask install arduino
brew cask install astropad
brew cask install atom
brew cask install cheatsheet
brew cask install cyberduck
brew cask install docker
brew cask install dropbox
brew cask install duet
brew cask install eclipse-java
brew cask install firefox
brew cask install genymotion
brew cask install google-chrome
brew cask install iterm2
brew cask install processing
brew cask install skype
brew cask install sourcetree
brew cask install sublime-text
brew cask install teamviewer
brew cask install virtualbox
brew cask install virtualbox-extension-pack
brew cask install vlc
brew cask install vmware-fusion
brew cask install vmware-horizon-client
brew cask install google-japanese-ime
brew cask install swimat
brew cask install spotify
brew cask install imageoptim
brew cask install hockey
while true; do
  read -p 'Add "need license" apps? [Y/n]' Answer
  case $Answer in
    '' | [Yy]* )
      brew cask install microsoft-office
      brew cask install intellij-idea
      brew cask install adobe-creative-cloud
      brew cask install adobe-photoshop-cc
      brew cask install adobe-illustrator-cc
      brew cask install clip-studio-paint
      break;
      ;;
    [Nn]* )
      echo "Skip install"
      break;
      ;;
    * )
      echo Please answer YES or NO.
  esac
done;
echo " ------------ END ------------"

#
# Install web apps for optional.
#
echo " ---- Install option apps ----"
while true; do
  read -p 'Install option apps ? [Y/n]' Answer
  case $Answer in
    '' | [Yy]* )
      brew cask install fritzing
      brew cask install mysqlworkbench
      break;
      ;;
    [Nn]* )
      echo "Skip install"
      break;
      ;;
    * )
      echo Please answer YES or NO.
  esac
done;
echo " ------------ END ------------"
