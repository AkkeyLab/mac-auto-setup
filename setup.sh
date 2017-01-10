#!/bin/sh
echo ""
echo " AkkeyLab"
echo ""
echo " The elapsed time doesn't matter."
echo " Because speed is important."
echo ""

#
# Install homebrew.
#
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

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
# Install web apps.
#
echo " ----- Install web apps. -----"
brew cask install 1password-6
brew cask install android-file-transfer
brew cask install android-studio
brew cask install arduino
brew cask install astropad
brew cask install atom
brew cask install cheatsheet
brew cask install clip-studio
brew cask install cyberduck
brew cask install docker
brew cask install dropbox
brew cask install duet
brew cask install eclipse
brew cask install firefox
brew cask install funter
brew cask install genymotion
brew cask install google-chrome
brew cask install iterm
brew cask install line
brew cask install octave
brew cask install onyx
brew cask install processing
brew cask install skype
brew cask install slack
brew cask install sourcetree
brew cask install sublime-text-2
brew cask install teamviewer
brew cask install tex
brew cask install virtualbox
brew cask install vlc
brew cask install vmware-horizon-client
echo " ------------ END ------------"

#
# Install web apps for optional.
#
echo " ----- Install opt apps. -----"
brew cask install 4k-video-downloader
brew cask install fritzing
brew cask install mysqlworkbench
brew cask install neo4j-community-edition
brew cask install winx-hd-video-converter-for-mac
echo " ------------ END ------------"

#
# App store
#
echo " ----- Install store app -----"
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
echo " ------------ END ------------"

#
# Self install apps
#
echo " ----- Self install apps -----"
echo " Adobe Audition CS6"
echo " Adobe Creative Cloud"
echo " Adobe Illustrator CS6"
echo " Adobe Photoshop CS6"
echo " Final Cut Pro"
echo " Google 日本語入力"
echo " Microsoft Excel"
echo " Microsoft OneNote"
echo " Microsoft Outlook"
echo " Microsoft PowerPoint"
echo " Microsoft Word"
echo " RubyMine"
echo " VMware Fusion"
echo " セキュリティ対策ツール"

echo " Swimat"

echo " ------------ END ------------"
