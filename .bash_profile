# Adam's .bash_profile
#
# for those shitty times when zsh isn't to hand
#
# $Id$

# .bash_profile is invoked by login shells in preference to .profile

# {{{ Fix broken keyboards

if [ -z "$DISPLAY" ] && [ "$TERM" = 'linux' ]; then
  echo -e "keymaps 0-15
           keycode 58 = Control
           keycode 29 = Caps_Lock" | loadkeys
fi

# }}}
# {{{ User specific environment and startup programs

for newpath in ~/bin ~/bin/{shortcuts,palm,backgrounds} \
               ~/local/bin /sbin /usr/sbin /usr/local/sbin; do
  [ -d $newpath ] && PATH=$newpath:$PATH
done

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
