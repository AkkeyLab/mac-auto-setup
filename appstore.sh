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
mas install 409183694  # Keynote (6.6.2)
mas install 425424353  # The Unarchiver (3.11.1)
mas install 803453959  # Slack (2.4.1)
mas install 409201541  # Pages (5.6.2)
mas install 1024640650 # CotEditor (3.1.2)
mas install 453164367  # SystemPal (5.2)
mas install 539883307  # LINE (4.11.1)
mas install 412529613  # Cinch (1.2.2)
mas install 409203825  # Numbers (3.6.2)
mas install 476533227  # Prepo (2.2.7)
mas install 549083868  # Display Menu (2.2.3)
echo " ------------ END ------------"
