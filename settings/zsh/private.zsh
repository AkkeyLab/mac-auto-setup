export PATH=/usr/local/bin:$PATH
export PATH=/usr/local/sbin:$PATH
export HOMEBREW_CASK_OPTS="--appdir=/Applications"
export LANG=ja_JP.UTF-8
export PATH="$HOME/.rbenv/bin:$PATH"
export PATH="$HOME/.nodebrew/current/bin:$PATH"
export PATH="$HOME/.yarn/bin:$PATH"

setopt print_eight_bit
source  ~/powerlevel9k/powerlevel9k.zsh-theme
eval "$(rbenv init - zsh)"
POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(time context dir vcs)
POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(status rbenv)
POWERLEVEL9K_STATUS_VERBOSE=false
POWERLEVEL9K_SHORTEN_STRATEGY="truncate_middle"
POWERLEVEL9K_SHORTEN_DIR_LENGTH=3

alias swift='/Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/bin/swift'


### latex compile functions ###
texc (){
    files=$(echo $@ | sed -e 's/\.tex//g');
    for file in $files; do
        platex "$file".tex;
        echo "--------------------------------------\n"
        dvipdfmx "$file".dvi > /dev/null;
        ls $file* | grep -v -e '.tex' -e '.pdf' | xargs rm;
    done

    echo "open viewer? [y/n]"
    read resp
    
    if [ $(echo $resp | grep '[y|Y]' | wc -l) -ge 1 ]; then
	    for file in $files; do
	        command open ${file}.pdf;
	    done
    fi
    echo "-------- compile END --------"
}
