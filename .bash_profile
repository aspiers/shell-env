# Adam's .bash_profile
#
# for those shitty times when zsh isn't to hand
#
# $Id$

# .bash_profile is invoked in preference to .profile by interactive
# login shells, and by non-interactive shells with the --login option.

# Allow disabling of all meddling with the environment
[ -n "$INHERIT_ENV" ] && return 0

if [ -f ~/.bashrc ]; then
  # Get the normal interactive stuff from .bashrc
  . ~/.bashrc
fi

. ${ZDOTDIR:-$HOME}/.zsh/functions/run_hooks .bash_profile.d

