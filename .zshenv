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
# 
# N.B. This is for zsh-specific environment stuff.  Put generic,
# portable environment settings in .shared_env instead, so that they
# take effect for bash and ksh.

# Allow disabling of entire environment suite
[ -n "$INHERIT_ENV" ] && return 0

# Stop bad system-wide scripts interfering.
setopt NO_global_rcs 

# {{{ What version are we running?

shell=zsh

ZSH_VERSION_TYPE=new

# }}}

# {{{ zdotdir

# ZDOTDIR is a zsh-ism but it's a good concept so we generalize it to
# the other shells.

# This allows us to have a good set of .*rc files etc. in one place
# and to be able to reuse that from a different account (e.g. root).

# We have to do some of this both here and in .shared_env to avoid
# a chicken and egg thing when looking for the right .shared_env.

zdotdir=${ZDOTDIR:-$HOME}
export ZDOTDIR="$zdotdir"

# }}}

[[ -e $zdotdir/.shared_env ]] && . $zdotdir/.shared_env

sh_load_status ".zshenv already started before .shared_env"

setopt extended_glob

sh_load_status "search paths"

# {{{ prevent duplicates in path variables

# path and manpath are special - "hardcoded" tie with $(MAN)PATH
typeset -U path
typeset -U manpath

typeset -TU LD_LIBRARY_PATH ld_library_path
typeset -TU PERL5LIB perl5lib

# }}}
# {{{ Perl libraries

# FIXME: move to .shared_env?

export PERL5LIB
[[ -n "$OTHER_USER" ]] && \
    perl5lib=( $ZDOTDIR/{local/,}lib/[p]erl5{,/site_perl}(N) $perl5lib )
perl5lib=( ~/{local/,}lib/[p]erl5{,/site_perl}(N) $perl5lib )

# }}}
# {{{ Ruby libraries

typeset -TU RUBYLIB rubylib
export RUBYLIB
rubylib=( 
          ~/lib/[r]uby{/site_ruby,}{/1.*,}{/i?86*,}(N)
          ~/lib/[r]uby(N)
          $rubylib
         )

# }}}
# {{{ Python libraries

typeset -TU PYTHONPATH pythonpath
export PYTHONPATH
pythonpath=( 
          ~/{local/,}lib/[p]ython*{/site-packages,}(N)
          $pythonpath
         )

# }}}

# {{{ fpath/autoloads

sh_load_status "fpath/autoloads"

fpath=(
       $zdotdir/{.[z]sh/$ZSH_VERSION/*.zwc,{.[z]sh,[l]ib/zsh}/{functions{,.local,.$HOST},scripts}}(N)

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
    $zdotdir/.zsh*) fns=( $dirname/*~*~(-N.x:t) ) ;;
                 *) fns=( $dirname/*~*~(-N.:t)  ) ;;
  esac
  (( $#fns )) && autoload "$fns[@]"
done

# }}}

# {{{ Specific to hosts

run_hooks .zshenv.d

# }}}
