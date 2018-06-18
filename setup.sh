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
# Memorize user pass
#
read -sp "Your Password: " pass;

#
# Mac App Store apps install
#
if ! command_exists mas ; then
  echo " ---- Mac App Store apps -----"
  brew install mas
  mas install 497799835  # Xcode (8.2.1)
  echo " ------------ END ------------"
fi

#
# Install zsh
#
if ! command_exists zsh ; then
  echo " ------------ zsh ------------"
  brew install zsh zsh-autosuggestions zsh-completions zsh-syntax-highlighting colordiff
  which -a zsh
  echo $pass | sudo -S -- sh -c 'echo '/usr/local/bin/zsh' >> /etc/shells'
  chsh -s /usr/local/bin/zsh
  echo " ------------ END ------------"
fi

#
# Install vim
#
if ! command_exists vim ; then
  echo " ------------ Vim ------------"
  brew install vim --with-override-system-vi
  echo " ------------ END ------------"
fi

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
if ! command_exists rbenv ; then
  echo " ----------- Ruby ------------"
  brew install rbenv
  brew install ruby-build
  rbenv --version
  rbenv install -l
  ruby_latest=$(rbenv install -l | grep -v '[a-z]' | tail -1 | sed 's/ //g')
  rbenv install $ruby_latest
  rbenv global $ruby_latest
  rbenv rehash
  ruby -v
  echo " ------------ END ------------"
fi

#
# Install dotfiles system
#
echo " ---------- dotfiles ---------"
sh -c "`curl -fsSL https://raw.githubusercontent.com/skwp/dotfiles/master/install.sh`"
cp $(cd $(dirname ${BASH_SOURCE:-$0}); pwd)/settings/zsh/private.zsh ~/.yadr/zsh/private.zsh
source ~/.zshrc
echo " ------------ END ------------"

#
# Install Node.js env
#
if ! command_exists nodebrew ; then
  echo " ---------- Node.js ----------"
  curl -L git.io/nodebrew | perl - setup
  nodebrew ls-remote
  nodebrew install-binary latest
  nodebrew ls
  nodebrew use latest
  node -v
  npm -v
  echo " ------------ END ------------"
fi

#
# Install Yarn
#
if ! command_exists yarn ; then
  echo " ----------- Yarn ------------"
  brew install yarn
  echo " ------------ END ------------"
fi

#
# TeX settings
#
if ! command_exists tex ; then
  echo " ------------ TeX ------------"
  brew cask install mactex
  # Tex Live Utility > preference > path -> /Library/TeX/texbin
  version=$(tex -version | grep -oE '2[0-9]{3}' | head -1)
  echo $pass | sudo -S /usr/local/texlive/$version/bin/x86_64-darwin/tlmgr path add
  echo $pass | sudo -S tlmgr update --self --all
  # JPN Lang settings
  cd /usr/local/texlive/$version/texmf-dist/scripts/cjk-gs-integrate
  echo $pass | sudo -S perl cjk-gs-integrate.pl --link-texmf --force
  echo $pass | sudo -S mktexlsr
  echo $pass | sudo -S kanji-config-updmap-sys hiragino-elcapitan-pron
  # Select ==> TeXShop > Preferences > Source > pTeX (ptex2pdf)
  echo " ------------ END ------------"
fi

#
# Install wget
#
if ! command_exists wget ; then
  echo " ----------- wget ------------"
  brew install wget
  wget --version
  echo " ------------ END ------------"
fi

#
# CocoaPods
#
if ! command_exists pod ; then
  echo " --------- CocoaPods ---------"
  echo $pass | sudo -S gem install -n /usr/local/bin cocoapods --pre
  pod setup
  echo " ------------ END ------------"
fi

#
# Carthage
#
if ! command_exists carthage ; then
  echo " --------- Carthage ----------"
  brew install carthage
  echo " ------------ END ------------"
fi

while true; do
  read -p 'Now install web apps? [Y/n]' Answer
  case $Answer in
    '' | [Yy]* )
      $(cd $(dirname ${BASH_SOURCE:-$0}); pwd)/app.sh
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
      $(cd $(dirname ${BASH_SOURCE:-$0}); pwd)/appstore.sh
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
