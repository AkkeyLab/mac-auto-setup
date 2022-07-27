#!/bin/bash
cat <<EOS

 AkkeyLab

 The elapsed time does not matter.
 Because speed is important.

EOS

read -p 'x86_64: "x", arm64: "a" and other' input
case $input in
'' | [Xx]*)
  arch -arch arm64 zsh
  uname -m
  echo " ------------ END ------------"
  ;;
[Yy]*)
  arch -x86_64 bash
  zsh
  uname -m
  echo " ------------ END ------------"
  ;;
*)
  echo "Skip"
  ;;
esac
