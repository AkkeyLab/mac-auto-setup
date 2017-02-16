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
brew cask install android-studio
brew cask install arduino
brew cask install astropad
brew cask install atom
brew cask install cheatsheet
brew cask install cyberduck
brew cask install docker
brew cask install dropbox
brew cask install duet
brew cask install eclipse-ide
brew cask install firefox
# brew cask install funter # No ruby file
brew cask install genymotion
brew cask install google-chrome
brew cask install iterm2
# brew cask install octave # No ruby file
brew cask install onyx
brew cask install processing
brew cask install skype
brew cask install slack
brew cask install sourcetree
brew cask install sublime-text
brew cask install teamviewer
brew cask install virtualbox
brew cask install virtualbox-extension-pack
brew cask install vlc
brew cask install vmware-fusion
brew cask install vmware-horizon-client
brew cask install google-japanese-ime
brew cask install microsoft-office
brew cask install rubymine
brew cask install adobe-creative-cloud
brew cask install adobe-photoshop-cc
brew cask install adobe-illustrator-cc
brew cask install swimat
echo " ------------ END ------------"

#
# Install web apps for optional.
#
echo " ---- Install option apps ----"
brew cask install 4k-video-downloader
brew cask install fritzing
brew cask install mysqlworkbench
# brew cask install neo4j-community-edition # No ruby file
# brew cask install winx-hd-video-converter-for-mac # No ruby file
echo " ------------ END ------------"
