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

# {{{ zdotdir

zdotdir=${ZDOTDIR:-$HOME}
export ZDOTDIR="$zdotdir"

# }}}

[[ -e $zdotdir/.shared_env ]] && . $zdotdir/.shared_env

# {{{ path

# No duplicates
typeset -U path

# notice nasty hack for old zsh
path=( $path /usr/local/bin /usr/local/sbin /usr/sbin /sbin /[u]sr/X11R6/bin )
path=( $zdotdir/{[l]ocal/bin,[p]ackbin,[b]in,[b]in/{backgrounds,palm,shortcuts}}(N) $path )

# }}}
# {{{ Perl libraries

[[ "$ZSH_VERSION_TYPE" == 'old' ]] || typeset -T PERL5LIB perl5lib
typeset -U perl5lib
export PERL5LIB
perl5lib=( 
          ~/{local/,}lib/[p]erl5{/site_perl,}{/5.*,}{/i?86*,}(N)
          ~/{local/,}lib/[p]erl5(N)
          $perl5lib
         )
[[ "$ZSH_VERSION_TYPE" == 'old' ]] && PERL5LIB="${(j/:/)perl5lib}"

# }}}
# {{{ Ruby libraries

[[ "$ZSH_VERSION_TYPE" == 'old' ]] || typeset -T RUBYLIB rubylib
typeset -U rubylib
export RUBYLIB
rubylib=( 
          ~/lib/[r]uby{/site_ruby,}{/1.*,}{/i?86*,}(N)
          ~/lib/[r]uby(N)
          $rubylib
         )
[[ "$ZSH_VERSION_TYPE" == 'old' ]] && RUBYLIB="${(j/:/)rubylib}"

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
