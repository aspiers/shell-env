# Adam's .bashrc
#
# for those shitty times when zsh isn't to hand
#
# $Id$

[ -e ~/.switch_shell ] && . ~/.switch_shell

# {{{ Source global definitions

if [ -f /etc/bashrc ]; then
  . /etc/bashrc
fi

# }}}

# {{{ Environment

# not sure this should be in this file

# {{{ INPUTRC

# no crappy RedHat inputrcs, thankyouverymuch.  Which fucking *idiot*
# set convert-meta to off?
unset INPUTRC

# }}}
# {{{ IRC

export IRCNAME='Adam Spiers'
export IRCNICK='Adze'

# }}}
# {{{ Editor

export EDITOR=emacs
export VISUAL='emacs -nw'

# }}}
# {{{ WWW home

export WWW_HOME='http://www.new.ox.ac.uk/~adam/'

# }}}
# {{{ Pager

export METAMAIL_PAGER='less -r'
export PAGER='less'
export LESS='-h100 -i -j1 -M -q -y100'
#export LESSOPEN='|/usr/local/bin/lesspipe.sh %s'
#export LESSCLOSE='/usr/local/bin/lessclose.sh %s %s'

# }}}
# {{{ Name and Reply_To

export NAME='Adam Spiers'
export REPLYTO='adam@spiers.net (Adam Spiers)'

# }}}
# {{{ rsync uses ssh

export RSYNC_RSH=ssh

# }}}
# {{{ cvs uses ssh

export CVS_RSH=ssh

# }}}

# }}}
# {{{ Key bindings

bind '"\ep":history-search-backward'
bind '"\en":history-search-forward'

# }}}
# {{{ Prompt

PS1="\u@\h \[\033[1m\]\\w\[\033[0m\] \$ "

# }}}
# {{{ Aliases and functions

# {{{ ls aliases

if ls -F --color >&/dev/null; then
  alias ls='/bin/ls -F --color'
elif ls -F >&/dev/null; then
  alias ls='/bin/ls -F'
elif ls --color >&/dev/null; then
  alias ls='/bin/ls --color'
fi

# jeez I'm lazy ...
alias l='ls -l'
alias la='ls -la'
alias lsa='ls -a'
alias lsh='ls -d .*'
alias ld='ls -ld'
# damn, missed out lsd :-)

# }}}
# {{{ File management

# {{{ Changing/making/removing directory

alias cd..='cd ..'
alias cd...='cd ../..'
alias cd....='cd ../../..'
alias cd.....='cd ../../../..'
alias cd......='cd ../../../../..'
alias cd/='cd /'

alias md='mkdir -p'
alias rd=rmdir

alias dirs='dirs -v'
alias d=dirs

# Don't need this because auto_pushd is set
#alias pu=pushd

alias po=popd
alias pwd='pwd -r'

# }}}
# {{{ finding out disk hogs

# {{{ du1 (du with depth 1)

du1 () {
  du "$@" | egrep -v '/.*/'
  # Another idea from Bart Schaefer, which I need to fix
  # to take parameters
  #du -s *(/)
}

# }}}

# }}}
# {{{ Use this to untar after doing a tar ztvf/tvf/ztf command

# Thanks to Bart Schaefer for this one
alias xt='fc -e - tvf=xf ztf=zxf -1'

# }}}

# }}}
# {{{ Job/process control

alias j='jobs -l'
rj () {
  ps auxww | grep -E "($*|^USER)"
}

# }}}
# {{{ Terminals

alias vx='export TERM=xterm-color'

# }}}
# {{{ Other users

alias f=finger

# }}}
# {{{ Other programs

# {{{ less

alias v=less

# }}}
# {{{ editors

e () {
  emacs "$@" 2>&1 &
}

alias fe='emacs -nw --eval "(setq make-backup-files nil)"'

# }}}
# {{{ ftp

if which lftp >&/dev/null; then
  alias ftp=lftp
elif which ncftp >&/dev/null; then
  alias ftp=ncftp
fi

# }}}
# {{{ watching log files

alias tf='less +F'

# }}}

# }}}
# {{{ Other hosts

alias th='ssh -l adam thelonious.new.ox.ac.uk'

# }}}

# }}}

# {{{ Specific to hosts

if [ -r ~/.bashrc.local ]; then
  . ~/.bashrc.local
fi

if [ -r ~/.bashrc.${HOSTNAME%%.*} ]; then
  . ~/.bashrc.${HOSTNAME%%.*}
fi

# }}}
