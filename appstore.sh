#!/bin/bash
cat << EOS

 AkkeyLab

 The elapsed time does not matter.
 Because speed is important.

EOS

#
# Mac App Store apps install
#
echo " ---- Mac App Store apps -----"
brew install mas
mas install 409183694  # Keynote
mas install 425424353  # The Unarchiver
mas install 803453959  # Slack
mas install 409201541  # Pages
mas install 1024640650 # CotEditor
mas install 453164367  # SystemPal
mas install 539883307  # LINE
mas install 412529613  # Cinch
mas install 409203825  # Numbers
mas install 549083868  # Display Menu (2.2.3)
echo " ------------ END ------------"
