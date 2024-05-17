# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/bin" ] ; then
    export PATH="$HOME/bin:$HOME/.local/bin:$PATH"
fi

if [ "`which colordiff`" != "" ]; then
    alias diff=colordiff
fi

alias vp='vim -p'
alias e='vim'
alias less='less -R'
alias ll='ls -l'
alias lr='ls -R'
alias df='df -h'
alias cdd='cd $HOME/github/scrapetrade/src/control'
alias cdb='cd $HOME/github/scrapetrade/bin/control'
alias cds='cd $HOME/github/ibkr/client/IBJts/source/pythonclient'
alias 7za='7az -mm=BZip2'
alias sd='systemctl daemon-reload'

# Enable pyenv
#export PATH="/home/glbrimhall/.pyenv/bin:$PATH"
#eval "$(pyenv init -)"
#eval "$(pyenv virtualenv-init -)"

stty -ixon

