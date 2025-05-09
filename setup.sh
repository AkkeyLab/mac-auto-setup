#!/bin/bash -e
cat <<EOS

 AkkeyLab

 The elapsed time does not matter.
 Because speed is important.

EOS

function command_exists {
  command -v "$1" >/dev/null
}

source ~/.zprofile

#
# Copy git ssh config file
#
echo " ------- Git SSH config ------"
mkdir ~/.ssh && cp $(
  cd $(dirname ${BASH_SOURCE:-$0})
  pwd
)/settings/git/config ~/.ssh/config
read -p 'Do you want to configure Git ssh ? [y/n]' input
case $input in
'' | [Nn]*)
  echo "Skip"
  ;;
[Yy]*)
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
echo " ---- Mac App Store apps -----"
if ! command_exists mas; then
  brew install mas
fi
mas install 497799835 # Xcode
echo " ------------ END ------------"

#
# Install zsh
#
if [ ! -e "$(brew --prefix)/bin/zsh" ]; then
  echo " ------------ zsh ------------"
  brew install zsh zsh-autosuggestions zsh-completions zsh-syntax-highlighting colordiff
  which -a zsh
  echo $pass | sudo -S -- sh -c 'echo "$(brew --prefix)/bin/zsh" >> /etc/shells'
  # This is a workaround for problems that Xcode and others may refer to
  echo $pass | sudo sh -c "mkdir -p /usr/local/bin && ln -s $(brew --prefix)/bin/zsh /usr/local/bin/zsh"
  chsh -s "$(brew --prefix)/bin/zsh"
  echo " ------------ END ------------"
fi

#
# Install vim
#
if [ ! -e "$(brew --prefix)/bin/vim" ]; then
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
echo 'eval "$('"$(brew --prefix)"'/bin/brew shellenv)"' >>~/.yadr/zsh/private.zsh
echo "source $(brew --prefix)/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" >>~/.yadr/zsh/private.zsh
echo "export ZSH_HIGHLIGHT_HIGHLIGHTERS_DIR=$(brew --prefix)/share/zsh-syntax-highlighting/highlighters" >>~/.yadr/zsh/private.zsh
echo "source $(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh" >>~/.yadr/zsh/private.zsh
source ~/.zshrc # You will be asked to enter your choices here
compaudit | xargs sudo chmod g-w # Skip that input task from now on
echo " ------------ END ------------"

#
# Powerline
#
echo " --------- Powerline ---------"
curl -L -o ~/Downloads/font.ttf https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Regular.ttf
open ~/Downloads/font.ttf
brew install powerlevel10k
echo "source $(brew --prefix)/share/powerlevel10k/powerlevel10k.zsh-theme" >>~/.yadr/zsh/private.zsh
cp $(
  cd $(dirname ${BASH_SOURCE:-$0})
  pwd
)/settings/zsh/p10k.zsh ~/.yadr/zsh/p10k.zsh
source ~/.zshrc
echo " ------------ END ------------"

#
# Install asdf
#
if ! command_exists asdf; then
  echo " ----------- asdf ------------"
  brew install asdf
  echo -e "\n. $(brew --prefix asdf)/libexec/asdf.sh" >>~/.yadr/zsh/private.zsh
  source ~/.zshrc
  echo " ------------ END ------------"
fi

#
# Install ruby
#
if [ ! -e "$HOME/.asdf/shims/ruby" ]; then
  echo " ----------- Ruby ------------"
  # No longer bundle 3rd party sources
  # https://www.ruby-lang.org/en/news/2022/12/25/ruby-3-2-0-released
  brew install libyaml ruby-build
  echo -e "export RUBY_CONFIGURE_OPTS=\"--with-openssl-dir=$(brew --prefix openssl)\"" >>~/.yadr/zsh/private.zsh
  source ~/.zshrc

  asdf plugin add ruby https://github.com/asdf-vm/asdf-ruby.git
  asdf plugin update ruby
  ruby_latest=$(asdf list all ruby | grep -v '[a-z]' | sed -e '${/^$/d;}' | tail -n 1)
  asdf install ruby $ruby_latest
  asdf set -u ruby $ruby_latest
  asdf reshim ruby
  ruby -v
  where ruby
  asdf which ruby

  # https://github.com/asdf-vm/asdf-ruby#migrating-from-another-ruby-version-manager
  echo "legacy_version_file = yes" >~/.asdfrc
  echo " ------------ END ------------"
fi

#
# Install Golang
#
if [ ! -e "$HOME/.asdf/shims/go" ]; then
  echo " ---------- Golang -----------"
  asdf plugin add golang https://github.com/kennyp/asdf-golang
  golang_latest=$(asdf list all golang | grep -v '[a-z]' | tail -1 | sed 's/ //g')
  asdf install golang $golang_latest
  asdf global golang $golang_latest
  asdf reshim golang
  go version
  where go
  asdf which go

  go install golang.org/x/tools/gopls@latest
  go install github.com/go-delve/delve/cmd/dlv@latest
  go install github.com/cweill/gotests/...@latest
  asdf reshim golang

  # GOPATH -> https://github.com/kennyp/asdf-golang/blob/master/bin/exec-env
  # echo -e 'export GOPATH=$(asdf where golang)/go' >>~/.yadr/zsh/private.zsh
  # echo -e 'export PATH="$PATH:$GOPATH"' >>~/.yadr/zsh/private.zsh
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
# bat command
#
if ! command_exists bat; then
  echo " --------- bat command ----------"
  brew install bat
  echo " ------------ END ------------"
fi

read -p 'Do you want to enter your Git user name ? [y/n]' input
case $input in
'' | [Nn]*)
  echo "Skip"
  ;;
[Yy]*)
  read -p 'Git user name:' name
  git config --global user.name $name
  git config user.name
  echo " ------------ END ------------"
  ;;
esac

read -p 'Do you want to enter your Git user e-mail ? [y/n]' input
case $input in
'' | [Nn]*)
  echo "Skip"
  ;;
[Yy]*)
  read -p 'Git user e-mail:' mail
  git config --global user.email $mail
  git config user.email
  echo " ------------ END ------------"
  ;;
esac

read -p 'Do you want to enter your GitHub Access Token ? [y/n]' input
case $input in
'' | [Nn]*)
  echo "Skip"
  ;;
[Yy]*)
  read -p 'GitHub Access Token:' token
  echo "export GITHUB_ACCESS_TOKEN=${token}" >>~/.yadr/zsh/private.zsh
  echo "export HOMEBREW_GITHUB_API_TOKEN=${token}" >>~/.yadr/zsh/private.zsh
  echo "Writing to ~/.yadr/zsh/private.zsh is complete."
  source ~/.zshrc
  echo " ------------ END ------------"
  ;;
esac

read -p 'Do you want to install Google Cloud CLI ? [y/n]' input
case $input in
'' | [Nn]*)
  echo "Skip"
  ;;
[Yy]*)
  brew install --cask google-cloud-sdk
  echo "source $(brew --prefix)/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/completion.zsh.inc" >>~/.yadr/zsh/private.zsh
  echo "source $(brew --prefix)/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/path.zsh.inc" >>~/.yadr/zsh/private.zsh
  source ~/.zshrc
  gcloud auth login
  ;;
esac

read -p 'Do you want to install App Store Apps ? [y/n]' input
case $input in
'' | [Nn]*)
  echo "Skip"
  ;;
[Yy]*)
  $(
    cd $(dirname ${BASH_SOURCE:-$0})
    pwd
  )/appstore.sh
  ;;
esac

read -p 'Do you want to install Third Party Apps ? [y/n]' input
case $input in
'' | [Nn]*)
  echo "Skip"
  ;;
[Yy]*)
  $(
    cd $(dirname ${BASH_SOURCE:-$0})
    pwd
  )/app.sh
  ;;
esac

read -p 'Would you like to create the recommended development directory ? [y/n]' input
case $input in
'' | [Nn]*)
  echo "Skip"
  ;;
[Yy]*)
  mkdir ~/Development
  echo " ------------ END ------------"
  ;;
esac
