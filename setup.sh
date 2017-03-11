#!/bin/bash
cat << EOS

 AkkeyLab

 The elapsed time does not matter.
 Because speed is important.

EOS

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
# Mac App Store apps install
#
echo " ---- Mac App Store apps -----"
brew install mas
mas install 497799835  # Xcode (8.2.1)
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
which -a zsh
sudo -- sh -c 'echo '/usr/local/bin/zsh' >> /etc/shells'
chsh -s /usr/local/bin/zsh
echo " ------------ END ------------"

#
# Install vim
#
echo " ------------ Vim ------------"
brew install vim --with-override-system-vi
echo " ------------ END ------------"

#
# Powerline
#
echo " --------- Powerline ---------"
# Font is 14pt Iconsolata for Powerline with Solarized Dark iterm2 colors.
git clone https://github.com/bhilburn/powerlevel9k.git ~/powerlevel9k
git clone https://github.com/powerline/fonts.git ~/fonts
~/fonts/install.sh
echo " ------------ END ------------"

#
# Install ruby
#
echo " ----------- Ruby ------------"
brew install rbenv
brew install ruby-build
rbenv --version
rbenv install -l
rbenv install 2.4.0
rbenv global 2.4.0
rbenv rehash
ruby -v
echo " ------------ END ------------"

#
# Install dotfiles system
#
echo " ---------- dotfiles ---------"
sh -c "`curl -fsSL https://raw.githubusercontent.com/skwp/dotfiles/master/install.sh`"
cp ~/mac-auto-setup/settings/zsh/private.zsh ~/.yadr/zsh/private.zsh
source ~/.zshrc
echo " ------------ END ------------"

#
# Install Node.js env
#
echo " ---------- Node.js ----------"
curl -L git.io/nodebrew | perl - setup
nodebrew ls-remote
nodebrew install-binary v7.0.0
nodebrew ls
nodebrew use v7.0.0
node -v
npm -v
echo " ------------ END ------------"

#
# Install Yarn
#
echo " ----------- Yarn ------------"
brew install yarn
echo " ------------ END ------------"

#
# TeX settings
#
echo " ------------ TeX ------------"
brew cask install mactex
# Tex Live Utility > preference > path -> /Library/TeX/texbin
sudo /usr/local/texlive/2016/bin/x86_64-darwin/tlmgr path add
sudo tlmgr update --self --all
# JPN Lang settings
cd /usr/local/texlive/2016/texmf-dist/scripts/cjk-gs-integrate
sudo perl cjk-gs-integrate.pl --link-texmf --force
sudo mktexlsr
sudo kanji-config-updmap-sys hiragino-elcapitan-pron
# Select ==> TeXShop > Preferences > Source > pTeX (ptex2pdf)
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
wget https://www.clip-studio.com/clip_site/download/clipstudiopaint/system/dl?f=lib/clipstudio/paint/data/164/CSP_164m_app.pkg
echo " Please manually install the application from the download directory."
echo " -----------------------------"
echo " セキュリティ対策ツール"
echo " Please download it manually from the web site and set it up."
echo " ------------ END ------------"

while true; do
  read -p 'Now install web apps? [Y/n]' Answer
  case $Answer in
    '' | [Yy]* )
      ~/mac-auto-setup/app.sh
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

while true; do
  read -p 'Now install App Store apps? [Y/n]' Answer
  case $Answer in
    '' | [Yy]* )
      ~/mac-auto-setup/appstore.sh
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
