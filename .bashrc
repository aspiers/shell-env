# Adam's .bashrc
#
# for those shitty times when zsh isn't to hand
#
# $Id$

# User specific aliases and functions

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

# {{{ Key bindings

bind '"\ep":history-search-backward'
bind '"\en":history-search-forward'

# }}}
# {{{ Prompt

PS1="\u@\h \[\033[1m\]\\w\[\033[0m\] \$ "

# }}}
# {{{ Aliases and functions

# {{{ ls aliases

alias ls='/bin/ls --color -F'
# jeez I'm lazy ...
alias l='ls -l'
alias la='ls -la'
alias lsa='ls -a'
alias lsh='ls -d .*'
alias ld='ls -ld'
# damn, missed out lsd :-)

# }}}
# {{{ File management

# {{{ Changing/making/removing directory

alias cd..='cd ..'
alias cd...='cd ../..'
alias cd....='cd ../../..'
alias cd.....='cd ../../../..'
alias cd......='cd ../../../../..'
alias cd/='cd /'

alias md='mkdir -p'
alias rd=rmdir

alias dirs='dirs -v'
alias d=dirs

# Don't need this because auto_pushd is set
#alias pu=pushd

alias po=popd
alias pwd='pwd -r'

# }}}
# {{{ finding out disk hogs

# {{{ du1 (du with depth 1)

du1 () {
  du "$@" | egrep -v '/.*/'
  # Another idea from Bart Schaefer, which I need to fix
  # to take parameters
  #du -s *(/)
}

# }}}
# {{{ fbig

# Find big files

fbig () {
  ls -alFR "$@" | sort -rn -k5 | less -r
}

# }}}
# {{{ fbigrpms

# Find rpms which take lots of space

alias fbigrpms='rpm --qf "%{SIZE}\t%{NAME}\n" -qa | sort -nr | less'

# }}}

# }}}
# {{{ Use this to untar after doing a tar ztvf/tvf/ztf command

# Thanks to Bart Schaefer for this one
alias xt='fc -e - tvf=xf ztf=zxf -1'

# }}}

# }}}
# {{{ Job/process control

alias j='jobs -l'
alias mps='ps -o user,pcpu,command'
pst () {
  pstree -p "$@" | less -S
}
which gps >&/dev/null && alias gps='gitps -p afx; cx'
alias ra='ps auxww | grep -vE "(^($USERNAME|nobody|root|bin))|login"'
rj () {
  ps auxww | grep -E "($*|^USER)"
}
ru () {
  ps auxww | grep -E "^($*|USER)" | grep -vE "^$USERNAME|login"
}

# }}}
# {{{ Other users

lh () {
  last "$@" | head
}

alias f=finger

# }}}
# {{{ Other programs

# {{{ less

alias v=less

# }}}
# {{{ CVS

if which cvs >&/dev/null; then
  cvst () {
    perl -MGetopt::Std -wl -- - "$@" <<'End_of_Perl'
      $dir = '';
      getopts('av', \%opts);
      $| = 1;
      open(CVS, "cvs -n status @ARGV 2>&1 |") or die "cvs status failed: $!\n";
      open(STDERR, ">&STDOUT") or die "Can't dup stdout";
      while (<CVS>) {
        chomp;
        if (/cvs (?:status|server): Examining (.*)/) {
          $dir = "$1/";
        } elsif (/^File:\s+(.*)\s+Status:\s+(.*)/) {
          ($file, $status) = ($1, $2);
          next if ($status eq 'Up-to-date' && ! $opts{'a'});
          $str = "File: $dir$file";
          print $str, ' ' x (45 - length($str)), "Status: $status";
        } elsif (/revision/ && $opts{'v'}) {
          next if ($status eq 'Up-to-date' && ! $opts{'a'});
          print;
        } elsif (/^cvs status:/ || /password:/i) {
          print;
        }
      }
      close(CVS);
End_of_Perl
  }

  cvsd () {
    cvs diff -N "$@" 2>&1 | less
  }

  # see new stuff
  cvsn () {
    cvs diff -rBASE -rHEAD "$@" 2>&1 | egrep -v 'tag BASE is not in file' | less
  }

  cvsl () {
    cvs log "$@" 2>&1 | less
  }

### BEGIN PRIVATE
  cvsll () {
    rcs2log \
      -u "adam	Adam Spiers	adam@spiers.net" \
      -u "localadams	Adam Spiers	adam@spiers.net" \
      -u "adams	Adam Spiers	aspiers@guideguide.com" \
      "$@" | less
  }

### END PRIVATE
  cvss () {
    cvs status "$@"
  }

  alias cvsv='cvst -av'

  cvs () {
    quiet='-q'
    [[ "$*" == *status* ]] && quiet=''
    command cvs $quiet "$@"
  }

  cvsu () {
    cvs update "$@"
  }

  cvsup () {
    cvsu "$@"
  }

  cvsq () {
    cvs -nq update "$@" 2>&1 | grep -v -- '-- ignored'
  }
fi

# }}}
# {{{ editors

e () {
  emacs "$@" 2>&1 &
}

alias fe='emacs -nw --eval "(setq make-backup-files nil)"'
alias pico='/usr/bin/pico -z'

# }}}
# {{{ ftp

if which lftp >&/dev/null; then
  alias ftp=lftp
elif which ncftp >&/dev/null; then
  alias ftp=ncftp
fi

# }}}
# {{{ watching log files

alias tf='less +F'

# }}}

# }}}

# }}}

[ -e ~/.switch_shell ] && . ~/.switch_shell
