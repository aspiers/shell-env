#!/bin/zsh
#
# Adam's zshenv startup file
#
# This gets run even for non-interactive shells;
# keep it as fast as possible.

# {{{ What version are we running?

if [[ $ZSH_VERSION == 3.0.<->* ]]; then ZSH_STABLE_VERSION=yes; fi
if [[ $ZSH_VERSION == 3.1.<->* ]]; then ZSH_DEVEL_VERSION=yes;  fi

ZSH_VERSION_TYPE=old
if [[ $ZSH_VERSION == 3.1.<6->* ||
      $ZSH_VERSION == 3.<2->.<->*  ||
      $ZSH_VERSION == 4.<->* ]]
then
  ZSH_VERSION_TYPE=new
fi

# }}}
# {{{ Environment

# {{{ LD_PRELOAD

# Fix obscure gtk problem
LD_PRELOAD=/usr/lib/libgdk.so:/usr/lib/libgtk.so

# }}}
# {{{ Path

# No duplicates
typeset -U path

path=( $path /usr/local/bin /usr/local/sbin /usr/sbin /sbin )
if [[ -d ~/packbin ]]; then
  path=( ~/packbin $path )
fi

if [[ -d ~/bin ]]; then
  path=( ~/bin $path )
fi

# }}}
# {{{ Mail

export MAIL=~/mail/inboxes/Mailbox

# }}}
# {{{ Perl libraries

[[ "$ZSH_VERSION_TYPE" == 'old' ]] || typeset -T PERL5LIB perl5lib
typeset -U perl5lib
export PERL5LIB
perl5lib=( 
          ~/lib/perl{/site_perl,}{/5.*,}{/i?86*,}(N)
          ~/lib/perl(N)
          $perl5lib
         )

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
# {{{ POSIXLY_CORRECT for patch

#export POSIXLY_CORRECT=yes

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
