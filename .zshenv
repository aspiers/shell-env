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

# {{{ INPUTRC

# no crappy RedHat inputrcs, thankyouverymuch.  Which fucking *idiot*
# set convert-meta to off?
unset INPUTRC

# }}}
# {{{ LD_PRELOAD

# Fix obscure gtk problem
#LD_PRELOAD=/usr/lib/libgdk.so:/usr/lib/libgtk.so

# }}}
# {{{ Path

# No duplicates
typeset -U path

path=( $path /usr/local/bin /usr/local/sbin /usr/sbin /sbin )
path=( ~/{packbin,bin,bin/{backgrounds,palm,shortcuts}}(N) $path )

# }}}
# {{{ Perl libraries

[[ "$ZSH_VERSION_TYPE" == 'old' ]] || typeset -T PERL5LIB perl5lib
typeset -U perl5lib
export PERL5LIB
perl5lib=( 
          ~/lib/perl5{/site_perl,}{/5.*,}{/i?86*,}(N)
          ~/lib/perl5(N)
          $perl5lib
         )

# }}}
# {{{ Ruby libraries

[[ "$ZSH_VERSION_TYPE" == 'old' ]] || typeset -T RUBYLIB rubylib
typeset -U rubylib
export RUBYLIB
rubylib=( 
          ~/lib/ruby{/site_ruby,}{/1.*,}{/i?86*,}(N)
          ~/lib/ruby(N)
          $rubylib
         )

# }}}
# {{{ IRC

export IRCNAME='Adam Spiers'
export IRCNICK='Adam'

# }}}
# {{{ Editor

export EDITOR=emacs
export VISUAL=fe

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
# {{{ Palm Pilot

export PILOTRATE=115200
export PILOTPORT=/dev/pilot

# }}}
# {{{ rsync uses ssh

export RSYNC_RSH=ssh

# }}}
# {{{ cvs uses ssh

export CVS_RSH=ssh

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
