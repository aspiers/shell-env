# Adam's .bash_profile
#
# for those shitty times when zsh isn't to hand
#
# $Id$

# .bash_profile is invoked by login shells in preference to .profile

# {{{ Get the normal interactive stuff from .bashrc

if [ -f ~/.bashrc ]; then
  . ~/.bashrc
fi

# }}}

# {{{ Specific to hosts

. ${ZDOTDIR:-$HOME}/.zsh/functions/run_local_hooks .bash_profile

# }}}

