#!/bin/zsh
#
# Adam's zshenv startup file
#
# This gets run even for non-interactive shells;
# keep it as fast as possible.

# {{{ Environment

# {{{ Path

# No duplicates
typeset -U path

path=( $path /usr/local/sbin /usr/sbin /sbin )
if [[ -d ~/packbin ]]; then
	path=( ~/packbin $path )
fi

if [[ -d ~/bin ]]; then
	path=( ~/bin $path )
fi

# }}}
# {{{ IRC

export IRCNAME='Adam Spiers'
export IRCNICK='Adze'

# }}}
# {{{ Pnews

# Lots of cool options including a slight hack on the -X option
export TRNINIT='-a -B -d~/news -f -F"> " -m=u -M -OsD -p -s -S -T -v -x6ls -X2\
\
 -/'

# These make the editor open the original article in another
# buffer; quite handy.
export MAILPOSTER='QUOTECHARS=%I Rnmail -h %h %A'
export NEWSPOSTER='QUOTECHARS=%I Pnews -h %h %A'

# Improved header for follow-ups.
export NEWSHEADER='%(%[followup-to]=^$?:X-ORIGINAL-NEWSGROUPS: %n\
)Newsgroups: %(%F=^$?%C:%F)\
Subject: %(%S=^$?%"\n\nSubject: ":Re: %S)\
Summary:\
Expires:\
%(%R=^$?:References: %R\
)Sender: Adam Spiers <adam@spiers.net>\
Followup-To: %(%F=^$?%C:%F)\
Reply-To: adam@spiers.net \(Adam Spiers\)\
Distribution: %(%i=^$?%"Distribution: ":%D)\
Organization: %o\
Keywords: %[keywords]\
Cc: \n\n'

# Make sure that DOTDIR is a fully expanded pathname
# (i.e. no ~)
export DOTDIR=${HOME}/news
export SAVESCOREFILE=${DOTDIR}/scores
export SCOREDIR=${DOTDIR}/scores
export NEWSORG='no'
#export NEWSORG='Not very much, unfortunately'

# Default to article scan (scoring) mode rather than
# thread mode when entering a newsgroup.
export GROUPDEFAULT=';+ynq'

# I'm not a luser, damnit.
export FAST_PNEWS=y

# }}}
# {{{ Editor

export EDITOR=emacs
export VISUAL='emacs -nw'

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

# }}}
# {{{ Specific to hosts

if [[ -r $HOME/.zshenv.local ]]; then
    . $HOME/.zshenv.local
fi

if [[ -r $HOME/.zshenv.${HOST%%.*} ]]; then
	. $HOME/.zshenv.${HOST%%.*}
fi

# }}}
