# Adam's .bash_profile
#
# for those shitty times when zsh isn't to hand
#
# $Id$

# .bash_profile is invoked by login shells in preference to .profile

# {{{ Fix broken keyboards

# This wouldn't work when ssh'ing to a remote machine from the console
#if [ -z "$DISPLAY" ] && [ "$TERM" = 'linux' ]; then

case `tty` in
  /dev/tty[0-9])
    echo "Fixing broken keyboard ..."
    echo -e "keymaps 0-15
             keycode 58 = Control
             keycode 29 = Caps_Lock" | loadkeys
  ;;
esac

# }}}

# {{{ Get the normal interactive stuff from .bashrc

if [ -f ~/.bashrc ]; then
  . ~/.bashrc
fi

# }}}

# {{{ Specific to hosts

[ -r ~/.bash_profile.local ] && . ~/.bash_profile.local
[ -r ~/.bash_profile.$ ] && . ~/.bash_profile.local

# }}}
