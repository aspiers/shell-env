# Adam's .bash_profile
#
# for those shitty times when zsh isn't to hand
#
# $Id$

# Get the normal interactive stuff
if [ -f ~/.bashrc ]; then
  . ~/.bashrc
fi

# User specific environment and startup programs

[ -d ~/bin ]       && PATH=$HOME/bin:$PATH
[ -d ~/local/bin ] && PATH=$HOME/local/bin:$PATH

#ENV=$HOME/.bashrc
USERNAME=""

export USERNAME ENV PATH

[ -e ~/.bash_profile.local ] && . ~/.bash_profile.local

. ~/.switch_shell
