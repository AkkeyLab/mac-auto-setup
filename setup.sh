#!/bin/bash
cat <<EOS

 AkkeyLab

 The elapsed time does not matter.
 Because speed is important.

EOS

function command_exists {
  command -v "$1" >/dev/null
}

#
# Copy git ssh config file
#
echo " ------- Git SSH config ------"
mkdir ~/.ssh && cp $(
  cd $(dirname ${BASH_SOURCE:-$0})
  pwd
)/settings/git/config ~/.ssh/config
read -p 'Git ssh settings. You can skip by typing "N".' Answer
case $Answer in
'' | [Nn]*)
  echo "Skip"
  ;;
*)
  ssh-keygen -t rsa
  chmod 600 ~/.ssh/id_rsa
  eval $(ssh-agent)
  ssh-add ~/.ssh/id_rsa
  ssh-add -l
  echo 'Let’s register your public key on GitHub\ncheck command: `ssh -T git@github.com`'
  ;;
esac
echo " ------------ END ------------"

#
# Memorize user pass
#
read -sp "Your Password: " pass

#
# Mac App Store apps install
#
if ! command_exists mas; then
  echo " ---- Mac App Store apps -----"
  brew install mas
  mas install 497799835 # Xcode
  echo " ------------ END ------------"
fi

#
# Install zsh
#
if ! command_exists zsh; then
  echo " ------------ zsh ------------"
  brew install zsh zsh-autosuggestions zsh-completions zsh-syntax-highlighting colordiff
  which -a zsh
  if [ -d /opt/homebrew/bin ]; then
    echo $pass | sudo -S -- sh -c 'echo '/opt/homebrew/bin/zsh' >> /etc/shells'
    chsh -s /opt/homebrew/bin/zsh
  else
    echo $pass | sudo -S -- sh -c 'echo '/usr/local/bin/zsh' >> /etc/shells'
    chsh -s /usr/local/bin/zsh
  fi
  echo " ------------ END ------------"
fi

#
# Install vim
#
if ! command_exists vim; then
  echo " ------------ Vim ------------"
  brew install vim
  echo " ------------ END ------------"
fi

#
# Install dotfiles system
#
echo " ---------- dotfiles ---------"
sh -c "$(curl -fsSL https://raw.githubusercontent.com/skwp/dotfiles/master/install.sh)"
cp $(
  cd $(dirname ${BASH_SOURCE:-$0})
  pwd
)/settings/zsh/private.zsh ~/.yadr/zsh/private.zsh
if [ "$(uname -m)" = arm64 ]; then
  echo "typeset -U path PATH
path=(
  /opt/homebrew/bin(N-/)
  /opt/homebrew/sbin(N-/)
  /usr/bin
  /usr/sbin
  /bin
  /sbin
  /usr/local/bin(N-/)
  /usr/local/sbin(N-/)
  /Library/Apple/usr/bin
)
" >>~/.yadr/zsh/private.zsh
  echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >>~/.yadr/zsh/private.zsh
else
  echo "typeset -U path PATH
path=(
  /usr/local/bin(N-/)
  /usr/local/sbin(N-/)
  /usr/bin
  /usr/sbin
  /bin
  /sbin
  /opt/homebrew/bin(N-/)
  /opt/homebrew/sbin(N-/)
  /Library/Apple/usr/bin
)
" >>~/.yadr/zsh/private.zsh
fi
source ~/.zshrc
echo " ------------ END ------------"

#
# Powerline
#
echo " --------- Powerline ---------"
# Font: MesloLGS NF Regular 13pt
brew install romkatv/powerlevel10k/powerlevel10k
echo "source $(brew --prefix)/opt/powerlevel10k/powerlevel10k.zsh-theme" >>~/.yadr/zsh/private.zsh
cp $(
  cd $(dirname ${BASH_SOURCE:-$0})
  pwd
)/settings/zsh/p10k.zsh ~/.yadr/zsh/p10k.zsh
echo " ------------ END ------------"

#
# Install ruby
#
if ! command_exists rbenv; then
  echo " ----------- Ruby ------------"
  brew install rbenv
  echo 'eval "$(rbenv init - zsh)"' >>~/.yadr/zsh/private.zsh
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
# gitmoji-cli
#
if ! command_exists gitmoji; then
  echo " --------- gitmoji-cli ----------"
  brew install gitmoji
  echo " ------------ END ------------"
fi

#
# Create .bashrc file. Bash is used within Xcode
#
echo " ----------- Create .bashrc file ------------"
if [ -d /opt/homebrew ]; then
  echo 'export PATH=/opt/homebrew/bin:$PATH\nexport PATH=/opt/homebrew/sbin:$PATH' >>~/.bashrc
fi
if [ -d /usr/local ]; then
  echo 'export PATH=/usr/local/bin:$PATH\nexport PATH=/usr/local/sbin:$PATH' >>~/.bashrc
fi
echo " ------------ END ------------"

read -p 'Please enter your Git User Name. You can skip by typing "N".' Answer
case $Answer in
'' | [Nn]*)
  echo "Skip"
  ;;
*)
  git config --global user.name $Answer
  git config user.name
  echo " ------------ END ------------"
  ;;
esac

read -p 'Please enter your Git User e-mail. You can skip by typing "N".' Answer
case $Answer in
'' | [Nn]*)
  echo "Skip"
  ;;
*)
  git config --global user.email $Answer
  git config user.email
  echo " ------------ END ------------"
  ;;
esac

read -p 'Please enter your GitHub Access Token. You can skip by typing "N".' Answer
case $Answer in
'' | [Nn]*)
  echo "Skip"
  ;;
*)
  echo "export GITHUB_ACCESS_TOKEN=${Answer}" >>~/.yadr/zsh/private.zsh
  echo "export HOMEBREW_GITHUB_API_TOKEN=${Answer}" >>~/.yadr/zsh/private.zsh
  echo "Writing to ~/.yadr/zsh/private.zsh is complete."
  echo " ------------ END ------------"
  ;;
esac

read -p 'Install App Store apps. You can skip by typing "N".' Answer
case $Answer in
'' | [Nn]*)
  echo "Skip"
  ;;
*)
  $(
    cd $(dirname ${BASH_SOURCE:-$0})
    pwd
  )/appstore.sh
  ;;
esac

read -p 'Install web apps. You can skip by typing "N".' Answer
case $Answer in
'' | [Nn]*)
  echo "Skip"
  ;;
*)
  $(
    cd $(dirname ${BASH_SOURCE:-$0})
    pwd
  )/app.sh
  ;;
esac
