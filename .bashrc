# Adam's .bashrc
#
# for those shitty times when zsh isn't to hand
#
# $Id$

# .bashrc is invoked by non-login interactive shells

# {{{ Load .bashenv

[ -r ~/.bashenv ] && . ~/.bashenv

# }}}
# {{{ Try to switch shell

[ -r ~/.preferred_shell ] && [ -r ~/.switch_shell ] && \
  eval ". ~/.switch_shell `cat ~/.preferred_shell`"

# }}}
# {{{ Source global definitions

if [ -f /etc/bashrc ]; then
  . /etc/bashrc
fi

# }}}
# {{{ Environment

[ -e ~/.shared_env ] && . ~/.shared_env

# {{{ ls colours

if which dircolors >&/dev/null && [ -e ~/.dircolors ]; then
  # show directories in yellow
  eval `dircolors -b ~/.dircolors`
fi

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
  alias ls='command ls -F --color'
elif ls -F >&/dev/null; then
  alias ls='command ls -F'
elif ls --color >&/dev/null; then
  alias ls='command ls --color'
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

[ -r ~/.bashrc.local ]           && . ~/.bashrc.local
[ -r ~/.bashrc.${HOSTNAME%%.*} ] && . ~/.bashrc.${HOSTNAME%%.*}

# }}}
