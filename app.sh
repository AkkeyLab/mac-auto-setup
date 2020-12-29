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
brew install --cask 1password
brew tap AdoptOpenJDK/openjdk
brew install --cask adoptopenjdk
brew install --cask android-studio
brew install --cask cyberduck
brew install --cask docker
brew install --cask google-chrome
brew install --cask iterm2
brew install --cask sourcetree
brew install --cask vlc
brew install --cask google-japanese-ime
brew install --cask swimat
brew install --cask spotify
brew install --cask imageoptim
brew install --cask soundflower
brew install --cask visual-studio-code
brew install --cask adobe-creative-cloud
brew install --cask gyazo
brew install --cask zoomus
brew install --cask tandem
brew install --cask discord
brew install --cask notion

while true; do
  read -p 'Add "need license" apps? [Y/n]' Answer
  case $Answer in
    '' | [Yy]* )
      brew cask install microsoft-office
      brew cask install intellij-idea
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

