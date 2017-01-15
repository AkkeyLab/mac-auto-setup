#!/bin/sh
echo ""
echo " AkkeyLab"
echo ""
echo " The elapsed time doesn't matter."
echo " Because speed is important."
echo ""

#
# Install git
#
echo " ------------ Git ------------"
brew install git
git --version
echo " ------------ END ------------"

#
# Install homebrew.
#
echo " --------- Homebrew ----------"
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
brew update
brew upgrade --all
brew doctor
brew -v
echo " ------------ END ------------"

#
# Install zsh
#
echo " ------------ zsh ------------"
brew install zsh zsh-autosuggestions zsh-completions zsh-syntax-highlighting colordiff
# mkdir ~/Downloads/tmp
# cd ~/Downloads/tmp
# git clone https://github.com/zplug/zplug.git .zplug
cd ~/
git clone https://github.com/seebi/zshrc.git
cd ~/zshrc/
make install
source ~/.zshrc
echo '/usr/local/bin/zsh' >> /etc/shells
# chsh
echo " ------------ END ------------"

#
# Old version option.
#
# brew install caskroom/cask/brew-cask

#
# Load setting files.
#
# cp .bashrc ~/.bashrc
# cd ~
# source .bashrc

#
# Install ruby
#
echo " ----------- Ruby ------------"
brew install openssl
brew install readline
brew install rbenv
brew install rbenv-gemset
rbenv --version
cd ~/
echo 'eval "$(rbenv init -)"' >> .zshrc.local
source ~/.zshrc
rbenv install -l
rbenv install 2.3.3
rbenv rehash
rbenv global 2.3.3
ruby -v
echo " ------------ END ------------"

#
# Use old plugin for Xcode8
#
echo " --- update_xcode_plugins ----"
gem install update_xcode_plugins
update_xcode_plugins
update_xcode_plugins --unsign
echo " ------------ END ------------"

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
brew cask install eclipse-installer
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
brew cask install mactex
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

#
# App store
#
echo " ---- Install store apps -----"
Cinch
CotEditor
Desktop Calendar Plus
KeiSignal
Microsoft Remote Desktop
PicGIF Lite
Pocket
SystemPal
The Unarchiver
Xcode
イメージオプティム
line
echo " ------------ END ------------"

#
# Install wget
#
echo " ----------- wget ------------"
brew install wget
wget --version
echo " ------------ END ------------"

#
# Self install apps
#
echo " ----- Self install apps -----"
cd ~/Downloads
echo " CLIP STUDIO PAINT"
wget https://www.clip-studio.com/clip_site/download/clipstudiopaint/system/dl?f=lib/clipstudio/paint/data/163/CSP_163m_app.pkg
echo " Please manually install the application from the download directory."
echo " -----------------------------"
echo " セキュリティ対策ツール"
echo " Please download it manually from the web site and set it up."
echo " ------------ END ------------"
