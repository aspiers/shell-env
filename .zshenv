#!/bin/zsh
#
# Adam's zshenv startup file
#
# This gets run even for non-interactive shells;
# keep it as fast as possible.

# {{{ Environment

# {{{ Path

# No duplicates
typeset -U path

path=( $path /usr/local/sbin /usr/sbin /sbin )
if [[ -d ~/packbin ]]; then
  path=( ~/packbin $path )
fi

if [[ -d ~/bin ]]; then
  path=( ~/bin $path )
fi

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

# }}}
# {{{ Specific to hosts

if [[ -r $HOME/.zshenv.local ]]; then
  . $HOME/.zshenv.local
fi

if [[ -r $HOME/.zshenv.${HOST%%.*} ]]; then
  . $HOME/.zshenv.${HOST%%.*}
fi

# }}}
