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
if [ ! -e "$(brew --prefix)/bin/zsh" ]; then
  echo " ------------ zsh ------------"
  brew install zsh zsh-autosuggestions zsh-completions zsh-syntax-highlighting colordiff
  which -a zsh
  echo $pass | sudo -S -- sh -c 'echo "$(brew --prefix)/bin/zsh" >> /etc/shells'
  # This is a workaround for problems that Xcode and others may refer to
  echo $pass | sudo sh -c "mkdir -p /usr/local/bin & ln -s $(brew --prefix)/bin/zsh /usr/local/bin/zsh"
  chsh -s "$(brew --prefix)/bin/zsh"
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
echo "typeset -U path PATH
path=(
  $(brew --prefix)/bin(N-/)
  $(brew --prefix)/sbin(N-/)
  /usr/bin
  /usr/sbin
  /bin
  /sbin
  /Library/Apple/usr/bin
)
" >>~/.yadr/zsh/private.zsh
if [ -d /opt/homebrew/bin ]; then
  echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >>~/.yadr/zsh/private.zsh
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
# Install asdf
#
if ! command_exists asdf; then
  echo " ----------- asdf ------------"
  brew install asdf
  echo -e "\n. $(brew --prefix asdf)/libexec/asdf.sh" >>~/.yadr/zsh/private.zsh
  echo " ------------ END ------------"
fi

#
# Install ruby
#
if [ ! -e "$(echo ~$USERNAME)/.asdf/shims/ruby" ]; then
  echo " ----------- Ruby ------------"
  asdf plugin add ruby https://github.com/asdf-vm/asdf-ruby.git
  ruby_latest=$(asdf list all ruby | grep -v '[a-z]' | tail -1 | sed 's/ //g')
  asdf install ruby $ruby_latest
  asdf global ruby $ruby_latest
  asdf reshim ruby
  ruby -v
  where ruby
  asdf which ruby
  echo " ------------ END ------------"
fi

#
# Install Golang
#
if [ ! -e "$(echo ~$USERNAME)/.asdf/shims/go" ]; then
  echo " ---------- Golang -----------"
  asdf plugin add golang https://github.com/kennyp/asdf-golang
  golang_latest=$(asdf list all golang | grep -v '[a-z]' | tail -1 | sed 's/ //g')
  asdf install golang $golang_latest
  asdf global golang $golang_latest
  asdf reshim golang
  go version
  where go
  asdf which go
  # GOPATH -> https://github.com/kennyp/asdf-golang/blob/master/bin/exec-env
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
