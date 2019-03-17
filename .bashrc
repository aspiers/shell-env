# Adam's .bashrc
#
# for those shitty times when zsh isn't to hand
#
# $Id$

# .bashrc is invoked by non-login interactive shells and by login
# interactive shells via a hook in my .bash_profile; also when bash is
# invoked from rshd (or similar?)

: .bashrc starts # for debugging with -x

# Allow disabling of all meddling with the environment
[ -n "$INHERIT_ENV" ] && return 0

# {{{ Environment

[ -r ~/.bashenv ] && . ~/.bashenv

# }}}

sh_load_status .bashrc

# {{{ source /etc/bashrc

if [ -f /etc/bashrc ]; then
    sh_load_status "/etc/bashrc"
    . /etc/bashrc
else
    [ -r $ZDOTDIR/.sysbashrc ] && . $ZDOTDIR/.sysbashrc
fi

# }}}

##############################################################################
# Only interactive stuff follows below.

if [ -n "$shell_interactive" ]; then

# {{{ Try to switch shell

# For some weird reason this needs to be done after sourcing
# /etc/bashrc if the latter contains an stty, otherwise if
# the switched to shell exits non-zero, execution through this
# file proceeds (possibly without a tty as a result of the exit?)
# and the stty hangs.

# "" is to force shell choice from ~/.preferred_shell
[ -r ~/.switch_shell ] && . ~/.switch_shell ""

# }}}

# {{{ Save a large history

HISTSIZE=10000
HISTFILESIZE=10000
HISTTIMEFORMAT="%F %H:%M:%S "

# }}}
# {{{ ls colours

if which dircolors >/dev/null 2>&1 && [ -e ~/.dircolors ]; then
  sh_load_status "dircolors"
  eval `dircolors -b ~/.dircolors`
fi

# }}}
# {{{ Key bindings

sh_load_status "key bindings"

set -o emacs # vi sucks ;-)
bind '"\ep":history-search-backward'
bind '"\en":history-search-forward'
bind '"\e\C-i":dynamic-complete-history'

# }}}
# {{{ Prompt

sh_load_status "prompt"
PS1="\u@\h \[\033[1m\]\\w\[\033[0m\] \\$ "
# This only helps when the non-interactive script is being run from an
# interactive bash, because this file doesn't get run for
# non-interactive shells.  In zsh, PS4 is set to something else, so
# use my bx function instead.
export PS4="+\D{%Y/%m/%d %T} \${BASH_SOURCE/\$HOME/\~}@\${LINENO}(\${FUNCNAME[0]}): "

# }}}
# {{{ Aliases and functions

sh_load_status "aliases/functions"

# {{{ ls aliases

if ls -F --color >&/dev/null; then
    alias ls='command ls -F --color'
elif ls -F >&/dev/null; then
    alias ls='command ls -F'
elif ls --color >&/dev/null; then
    alias ls='command ls --color'
fi

# jeez I'm lazy ...
alias l='ls -lh'
alias ll='ls -l'
alias la='ls -lha'
alias lla='ls -la'
alias lsa='ls -ah'
alias lsd='ls -d'
alias lsh='ls -dh .*'
alias lsr='ls -Rh'
alias ld='ls -ldh'
alias lt='ls -lth'
alias llt='ls -lt'
alias lrt='ls -lrth'
alias llrt='ls -lrt'
alias lart='ls -larth'
alias llart='ls -lart'
alias lr='ls -lRh'
alias llr='ls -lR'
alias lsL='ls -L'
alias lL='ls -Ll'
alias lS='ls -lSh'
alias lrS='ls -lrSh'
alias llS='ls -lS'
alias llrS='ls -lrS'
alias sl=ls # often screw this up

# }}}
# {{{ which/where

alias wh='type -a'

# }}}
# {{{ File management

# {{{ Changing/making/removing directory

alias cd..='cd ..'
alias cd...='cd ../..'
alias cd....='cd ../../..'
alias cd.....='cd ../../../..'
alias cd......='cd ../../../../..'
z () {
    cd ~/"$@"
}

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

# }}}
# {{{ Job/process control

alias j='jobs -l'

# }}}
# {{{ Terminals

alias vx='export TERM=xterm-color'
alias v1='export TERM=vt100'
alias v2='export TERM=vt220'
alias cls='clear'
alias term='echo $TERM'

# }}}
# {{{ History

alias h='history $LINES'

# }}}
# {{{ Other users

alias f=finger

# }}}
# {{{ Other programs

# {{{ less

if ! which less >&/dev/null; then
    alias less=more
fi

alias v=less

# }}}
# {{{ editors

if which emacs >/dev/null 2>&1; then
    e () {
        emacs "$@" 2>&1 &
    }
fi

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

# }}}

echo -e -n "\r\e[0K"

fi

. $ZDOT_RUN_HOOKS .bashrc.d

: .bashrc ends # for debugging with -x
