export HOMEBREW_CASK_OPTS="--appdir=/Applications"
export LANG=en_US.UTF-8
export SDKROOT="$(xcrun --sdk macosx --show-sdk-path)"

setopt print_eight_bit

# If you get a warning, do the following
# compaudit | xargs sudo chmod g-w
if type brew &>/dev/null; then
  FPATH=$(brew --prefix)/share/zsh-completions:$FPATH

  autoload -Uz compinit
  compinit
fi
