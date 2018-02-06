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
mas install 803453959  # Slack (2.4.1)
mas install 1024640650 # CotEditor (3.1.2)
echo " ------------ END ------------"
