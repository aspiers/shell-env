#!/bin/zsh
#
# .zshenv
# for zsh 3.1.6 and newer (may work OK with earlier versions)
#
# by Adam Spiers <adam@spiers.net>
#
# Best viewed in emacs folding mode (folding.el).
# (That's what all the # {{{ and # }}} are for.)
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

# {{{ zdotdir

zdotdir=${ZDOTDIR:-$HOME}
export ZDOTDIR="$zdotdir"
if [[ "$ZDOTDIR" == "$HOME" ]]; then
  zdotdirpath=( $ZDOTDIR )
else
  zdotdirpath=( $ZDOTDIR $HOME )
  export OTHER_USER=1
fi

# }}}

[[ -e $zdotdir/.shared_env ]] && . $zdotdir/.shared_env

setopt extended_glob

# {{{ path

typeset -U path # No duplicates

# notice nasty hack for old zsh
path=( $path /usr/local/bin /usr/local/sbin /usr/sbin /sbin /[u]sr/X11R6/bin(N) )
path=( $zdotdir/{[l]ocal/bin,[p]ackbin,[b]in,[b]in/{backgrounds,palm,shortcuts}}(N) $path )

# }}}
# {{{ manpath

typeset -U manpath # No duplicates

# }}}
# {{{ fpath/autoloads

fpath=(
       $zdotdir/{.[z]sh/*.zwc,{.[z]sh,[l]ib/zsh}/{functions,scripts}}(N) 

       $fpath

       # very old versions
       /usr/doc/zsh*/[F]unctions(N)
      )

# Autoload shell functions from all directories in $fpath.  Restrict
# functions from $zdotdir/.zsh to ones that have the executable bit
# on.  (The executable bit is not necessary, but gives you an easy way
# to stop the autoloading of a particular shell function).
#
# The ':t' is a history modifier to produce the tail of the file only,
# i.e. dropping the directory path.  The 'x' glob qualifier means
# executable by the owner (which might not be the same as the current
# user).

for dirname in $fpath; do
  case "$dirname" in
    $zdotdir/.zsh*) fns=( $dirname/*~*~(N.x:t) ) ;;
                 *) fns=( $dirname/*~*~(N.:t)  ) ;;
  esac
  (( $#fns )) && autoload "$fns[@]"
done

#[[ "$ZSH_VERSION_TYPE" == 'new' ]] || typeset -gU fpath

# }}}
# {{{ LD_LIBRARY_PATH

[[ "$ZSH_VERSION_TYPE" == 'old' ]] ||
  typeset -T LD_LIBRARY_PATH ld_library_path

typeset -U ld_library_path # No duplicates

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

# {{{ Specific to hosts

run_local_hooks .zshenv

# }}}
