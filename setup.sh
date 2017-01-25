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
echo " --------- Homebrew ----------"
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
brew update
brew upgrade --all
brew doctor
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
# Install zsh
#
echo " ------------ zsh ------------"
brew install zsh zsh-autosuggestions zsh-completions zsh-syntax-highlighting colordiff
git clone https://github.com/seebi/zshrc.git ~/zshrc
cd ~/zshrc
make install
which -a zsh
sudo -- sh -c 'echo '/usr/local/bin/zsh' >> /etc/shells'
chsh -s /usr/local/bin/zsh
source ~/.zshrc
echo " ------------ END ------------"

#
# Install vim
#
echo " ------------ Vim ------------"
brew install vim --with-override-system-vi
echo 'export PATH=/usr/local/bin:$PATH' >> ~/zshrc/private.zsh
git clone https://github.com/amix/vimrc.git ~/.vim_runtime
sh ~/.vim_runtime/install_awesome_vimrc.sh
source ~/.zshrc
source ~/.vimrc
echo " ------------ END ------------"

#
# Load private setting.
#
# Haw to used : swift --version
echo 'alias swift='/Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/bin/swift'' >> ~/zshrc/private.zsh
# brew install caskroom/cask/brew-cask
echo 'export PATH="/usr/local/sbin:$PATH"' >> ~/zshrc/private.zsh
echo 'export HOMEBREW_CASK_OPTS="--appdir=/Applications"' >> ~/zshrc/private.zsh
echo 'export LANG=ja_JP.UTF-8' >> ~/zshrc/private.zsh
echo 'fpath=(/usr/local/share/zsh-completions $fpath)' >> ~/zshrc/private.zsh
echo 'setopt print_eight_bit' >> ~/zshrc/private.zsh
source ~/.zshrc

#
# Powerline
#
echo " --------- Powerline ---------"
# Font is 14pt Iconsolata for Powerline with Solarized Dark iterm2 colors.
git clone https://github.com/bhilburn/powerlevel9k.git ~/powerlevel9k
echo 'source  ~/powerlevel9k/powerlevel9k.zsh-theme' >> ~/zshrc/private.zsh
echo 'POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(time context dir vcs)' >> ~/zshrc/private.zsh
echo 'POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(status rbenv)' >> ~/zshrc/private.zsh
echo 'POWERLEVEL9K_STATUS_VERBOSE=false' >> ~/zshrc/private.zsh
echo 'POWERLEVEL9K_SHORTEN_STRATEGY="truncate_middle"' >> ~/zshrc/private.zsh
echo 'POWERLEVEL9K_SHORTEN_DIR_LENGTH=3' >> ~/zshrc/private.zsh
source ~/.zshrc
git clone https://github.com/powerline/fonts.git ~/fonts
~/fonts/install.sh
echo " ------------ END ------------"

#
# Homebrew apps install
#
# Mac App Store install setting
brew install mas
# TeX sub app (TeX custom install)
# brew install ghostscript

# ----------------------------------
# ----------------------------------

#
# Mac App Store apps install
#
echo " ---- Mac App Store apps -----"
mas install 497799835  # Xcode (8.2.1)
mas install 1144071713 # KeiSignal (1.0.3)
mas install 844918735  # PicGIF Lite (2.0.8)
mas install 409183694  # Keynote (6.6.2)
mas install 715768417  # Microsoft Remote Desktop (8.0.27228)
mas install 425424353  # The Unarchiver (3.11.1)
mas install 568494494  # Pocket (1.6.2)
mas install 803453959  # Slack (2.4.1)
mas install 524688159  # Desktop Calendar Plus (1.3.6)
mas install 409201541  # Pages (5.6.2)
mas install 1024640650 # CotEditor (3.1.2)
mas install 453164367  # SystemPal (5.2)
mas install 539883307  # LINE (4.11.1)
mas install 412529613  # Cinch (1.2.2)
mas install 409203825  # Numbers (3.6.2)
echo " ------------ END ------------"

#
# Install ruby
#
echo " ----------- Ruby ------------"
brew install rbenv
brew install ruby-build
rbenv --version
echo 'export PATH="$HOME/.rbenv/bin:$PATH" '>> ~/zshrc/private.zsh
echo 'eval "$(rbenv init - zsh)"' >> ~/zshrc/private.zsh
source ~/.zshrc
rbenv install -l
rbenv install 2.4.0
rbenv global 2.4.0
rbenv rehash
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
# TeX settings
#
echo " ------------ TeX ------------"
sudo tlmgr update --self --all
# JPN Lang settings
cd /usr/local/texlive/2016/texmf-dist/scripts/cjk-gs-integrate
sudo perl cjk-gs-integrate.pl --link-texmf --force
sudo mktexlsr
sudo kanji-config-updmap-sys hiragino-elcapitan-pron
echo " ------------ END ------------"

#
# Install wget
#
echo " ----------- wget ------------"
brew install wget
wget --version
echo " ------------ END ------------"

#
# CocoaPods
#
echo " --------- CocoaPods ---------"
sudo gem install -n /usr/local/bin cocoapods --pre
pod setup
echo " ------------ END ------------"

#
# Carthage
#
echo " --------- Carthage ----------"
brew install carthage
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
