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

path=( $path /usr/local/bin /usr/local/sbin /usr/sbin /sbin )
path=( $zdotdir/{packbin,bin,bin/{backgrounds,palm,shortcuts}}(N) $path )

# }}}
# {{{ Perl libraries

[[ "$ZSH_VERSION_TYPE" == 'old' ]] || typeset -T PERL5LIB perl5lib
typeset -U perl5lib
export PERL5LIB
perl5lib=( 
          ~/lib/perl5{/site_perl,}{/5.*,}{/i?86*,}(NOn)
          ~/lib/perl5(N)
          $perl5lib
         )

# }}}
# {{{ Ruby libraries

[[ "$ZSH_VERSION_TYPE" == 'old' ]] || typeset -T RUBYLIB rubylib
typeset -U rubylib
export RUBYLIB
rubylib=( 
          ~/lib/ruby{/site_ruby,}{/1.*,}{/i?86*,}(NOn)
          ~/lib/ruby(N)
          $rubylib
         )

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
