#!/bin/bash
cat <<EOS

 AkkeyLab

 The elapsed time does not matter.
 Because speed is important.

EOS

read -p 'x86_64: "x", arm64: "a" and other' Answer
case $Answer in
'' | [Xx]*)
  arch -arch arm64 zsh
  uname -m
  ;;
*)
  arch -x86_64 bash
  zsh
  uname -m
  echo " ------------ END ------------"
  ;;
esac
